# Aula 02 - Desafio 02.01 - Exercícios Práticos
> Os exercícios práticos do desafio incluem:
> - Criar um Dockerfile para um ambiente de análise de dados
> - Construir e publicar imagens Docker
> - Implementar um ambiente multi-container com Docker Compose
> - Realizar debug de containers
> - Otimizar imagens Docker
> 
> ## Atividade 1: Primeiro Container ##
> - Criar um container com Python e Jupyter
> - Mapear um volume local para persistência
> - Expor a porta correta para acesso ao Jupyter
> - Executar uma análise simples dentro do container
>         
> ## Atividade 2. Construção de Imagens ##
> 
> - Criar um Dockerfile para ambiente de análise de dados com:
>   1. Python
>     1. Pandas
>     1. Jupyter
>     1. numpy
>     1. matplotlib
>     1. scikit-learn
>     1. psycopg2-binary
> 
> - Otimizar o Dockerfile usando multi-stage builds
> - Publicar a imagem no Docker Hub
>     
> ## Atividade 3. Network e Volumes ## 
> - Criar uma rede Docker
> - Conectar múltiplos containers:
>     1. Jupyter Notebook
>     1. PostgreSQL
>     1. Adminer
> - Configurar volumes persistentes
> - Realizar backup dos dados

# :star: Gabarito

##  Atividade :one: - **Primeiro Container**

### :mag_right: Objetivo:

Criar um container com `Python` e `Jupyter`, mapear um volume local, expor a porta correta e executar uma análise simples.

### :books: Passos:

Siga o passo a passo para concluir a atividade.


#### :bookmark: **Criar um diretório para o projeto**:

```bash
mkdir DevOps-UC01-Docker-04
cd DevOps-UC01-Docker-04
```

#### :bookmark: **Executar um container com Jupyter**:
   
Use a imagem oficial do `Jupyter` e mapeie um volume local para persistência de dados:
       

**Explicando os argumentos:**

| Argumento | Explicação |
|-----------|------------|
|-d              |   Executa o container em segundo plano. |
|--name jupyter  | Nomeia o container. |
|-p 8888:8888    | Mapeia a porta **8888** do host para a porta **8888** do container. |
|-v $(pwd)\notebooks/:/home/jovyan/work | Mapeia um **volume local** para persistir os notebooks. |

**Verificando se o container está sendo executado:**

#### :bookmark: **Acessar o Jupyter Notebook**:

- Verifique o token de acesso no log do container:
     ```bash
     docker logs jupyter
     ```
     
- O comando deve gerar uma saída semelhante à:

    ```
    To access the server, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/jpserver-7-open.html
    Or copy and paste one of these URLs:
        http://66aa9289d1d9:8888/lab?token=38418486112ad5664c53b70d3c196fa86f4afbe2c892422e
        http://127.0.0.1:8888/lab?token=38418486112ad5664c53b70d3c196fa86f4afbe2c892422e
     ```
     
   - Acesse o Jupyter no navegador: `http://localhost:8888`.

#### :bookmark: **Executar uma análise simples**:

- Crie um novo notebook no Jupyter.

- Execute o seguinte código para uma análise simples com Pandas:
     ```python
     import pandas as pd
     data = {'Nome': ['Alice', 'Bob', 'Charlie'], 'Idade': [25, 30, 35]}
     df = pd.DataFrame(data)
     print(df)
     ```

#### :bookmark: **Parar o container**:


---

## Atividade :two: -  **Construção de Imagens**

### :mag_right:  Objetivo:
Criar um Dockerfile para um ambiente de análise de dados com Python, Pandas e Jupyter, otimizar com multi-stage builds e publicar no Docker Hub.

### :books: Passos:

#### :bookmark:  **Dockerfile** 

**Explicação das Instruções**

|Parâmetro | Explicação|
|----------|-----------|
| FROM      |  Especifica a imagem base. Exemplo: python:3.9-slim. | 
| WORKDIR   |  Define o diretório de trabalho dentro do container. | 
| COPY      |  Copia arquivos do host para o container. | 
| RUN       |  Executa comandos durante a construção da imagem. | 
| EXPOSE    |  Expõe uma porta para comunicação externa. | 
| CMD       |  Define o comando padrão executado quando o container é iniciado. | 

#### :bookmark:  **requirements.txt**

Adicione as dependências necessárias:

```powershell
code requirements.txt
```

Adicione o seguinte conteúdo ao arquivo 

```
pandas
jupyter
numpy
matplotlib
scikit-learn
psycopg2-binary
```

#### :bookmark:  **Construir a imagem**:
Execute o comando para construir a imagem:

#### :bookmark:  **Publicar no Docker Hub**:

## Atividade :three: - **Network e Volumes**

### :mag_right: Objetivo:

Criar uma rede Docker, conectar múltiplos containers (Jupyter, PostgreSQL, Adminer), configurar volumes persistentes e realizar backup dos dados.

### :books: Passos:

#### :bookmark: **Criar uma rede Docker**:

#### :bookmark: **Criar um arquivo `docker-compose.yml`**:

#### :bookmark: **Executar o ambiente**:

#### :bookmark: **Acessar os serviços**:

- Jupyter Notebook: [http://localhost:8888](http://localhost:8888)

Verificando o log do container do Jupyter para obter o hash de acesso:

```
docker logs devops-uc01-docker-04-jupyter-1
```


```
 To access the server, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/jpserver-7-open.html
    Or copy and paste one of these URLs:
        http://78e60c1c8516:8888/lab?token=41931b14fdabe2ede6ea972d192fdc19900786f19156a524
        http://127.0.0.1:8888/lab?token=41931b14fdabe2ede6ea972d192fdc19900786f19156a524
```

- Adminer (interface para PostgreSQL): `http://localhost:8080`


#### :bookmark: **Configurar volumes persistentes**:
   - Os dados do PostgreSQL são persistidos no volume `postgres-data`.
   - Os notebooks são persistidos no diretório `./notebooks`.

#### :bookmark: **Realizar backup dos dados**:

   - Para fazer backup dos dados do PostgreSQL, use o comando:
     ```bash
     docker exec -t $(docker-compose ps -q postgres) pg_dump -U user data_db > backup.sql
     ```
     
   - Para restaurar o backup:
     ```bash
     cat backup.sql | docker exec -i $(docker-compose ps -q postgres) psql -U user data_db
     ```








