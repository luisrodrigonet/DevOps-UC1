# Aula 02 - Desafio 02.02 - Exercícios Práticos
> Os exercícios práticos do desafio incluem:
> - Criar um Dockerfile para um ambiente de análise de dados
> - Construir e publicar imagens Docker
> - Implementar um ambiente multi-container com Docker Compose
> - Realizar debug de containers
> - Otimizar imagens Docker
> 
> ## Atividade 1. Ambiente Completo de Análise
> - Criar docker-compose.yml com:
>     1. Jupyter Notebook
>     1. PostgreSQL
>     1. pgAdmin
>     1. Streamlit para visualização
> - Configurar networks isoladas
> - Implementar healthchecks
> - Criar scripts de inicialização
>     
> ## Atividade 2. Otimização e Debug
> - Analisar logs dos containers
> - Implementar métricas de monitoramento
> - Otimizar tamanho das imagens
> - Configurar restart policies

# :star: Gabarito

## Atividade 1: Ambiente Completo de Análise

**Objetivo**: Criar um ambiente Docker com **Jupyter**, **PostgreSQL**, **pgAdmin**, **Streamlit**, redes isoladas, `healthchecks` e scripts de inicialização.

### 1. **Estrutura de Arquivos**:
```
analise_dados/
├── docker-compose.yml
├── jupyter/
│   ├── Dockerfile
│   └── notebooks/
├── postgres/
│   └── init.sql
└── streamlit/
    ├── Dockerfile
    └── app.py
```

Criando os diretórios

```powershell
mkdir -p d:\_devops\DevOps-UC1-Desafio2.2
cd d:\_devops\DevOps-UC1-Desafio2.2
mkdir jupyter 
mkdir postgres 
mkdir streamlit
tree .
```

A estrutura deve estar semelhante à: 

```
analise_dados
    ├───jupyter
    ├───postgres
    └───streamlit
```

### 2. **Jupyter**

1. Crie o arquivo `jupyter/Dockerfile`

2. Adicione o seguinte conteúdo ao arquivo: 

3. Crie o diretório `jupyter/notebooks` que conterá os notebooks criados utilizando-se o Jupyter


### 3. **Streamlit**

1. Crie o arquivo `streamlit/Dockerfile`

1. Criando um exemplo de App Streamlit (`streamlit/app.py`):

    ```
    code streamlit/app.py
    ```

1. Adicione o seguinte conteúdo:

    ```python
    import streamlit as st
    import psycopg2
    
    conn = psycopg2.connect(
        dbname="analytics",
        user="admin",
        password="admin",
        host="postgres",
        port="5432"
    )
    
    cur = conn.cursor()
    cur.execute("SELECT * FROM data")
    rows = cur.fetchall()
    
    st.title("Dados do PostgreSQL")
    st.write(rows)
    ```

### 4. **PostgreSQL**

1. Criando o Script de Inicialização do PostgreSQL (`postgres/init.sql`):

    ```
    code postgres/init.sql
    ```
    
    Adicione o seguinte conteúdo:
    
    ```sql
    -- Exemplo: Criar tabela de exemplo
    CREATE TABLE IF NOT EXISTS data (
        id SERIAL PRIMARY KEY,
        value FLOAT NOT NULL
    );
    ```

### 5. **docker-compose.yml**

1. Criando o arquivo `docker-compose.yml`

1. Iniciando os containers 

1. **Verificando os containers**

1. **Acessando os serviços**:

    - **pgadmin** - [http://127.0.0.1:5050/](http://127.0.0.1:5050/)
    
        - **Acesso** 
            - **Username** : admin@admin.com
            - **Senha** : admin
            
         - **Novo Servidor**
            - **Nome**: postgres
            - **Host name**: postgres
            - **Username**: admin
            - **Password**: admin
           
            
    - **streamlit** - [http://127.0.0.1:8501](http://127.0.0.1:8501)
    
    - **jupyter** - [http://127.0.0.1:8888/](http://127.0.0.1:8888/)
    

## Atividade 2: Otimização e Debug

### 1. **Analisar Logs**

- Listando os logs de todos os serviços
    
- Listando os logs de todos os serviços de forma contínua

- Listando os logs de um serviço específico

### 2. **Monitoramento com cAdvisor**

1. Edite o arquivo `docker-compose.yml`

1. Adicione ao `docker-compose.yml`:

1. Reinicie o ambiente 

1. Verificando os logs da aplicação


1. Acessando o serviço

    - cadvisor - [http://127.0.0.1:8080/](http://127.0.0.1:8080/)


### 3. **Otimização de Imagens**

- **Jupyter**: Use `jupyter/minimal-notebook` como base.

- **Streamlit**: Use estágios de construção (multi-stage build):
  ```dockerfile
  # Estágio de construção
  FROM python:3.8-slim AS builder
  RUN pip install pandas psycopg2-binary --user

  # Estágio final
  FROM python:3.8-slim
  COPY --from=builder /root/.local /root/.local
  RUN pip install streamlit
  WORKDIR /app
  COPY app.py .
  CMD ["streamlit", "run", "app.py"]
  ```

### 4. **Políticas de Reinício**:

As políticas de reinício (restart policies) no Docker definem como os containers devem se comportar quando são encerrados (intencionalmente ou por falhas). Elas são essenciais para garantir **alta disponibilidade** e **resiliência** de aplicações em ambientes de produção

O Docker oferece quatro políticas principais:

| Política          | Descrição                                                                                     |
|--------------------|-----------------------------------------------------------------------------------------------|
| **no**           | **Padrão**: Não reinicia o container, mesmo após falhas.                                      |
| **on-failure**   | Reinicia **apenas se o container falhar** (código de saída diferente de `0`).                 |
| **always**       | **Sempre reinicia**, independentemente do motivo da parada (exceto se explicitamente interrompido). |
| **unless-stopped**| Reinicia automaticamente, **a menos que o container tenha sido explicitamente parado** pelo usuário. |

**Diferenças entre as políticas**

| Política          | Reinicia após falha? | Reinicia após sucesso? | Sobrevive a reinício do Docker Daemon? | Comportamento após `docker stop` |
|--------------------|----------------------|------------------------|----------------------------------------|----------------------------------|
| **no**           | ❌                   | ❌                     | ❌                                    | ❌                              |
| **on-failure**   | ✅                   | ❌                     | ❌ (apenas se configurado com `--restart`) | ❌                              |
| **always**       | ✅                   | ✅                     | ✅                                    | ✅ (reinicia após Daemon reiniciar) |
| **unless-stopped**| ✅                   | ✅                     | ✅                                    | ❌ (não reinicia se parado manualmente) |


Evite usar `always` para containers que dependem de recursos externos (ex: um banco de dados que precisa estar disponível). Prefira `unless-stopped` para evitar reinícios desnecessários após manutenção planejada.

No `docker-compose.yml`, adicione a todos os serviços:
```yaml
restart: unless-stopped
```

### 5. **Debug de Conexões**:

- Liste as redes:
    ```bash
    docker network ls
    ```
    
    ```text
    NETWORK ID     NAME                            DRIVER    SCOPE
    59b2e435d7d8   bridge                          bridge    local
    e1226e342568   devops-uc1-desafio22_backend    bridge    local
    ab2314ce5c48   devops-uc1-desafio22_frontend   bridge    local
    9b5cb6e48016   host                            host      local
    8efafeef44bb   minha-rede                      bridge    local
    dd122d7680b6   none                            null      local
    9d033380f092   projeto_default                 bridge    local
    ```

- Verifique redes:
  ```bash
  docker network inspect devops-uc1-desafio22_frontend
  ```
  
  
  ```text
  [
        {
            "Name": "devops-uc1-desafio22_frontend",
            "Id": "ab2314ce5c489ff8cc5b33dea25f75a1b6b2b2a5671a15e41c564e9df92dfdd1",
            "Created": "2025-03-26T14:51:48.332075984Z",
            "Scope": "local",
            "Driver": "bridge",
            "EnableIPv4": true,
            "EnableIPv6": false,
            "IPAM": {
                "Driver": "default",
                "Options": null,
                "Config": [
                    {
                        "Subnet": "172.19.0.0/16",
                        "Gateway": "172.19.0.1"
                    }
                ]
            },
            "Internal": false,
            "Attachable": false,
            "Ingress": false,
            "ConfigFrom": {
                "Network": ""
            },
            "ConfigOnly": false,
            "Containers": {
                "1c3d58215da5df3f6eaaeeb517e3a50433f8a717b2819dcf54074014a2913735": {
                    "Name": "cadvisor",
                    "EndpointID": "f2363b2622ff1fd736c30e48d2ad643d5cb449b7f6a285c9fca5d72b4207ee74",
                    "MacAddress": "7e:9d:09:b4:1d:83",
                    "IPv4Address": "172.19.0.2/16",
                    "IPv6Address": ""
                },
                "42d7a609246d4bffaabf3ab3b9770a1c04acb108d64ec50df91ac626a9797b2a": {
                    "Name": "pgadmin",
                    "EndpointID": "be0cdf3f3fddcc84ae124cd007e47b09efc6355a2fd6533075dcc4c89b8eeba2",
                    "MacAddress": "a6:3a:b3:ad:ec:19",
                    "IPv4Address": "172.19.0.4/16",
                    "IPv6Address": ""
                },
                "7ff8873a42d35bfce26d85fde18a3cefa2414f359a4f6d7c9fad822aa0abb85f": {
                    "Name": "streamlit",
                    "EndpointID": "e276ebcc97ff89c6944b5ddfa82893ff71b83a605ed9ab9d341cb9922286851c",
                    "MacAddress": "de:88:23:6e:65:b0",
                    "IPv4Address": "172.19.0.3/16",
                    "IPv6Address": ""
                }
            },
            "Options": {},
            "Labels": {
                "com.docker.compose.config-hash": "d6d3a87fb7104f18d3cd8e3fda125b9963ac738ef08aaad5d73b2d39fdf018f4",
                "com.docker.compose.network": "frontend",
                "com.docker.compose.project": "devops-uc1-desafio22",
                "com.docker.compose.version": "2.33.1"
            }
        }
    ]
  ```
  
- Teste conexão manualmente:
  ```bash
  docker-compose exec -it postgres sh
  ```
  
  ```bash
  ping jupyter
  ```
  
  ```text
  PING jupyter (172.20.0.4): 56 data bytes
    64 bytes from 172.20.0.4: seq=0 ttl=64 time=0.882 ms
    64 bytes from 172.20.0.4: seq=1 ttl=64 time=0.247 ms
    64 bytes from 172.20.0.4: seq=2 ttl=64 time=0.072 ms
    64 bytes from 172.20.0.4: seq=3 ttl=64 time=0.063 ms
    64 bytes from 172.20.0.4: seq=4 ttl=64 time=0.118 ms
    64 bytes from 172.20.0.4: seq=5 ttl=64 time=0.073 ms
    64 bytes from 172.20.0.4: seq=6 ttl=64 time=0.072 ms
    64 bytes from 172.20.0.4: seq=7 ttl=64 time=0.056 ms
    64 bytes from 172.20.0.4: seq=8 ttl=64 time=0.053 ms
    64 bytes from 172.20.0.4: seq=9 ttl=64 time=0.057 ms
    64 bytes from 172.20.0.4: seq=10 ttl=64 time=0.054 ms
    64 bytes from 172.20.0.4: seq=11 ttl=64 time=0.073 ms
    64 bytes from 172.20.0.4: seq=12 ttl=64 time=0.121 ms
    64 bytes from 172.20.0.4: seq=13 ttl=64 time=0.089 ms
    64 bytes from 172.20.0.4: seq=14 ttl=64 time=0.073 ms
    64 bytes from 172.20.0.4: seq=15 ttl=64 time=0.061 ms
    64 bytes from 172.20.0.4: seq=16 ttl=64 time=0.445 ms
    64 bytes from 172.20.0.4: seq=17 ttl=64 time=0.073 ms
    64 bytes from 172.20.0.4: seq=18 ttl=64 time=0.072 ms
    64 bytes from 172.20.0.4: seq=19 ttl=64 time=0.060 ms
    64 bytes from 172.20.0.4: seq=20 ttl=64 time=0.083 ms
    64 bytes from 172.20.0.4: seq=21 ttl=64 time=0.082 ms
    64 bytes from 172.20.0.4: seq=22 ttl=64 time=0.230 ms
    64 bytes from 172.20.0.4: seq=23 ttl=64 time=0.056 ms
    64 bytes from 172.20.0.4: seq=24 ttl=64 time=0.141 ms
    64 bytes from 172.20.0.4: seq=25 ttl=64 time=0.180 ms
    ^C
    --- jupyter ping statistics ---
    26 packets transmitted, 26 packets received, 0% packet loss
    round-trip min/avg/max = 0.053/0.137/0.882 ms
  ```
  

---

### **Notas Finais**:
- **Redes**: `backend` (dados) e `frontend` (UI) isolam o tráfego.
- **Healthchecks**: Garantem que dependências estejam saudáveis.
- **Otimização**: Imagens Alpine e multi-stage reduzem tamanho.
- **Monitoramento**: cAdvisor fornece métricas em tempo real.


