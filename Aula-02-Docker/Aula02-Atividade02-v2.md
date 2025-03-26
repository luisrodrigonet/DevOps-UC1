# Aula 02 - Atividade 02 - Dockerfile e Docker Compose
> O Docker é uma tecnologia que possibilita a criação, distribuição e execução de aplicações de forma isolada por meio de contêineres.
>
> Nesta atividade, exploraremos o uso de `Dockerfile` e `Docker Compose`, demonstrando como configurar um ambiente utilizando estas ferramentas que facilitam a implantação e o gerenciamento dos serviços.


## :one: `Dockerfile`: Estrutura e Sintaxe

Um `Dockerfile` é um arquivo de texto que contém instruções para construir uma imagem `Docker` **personalizada**. 

Ele define o ambiente necessário para executar uma aplicação, incluindo dependências, configurações e comandos. 

**Cada instrução** no Dockerfile cria **uma camada na imagem**, tornando o processo eficiente e reproduzível.

### :books: **Sintaxe Básica do Dockerfile**

As instruções mais comuns são:

| Instrução | Descrição |
|-----------|-----------|
| **FROM**      | Define a imagem base (ex: `python:3.9-slim`)      |
| **RUN**       | Executa comandos durante a construção da imagem.  |
| **COPY**      | Copia arquivos do host para a imagem.             |
| **WORKDIR**   | Define o diretório de trabalho.                   |
| **ENV**       | Configura variáveis de ambiente.                  |
| **EXPOSE**    | Expõe portas para acesso externo.                 |
| **CMD**       | Define o comando padrão ao iniciar o container.   |

### :books: **Exemplo: Dockerfile para Análise de Dados com Jupyter**

#### :bookmark: **Objetivo**: 

- Criar uma imagem Docker com:
    - Python 3.9
    - Bibliotecas de análise de dados (`pandas`, `numpy`, `matplotlib`).
    - Jupyter Lab para desenvolvimento interativo.

#### :bookmark:  **Passo a Passo**

##### 1. **Criar o Dockerfile**

```
mkdir .\DevOps-UC01-Docker-02\
cd .\DevOps-UC01-Docker-02\
code Dockerfile
```

```dockerfile
# Usar uma imagem base leve do Python
FROM python:3.9-slim

# Atualizar o sistema e instalar dependências necessárias
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Definir variáveis de ambiente
ENV PYTHONUNBUFFERED=1 \
    JUPYTER_PORT=8888

# Definir diretório de trabalho
WORKDIR /app

# Copiar requirements.txt e instalar pacotes
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Expor a porta do Jupyter
EXPOSE $JUPYTER_PORT

# Comando para iniciar o Jupyter Lab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
```

**Ações executadas pelo `dockfile`**

1. Seleciona a imagem
2. Atualiza o sistema e instala as dependências
3. Define as variáveis de ambiente
4. Define o diretório de trabalho do container
5. Copia o arquivo requirements.txt para o diretório de trabalho do container
6. Realiza a instalação da dependências (pacotes) indicados no arquivo requirements.txt
7. Exporta a porta utilizada pela aplicação Jupyter
8. Define o comando que será executado sempre que o container for iniciado, neste caso será iniciado o Jupyter

**Sobre o conteúdo de configuração:**

-` PYTHONUNBUFFERED=1` é utilizada para desativar o buffering (armazenamento temporário) da saída padrão (stdout) e da saída de erro (stderr) em scripts Python. Isso significa que as mensagens geradas pelo programa (como print() ou logs) são exibidas imediatamente, sem esperar que o buffer seja liberado.

##### 2. **Criar o Arquivo `requirements.txt`**

Um vez criado o arquivo `dockerfile` devemos criar o arquivo com as informações sobre as dependências necessárias para que a aplicação Jupyter seja executada

```powershell
code requirements.txt
```

```txt
jupyterlab
pandas
numpy
matplotlib
scikit-learn
```

##### 3. **Estrutura do Projeto**

Neste ponto, temos na pasta do projeto, a seguinte estrutura:

```
DevOps-UC01-Docker-02/
├── Dockerfile
└── requirements.txt
```

---

#### :bookmark: **Construir e Executar a Imagem**

##### 1. **Construir a Imagem**
```bash
docker build -t jupyter-devops-01 .
```

```
[+] Building 65.7s (11/11) FINISHED                                        docker:desktop-linux
 => [internal] load build definition from Dockerfile                                       0.1s
 => => transferring dockerfile: 750B                                                       0.0s
 => [internal] load metadata for docker.io/library/python:3.9-slim                         2.1s
 => [auth] library/python:pull token for registry-1.docker.io                              0.0s
 => [internal] load .dockerignore                                                          0.0s
 => => transferring context: 2B                                                            0.0s
 => [1/5] FROM docker.io/library/python:3.9-slim@sha256:e52ca5f579cc58fed41efcbb55a0ed5dc  4.6s
 => => resolve docker.io/library/python:3.9-slim@sha256:e52ca5f579cc58fed41efcbb55a0ed5dc  0.0s
 => => sha256:6e909acdb790c5a1989d9cfc795fda5a246ad6664bb27b5c688e2b734 28.20MB / 28.20MB  1.6s
 => => sha256:cec49b84de9df5777ee48546b2fd933b7ae87ec6746f4aa181d68931753 3.51MB / 3.51MB  0.6s
 => => sha256:da1cbe0d584f421af08256ce9d3d64b361a433126b700d76ac42c23da 14.93MB / 14.93MB  1.2s
 => => sha256:e52ca5f579cc58fed41efcbb55a0ed5dccf6c7a156cba76acfb4ab42f 10.41kB / 10.41kB  0.0s
 => => sha256:246e088f8d9bae1efc1d3f0ab4a800616403520b3aecd810f30e27dc9d6 1.75kB / 1.75kB  0.0s
 => => sha256:bea3dea871787412b8fa17205b317e46dd3f37bdfb1952d602229072621 5.28kB / 5.28kB  0.0s
 => => sha256:9a95d1744747ce9c4e854b9f5822065468265f57a58dae4d8fcec30f1e60216 249B / 249B  0.8s
 => => extracting sha256:6e909acdb790c5a1989d9cfc795fda5a246ad6664bb27b5c688e2b734b2c5fad  1.5s
 => => extracting sha256:cec49b84de9df5777ee48546b2fd933b7ae87ec6746f4aa181d6893175331a21  0.2s
 => => extracting sha256:da1cbe0d584f421af08256ce9d3d64b361a433126b700d76ac42c23da4259346  0.8s
 => => extracting sha256:9a95d1744747ce9c4e854b9f5822065468265f57a58dae4d8fcec30f1e60216f  0.0s
 => [internal] load build context                                                          0.1s
 => => transferring context: 94B                                                           0.0s
 => [2/5] RUN apt-get update &&     apt-get install -y --no-install-recommends     build  12.7s
 => [3/5] WORKDIR /app                                                                     0.0s
 => [4/5] COPY requirements.txt .                                                          0.0s
 => [5/5] RUN pip install --no-cache-dir -r requirements.txt                              42.3s
 => exporting to image                                                                     3.5s
 => => exporting layers                                                                    3.5s
 => => writing image sha256:bf69b40689984d369eaae22181dfa6380c3edd2b32bd79a8d2cef2dfa9d8b  0.0s
 => => naming to docker.io/library/jupyter-devops-01                                       0.0s

View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/prdwoxshwm96sic8rftcl3jpm

What's next:
    View a summary of image vulnerabilities and recommendations → docker scout quickview
```

##### 2. **Executar o Container**

Para executar o `container` com a imagem recém criada podemos utilizar o comando abaixo:

```bash
docker run -p 8888:8888 --name jupyter-devops -v ".\notebooks:/app/notebooks" jupyter-devops-01
```

**Onde**:
- **`-p 8888:8888`**: Mapeia a porta do `container` para o host.
- **`-v .\notebooks:/app/notebooks`**: Monta um volume para salvar os notebooks.

Observe que o LOG gerado pelo `container` é apresentado na tela e ele é indicada a `URL` e o `Token` e de acesso o `Jupyter`

```
[C 2025-03-25 14:29:03.707 ServerApp]
    To access the server, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/jpserver-1-open.html
    Or copy and paste one of these URLs:
        http://9a21bde346bd:8888/lab?token=b388a10958e21ce8caf5e001d3e243f90e623f1251016cfd
        http://127.0.0.1:8888/lab?token=b388a10958e21ce8caf5e001d3e243f90e623f1251016cfd
```

##### 3. **Acessar o Jupyter Lab**
Abra no navegador:
```
http://localhost:8888
```

---

#### :bookmark: **Explicação Detalhada do Dockerfile**

1. **Imagem Base (`FROM`)**:
   - `python:3.9-slim` é uma imagem leve com Python pré-instalado.

2. **Instalação de Dependências (`RUN`)**:
   - Atualiza o sistema e instala `build-essential` (necessário para compilar bibliotecas) e `curl`.

3. **Variáveis de Ambiente (`ENV`)**:
   - `PYTHONUNBUFFERED=1` garante que a saída do Python não seja bufferizada.
   - `JUPYTER_PORT` define a porta padrão do Jupyter.

4. **Instalação de Pacotes Python**:
   - Copia o `requirements.txt` e instala as bibliotecas usando `pip`.

5. **Comando Final (`CMD`)**:
   - Inicia o Jupyter Lab acessível em todas as interfaces de rede (`--ip=0.0.0.0`).


## :two: **Dockerfiler: Boas Práticas**

1. **Use Imagens Oficiais**:
   - Prefira imagens oficiais (ex: `python:3.9-slim`) para segurança e eficiência.

2. **Minimize Camadas**:
   - Combine comandos `RUN` usando `&&` para reduzir o número de camadas.

3. **Limpe Cache**:
   - Remova arquivos temporários (`rm -rf /var/lib/apt/lists/*`) para reduzir o tamanho da imagem.

4. **Evite Executar como Root**:
   - Adicione um usuário não-root (ex: `RUN useradd -m appuser && USER appuser`).

5. **Use `.dockerignore`**:
   - Ignore arquivos desnecessários (ex: `__pycache__`, `.git`).

    - Exemplo de `.dockerignore`
        ```txt
        .git
        __pycache__
        *.pyc
        .env
        ```

---

#### **Dockerfiler: Segurança**

a) **Evite Executar como Root**

    - **Por quê?** Containers executados como `root` têm privilégios elevados, o que é um risco de segurança.
    
    - **Como implementar**:
      ```dockerfile
      # Crie um usuário e grupo dedicados
      RUN groupadd -r analyst && useradd -r -g analyst analyst
      USER analyst
      WORKDIR /home/analyst/app
        ```

b) **Use Imagens Oficiais e Verificadas**

    - **Por quê?** Imagens não oficiais podem conter vulnerabilidades.
    
    - **Exemplo**:
      ```dockerfile
      # Use tags específicas (evite "latest")
      FROM python:3.9-slim@sha256:45b23dee08af5e43a7fea6c4cf9c25ccf269ee113...
      ```

c) **Atualize Pacotes do Sistema**

    - **Por quê?** Versões desatualizadas podem ter falhas críticas.
    
    - **Como implementar**:
      ```dockerfile
      RUN apt-get update && apt-get upgrade -y \
          && apt-get install -y --no-install-recommends \
              build-essential \
          && rm -rf /var/lib/apt/lists/*
      ```


#### **Dockerfiler: Eficiência**

a) **Multi-Stage Builds**

    - **Por quê?** Reduz o tamanho da imagem final ao separar dependências de construção e runtime.
    
    - **Exemplo**:
      ```dockerfile
      # Estágio de construção (instala dependências)
      FROM python:3.9 as builder
      COPY requirements.txt .
      RUN pip install --user -r requirements.txt
    
      # Estágio final (imagem leve)
      FROM python:3.9-slim
      COPY --from=builder /root/.local /root/.local
      ENV PATH=/root/.local/bin:$PATH
      ```

b) **Minimize o Número de Camadas**

    - **Por quê?** Cada instrução `RUN`, `COPY`, ou `ADD` cria uma nova camada. Camadas excessivas aumentam o tamanho da imagem.
    
    - **Como implementar**:
      ```dockerfile
      # Combine comandos relacionados em um único RUN
      RUN apt-get update && apt-get install -y \
          curl \
          git \
          && rm -rf /var/lib/apt/lists/*
      ```

c) **Use `.dockerignore`**

    - **Por quê?** Evita a cópia de arquivos desnecessários (como cache do Python ou envs).
    
    - **Exemplo de `.dockerignore`**:
      ```txt
      **/__pycache__
      .git
      .env
      *.log
      ```

#### **Dockerfiler:  Manutenção e Legibilidade**

a) **Documente com `LABEL`**

    - **Por quê?** Facilita a identificação da imagem e seu propósito.
    
    - **Exemplo**:
      ```dockerfile
      LABEL maintainer="seu.email@provedor.com"
      LABEL description="Imagem para análise de dados com Jupyter"
      ```

b) **Fixar Versões de Dependências**

    - **Por quê?** Evita quebras inesperadas por atualizações de pacotes.
    
    - **Exemplo em `requirements.txt`**:
      ```txt
      pandas==2.0.3
      numpy==1.24.3
      jupyterlab==4.0.3
      ```

---

#### **Dockerfiler:  Otimização de Cache**

a) **Ordene Instruções Estrategicamente**

    - **Por quê?** O Docker armazena o cache de cada camada. Coloque instruções que mudam com menos frequência no início.
    
    - **Exemplo**:
      ```dockerfile
      # 1. Instala dependências do sistema (mudam raramente)
      COPY requirements.txt .
      RUN pip install -r requirements.txt
    
      # 2. Copia o código (muda frequentemente)
      COPY . .
      ```
---

#### **Exemplo Atualizado**

Arquivo `dockerfile`

```
code dockerfile
```

```dockerfile
# Estágio de construção
#FROM python:3.9-slim AS builder
FROM python:3.12-slim AS builder

# Atualiza pacotes e instala dependências de compilação
RUN apt-get update && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

# Estágio final
#FROM python:3.9-slim
FROM python:3.12-slim

# Cria usuário não-root
RUN groupadd -r analyst && useradd -r -g analyst analyst \
    && mkdir /app && chown analyst:analyst /app

# Copia dependências instaladas do estágio de construção
COPY --from=builder --chown=analyst:analyst /root/.local /home/analyst/.local
ENV PATH=/home/analyst/.local/bin:$PATH

# Define variáveis de ambiente
ENV PYTHONUNBUFFERED=1 \
    JUPYTER_PORT=8888  


WORKDIR /app
USER analyst

# Expõe porta e define comando padrão
EXPOSE $JUPYTER_PORT

# Comando para iniciar o Jupyter Lab
#CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

CMD ["sh", "-c", \
    "jupyter lab --port=${JUPYTER_PORT} --no-browser --ip=0.0.0.0 \
    --NotebookApp.password='' --allow-root"]
```


**Construindo a imagem atualizada**

```bash
docker build -t jupyter-devops-02 .
```

```text
[+] Building 1.0s (13/13) FINISHED                                         docker:desktop-linux
 => [internal] load build definition from Dockerfile                                       0.0s
 => => transferring dockerfile: 1.35kB                                                     0.0s
 => [internal] load metadata for docker.io/library/python:3.12-slim                        0.7s
 => [internal] load .dockerignore                                                          0.1s
 => => transferring context: 2B                                                            0.0s
 => [builder 1/5] FROM docker.io/library/python:3.12-slim@sha256:a866731a6b71c4a194a845d8  0.0s
 => [internal] load build context                                                          0.0s
 => => transferring context: 37B                                                           0.0s
 => CACHED [stage-1 2/4] RUN groupadd -r analyst && useradd -r -g analyst analyst     &&   0.0s
 => CACHED [builder 2/5] RUN apt-get update && apt-get upgrade -y     && apt-get install   0.0s
 => CACHED [builder 3/5] WORKDIR /app                                                      0.0s
 => CACHED [builder 4/5] COPY requirements.txt .                                           0.0s
 => CACHED [builder 5/5] RUN pip install --user -r requirements.txt                        0.0s
 => CACHED [stage-1 3/4] COPY --from=builder --chown=analyst:analyst /root/.local /home/a  0.0s
 => CACHED [stage-1 4/4] WORKDIR /app                                                      0.0s
 => exporting to image                                                                     0.1s
 => => exporting layers                                                                    0.0s
 => => writing image sha256:47ff4713d5e9941e8c6302daaf221f224f27fbfef247aebcd52bd4dc57730  0.0s
 => => naming to docker.io/library/jupyter-devops-02                                       0.1s

View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/l9f3cg8ad5qo46zycunaeffwk

 1 warning found (use docker --debug to expand):
 - SecretsUsedInArgOrEnv: Do not use ARG or ENV instructions for sensitive data (ENV "JUPYTER_TOKEN") (line 28)

What's next:
    View a summary of image vulnerabilities and recommendations → docker scout quickview
```

Criando um container com a nova imagem

```bash
docker run -p 8888:8888 --name jupyter-devops-02 -v ".\notebooks:/app/notebooks" jupyter-devops-02
```

#### Enviando a imagem para o Registry - Docker Hub

```powershell
docker login
docker tag jupyter-devops-02 luisrodrigonet/jupyter-devops-02:latest
docker push luisrodrigonet/jupyter-devops-02:latest
```

```text
The push refers to repository [docker.io/luisrodrigonet/jupyter-devops-02]
5f70bf18a086: Mounted from localstack/localstack
d49bd2f4f78e: Pushed
887abc4d8911: Pushed
9ae9750f0b5d: Mounted from library/python
a38884fb0360: Mounted from library/python
3629edeced43: Mounted from library/python
1287fbecdfcc: Mounted from library/python
latest: digest: sha256:744bc1e5a597cb3ba303531667af3e2d7848a7be94616a00582985c5cd98a9ec size: 1786
```


#### Verificação de Vulnerabilidades
Use ferramentas como **Docker Scout** ou **Trivy** para escanear imagens:

```bash
docker scout quickview jupyter-devops-02
```

```text
The push refers to repository [docker.io/luisrodrigonet/jupyter-devops-02]
5f70bf18a086: Mounted from localstack/localstack
d49bd2f4f78e: Pushed
887abc4d8911: Pushed
9ae9750f0b5d: Mounted from library/python
a38884fb0360: Mounted from library/python
3629edeced43: Mounted from library/python
1287fbecdfcc: Mounted from library/python
latest: digest: sha256:744bc1e5a597cb3ba303531667af3e2d7848a7be94616a00582985c5cd98a9ec size: 1786
PS D:\_devops\DevOps-UC01-Docker-02> docker scout quickview jupyter-devops-02
    v SBOM of image already cached, 298 packages indexed

    i Base image was auto-detected. To get more accurate results, build images with max-mode provenance attestations.
      Review docs.docker.com ↗ for more information.

  Target     │  jupyter-devops-02:latest           │    0C     0H     0M    28L
    digest   │  55250c21e659                       │
  Base image │  oisupport/staging-amd64:3.12-slim  │    0C     0H     0M    28L

What's next:
    View vulnerabilities → docker scout cves jupyter-devops-02
    Include policy results in your quickview by supplying an organization → docker scout quickview jupyter-devops-02 --org <organization>
```


---

#### **Resumo das Melhores Práticas**
| Categoria           | Ação                             | Benefício                               |
|----------------------|----------------------------------|-----------------------------------------|
| **Segurança**        | Usar usuário não-root           | Reduz riscos de privilégio              |
| **Eficiência**       | Multi-stage builds              | Imagens menores (~80% de redução)       |
| **Manutenção**       | Fixar versões de pacotes        | Evita quebras inesperadas               |
| **Otimização**       | Ordenar camadas estrategicamente| Acelera tempo de construção             |

---

Com estas práticas, sua imagem será:
- **Segura**: Minimiza vetores de ataque.
- **Leve**: Reduz o tamanho em até 80% com multi-stage.
- **Reproduzível**: Dependências versionadas garantem consistência.
- **Auditável**: Labels e histórico claros facilitam manutenção.

---

## :three: Dockerfile: Multi-Stage Builds

Multi-Stage Builds são uma funcionalidade do Docker que permite dividir o processo de construção de uma imagem em estágios independentes. Cada estágio começa com uma instrução `FROM` e pode utilizar uma imagem base diferente. O objetivo principal é otimizar a imagem final, reduzindo seu tamanho e eliminando dependências desnecessárias (como ferramentas de compilação), mantendo apenas o essencial para a execução da aplicação.

### **Benefícios dos Multi-Stage Builds**
1. **Redução do tamanho da imagem**: Ferramentas de compilação e arquivos temporários ficam restritos aos estágios iniciais.
2. **Segurança aprimorada**: A imagem final não contém bibliotecas ou ferramentas sensíveis usadas durante a construção.
3. **Organização do Dockerfile**: Separa claramente as etapas de construção e execução.

### **Exemplo: Construindo uma Imagem para Análise de Dados com Jupyter**

#### **Requisitos**
- Docker instalado.
- Arquivo `requirements.txt` com as dependências Python.

#### **Passo a Passo**

##### 1. **Estrutura do Projeto**
Crie uma pasta com os seguintes arquivos:
```
meu_projeto/
├── Dockerfile
└── requirements.txt
```

##### 2. **Conteúdo do `requirements.txt`**
```txt
jupyter
numpy
pandas
matplotlib
scikit-learn
```

##### 3. **Dockerfile**

```dockerfile
# Estágio 1: Construção (Builder)
FROM python:3.9 as builder

WORKDIR /app

# Cria um ambiente virtual para instalação das dependências
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copia e instala as dependências
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# --------------------------------------------

# Estágio 2: Imagem Final (Runtime)
FROM python:3.9-slim

# Instala dependências de sistema necessárias
RUN apt-get update && apt-get install -y --no-install-recommends \
    libgl1-mesa-glx \  # Necessário para matplotlib
    libgomp1 \         # Necessário para bibliotecas paralelas (ex: scikit-learn)
    && rm -rf /var/lib/apt/lists/*

# Copia o ambiente virtual do estágio anterior
COPY --from=builder /opt/venv /opt/venv

# Define variáveis de ambiente para usar o ambiente virtual
ENV PATH="/opt/venv/bin:$PATH"

# Configuração do Jupyter
EXPOSE 8888
WORKDIR /notebooks

# Comando para iniciar o Jupyter
CMD ["jupyter", "notebook", "--ip='0.0.0.0'", "--port=8888", "--no-browser", "--allow-root"]
```

**Explicação Detalhada:**

- **Estágio 1 (`builder`)**:
  - Usa a imagem completa do Python 3.9 para instalar dependências.
  - Cria um ambiente virtual (`/opt/venv`) para isolar os pacotes Python.
  - Instala as dependências listadas no `requirements.txt`, incluindo Jupyter e bibliotecas de análise de dados.
  
- **Estágio 2 (`runtime`)**:
  - Usa a imagem `python:3.9-slim` (menor e mais segura).
  - Instala dependências de sistema necessárias (ex: `libgl1-mesa-glx` para visualização com `matplotlib`).
  - Copia o ambiente virtual do estágio `builder`, garantindo que todas as bibliotecas Python estejam disponíveis.
  - Expõe a porta 8888 (usada pelo Jupyter) e define o diretório de trabalho.

---

##### 4. **Construa a Imagem**
Execute no terminal:
```bash
docker build -t jupyter-data-analysis .
```

##### 5. **Execute o Container**
```bash
docker run -p 8888:8888 -v $(pwd)/notebooks:/notebooks jupyter-data-analysis
```
- `-p 8888:8888`: Mapeia a porta do container para a porta local.
- `-v $(pwd)/notebooks:/notebooks`: Monta um volume para persistir os notebooks.

##### 6. **Acesse o Jupyter**
Abra o navegador em `http://localhost:8888` e use o token exibido no terminal.

---

### **Otimizações e Considerações**

1. **Tamanho da Imagem**:
   - A imagem final terá apenas as dependências de runtime, economizando espaço (ex: a imagem `python:3.9-slim` tem ~120MB, contra ~900MB da imagem completa).

2. **Segurança**:
   - Evite usar `--allow-root` em produção. Crie um usuário dedicado no Dockerfile:
     ```dockerfile
     RUN useradd -m jupyter-user
     USER jupyter-user
     ```

3. **Dependências de Sistema**:
   - Se surgirem erros de bibliotecas faltantes, identifique os pacotes necessários usando `ldd` ou documentação das bibliotecas Python.


Multi-Stage Builds são ideais para criar imagens eficientes e seguras. Nesta atividade, combinamos a instalação de dependências complexas em um estágio inicial e entregamos uma imagem mínima com Jupyter e ferramentas de análise de dados. 

---

## :four: Docker Compose

O **Docker Compose** permite definir e executar aplicações multi-contêiner com um arquivo `YAML`.

Nesta atividade realizaremos a criação de um ambiente de análise de dados usando `Docker Compose`. O ambiente garantirá persistência de dados via **volumes** e comunicação entre containers via **rede** personalizada.

### 4.1 Estrutura do Projeto 1


Criando diretório base:

```powershell
mkdir .\DevOps-UC01-Docker-03
cd .\DevOps-UC01-Docker-03
```

Estrutura do projeto:

```
DevOps-UC01-Docker-03/
├── docker-compose.yml
├── Dockerfile        (opcional, para customizações do Jupyter)
└── notebooks/        (diretório para persistir os notebooks)
```

---

### 4.2. Arquivo `docker-compose.yml`

O `Docker Compose` permite definir serviços, redes e volumes em um único arquivo.  
Crie o arquivo `docker-compose.yml` com o seguinte conteúdo:

```powershell
code docker-compose.yml
```

```yaml
#version: '3.8'

# Serviços (containers)
services:
  # Jupyter Notebook
  jupyter:
    image: jupyter/datascience-notebook:latest
    container_name: jupyter
    ports:
      - "8888:8888"
    volumes:
      - ./notebooks:/home/jovyan/work  # Persistência dos notebooks
    environment:
      - JUPYTER_TOKEN=senha123  # Senha de acesso (opcional)
    networks:
      - data-network
    depends_on:
      - db  # Garante que o PostgreSQL inicie primeiro

  # Banco de Dados PostgreSQL
  db:
    image: postgres:13
    container_name: postgres
    environment:
      - POSTGRES_USER=admin
      - POSTGRES_PASSWORD=admin123
      - POSTGRES_DB=analytics
    volumes:
      - postgres-data:/var/lib/postgresql/data  # Volume para persistência do banco
    networks:
      - data-network
    ports:
      - "5432:5432"  # Expor porta (opcional para acesso externo)

  # Adminer (Interface Web para PostgreSQL)
  adminer:
    image: adminer:latest
    container_name: adminer
    ports:
      - "8080:8080"
    networks:
      - data-network
    depends_on:
      - db

# Redes e Volumes
volumes:
  postgres-data:  # Volume nomeado para o PostgreSQL

networks:
  data-network:  # Rede personalizada para comunicação entre containers
```

#### Explicação dos Componentes:

- **Serviços**:
  - `jupyter`: Usa a imagem oficial do `Jupyter Data Science` (inclui pandas, numpy, etc).
  - `db`: PostgreSQL com variáveis de ambiente para usuário, senha e banco.
  - `adminer`: Interface web para gerenciar o PostgreSQL.
  
- **Volumes**:
  - `postgres-data`: Armazena dados do PostgreSQL mesmo após reiniciar o container.
  - `./notebooks`: Diretório local sincronizado com o container do Jupyter.

- **Rede**:
  - `data-network`: Permite que os containers se comuniquem pelo nome do serviço (ex: `db:5432`).
  
  

### 4.3 Criando o ambiente

Iniciando os containers
 
```bash
docker-compose up -d
```

Os containers serão iniciados e conectados via rede `data-network`.

```text
[+] Running 4/4
 ✔ Network devops-uc01-docker-03_data-network  Created                      0.0s
 ✔ Container postgres                          Started                      0.4s
 ✔ Container adminer                           Started                      0.6s
 ✔ Container jupyter                           Started                      0.7s
```

Verificando se os containers estão sendo executados

```powershell
docker ps
```

Lista dos containers ativos

```text
CONTAINER ID   IMAGE                                 COMMAND                  CREATED          STATUS                    PORTS                    NAMES
bb7e3bc93939   jupyter/datascience-notebook:latest   "tini -g -- start-no…"   55 seconds ago   Up 54 seconds (healthy)   0.0.0.0:8888->8888/tcp   jupyter
cd8196195a88   adminer:latest                        "entrypoint.sh docke…"   55 seconds ago   Up 54 seconds             0.0.0.0:8080->8080/tcp   adminer
30ac378b77b3   postgres:13                           "docker-entrypoint.s…"   55 seconds ago   Up 55 seconds             0.0.0.0:5432->5432/tcp   postgres
```

Teste o ambiente acessando as urls abaixo:

- Adminer - [http://127.0.0.1:8080/](http://127.0.0.1:8080/)
- Jupyter - [http://127.0.0.1:8888/](http://127.0.0.1:8888/)


---

### 4.4. Dockerfile Personalizado

Se precisar instalar bibliotecas adicionais no Jupyter, por exemplo a biblioteca `psycopg2`, podemos criar um `Dockerfile` para personalizar a imagem original.


```powershell
code Dockerfile
```

```Dockerfile
FROM jupyter/datascience-notebook:latest

RUN pip install psycopg2-binary
```

Em seguida,  `docker-compose.yml`, substituimos a linha que aponta imagem para uma linha que realiza o build, ou seja, devemos remover a linha abaixo:

```
image: jupyter/datascience-notebook:latest
```

e no seu lugar devemos adicionar:

```
build: .
```

Desta forma a versão atualizada do arquivo `docker-compose` ficará assim:

```powershell
code docker-compose.yml
```

```yaml
# Serviços (containers)
services:
  # Jupyter Notebook
  jupyter:
    build: .
    container_name: jupyter
    ports:
      - "8888:8888"
    volumes:
      - .\notebooks:/home/jovyan/work
    environment:
      - JUPYTER_TOKEN=senha123  # Senha de acesso (opcional)
      - TZ=America/Sao_Paulo
    networks:
      - data-network
    depends_on:
      - db  # Garante que o PostgreSQL inicie primeiro

  # Banco de Dados PostgreSQL
  db:
    image: postgres:13
    container_name: postgres
    environment:
      - POSTGRES_USER=admin
      - POSTGRES_PASSWORD=admin123
      - POSTGRES_DB=analytics
    volumes:
      - postgres-data:/var/lib/postgresql/data  # Volume para persistência do banco
    networks:
      - data-network
    ports:
      - "5432:5432"  # Expor porta (opcional para acesso externo)

  # Adminer (Interface Web para PostgreSQL)
  adminer:
    image: adminer:latest
    container_name: adminer
    ports:
      - "8080:8080"
    networks:
      - data-network
    depends_on:
      - db

# Redes e Volumes
volumes:
  postgres-data:  # Volume nomeado para o PostgreSQL

networks:
  data-network:  # Rede personalizada para comunicação entre containers
```

**Iniciando o Ambiente**

No terminal, execute na pasta do projeto:

```bash
docker-compose up -d
```

```
Just set COMPOSE_BAKE=true
[+] Building 4.6s (7/7) FINISHED                                           docker:desktop-linux
 => [jupyter internal] load build definition from Dockerfile                               0.1s
 => => transferring dockerfile: 116B                                                       0.0s
 => [jupyter internal] load metadata for docker.io/jupyter/datascience-notebook:latest     0.0s
 => [jupyter internal] load .dockerignore                                                  0.0s
 => => transferring context: 2B                                                            0.0s
 => [jupyter 1/2] FROM docker.io/jupyter/datascience-notebook:latest                       0.6s
 => [jupyter 2/2] RUN pip install psycopg2-binary                                          3.6s
 => [jupyter] exporting to image                                                           0.1s
 => => exporting layers                                                                    0.1s
 => => writing image sha256:957b870ef374e5ffb6debc010d2114b336dfb1b6b37beca28df2fd940d55a  0.0s
 => => naming to docker.io/library/devops-uc01-docker-03-jupyter                           0.0s
 => [jupyter] resolving provenance for metadata file                                       0.0s
[+] Running 5/5
 ✔ jupyter                                     Built                                       0.0s
 ✔ Network devops-uc01-docker-03_data-network  Created                                     0.1s
 ✔ Container postgres                          Started                                     0.5s
 ✔ Container jupyter                           Started                                     0.7s
 ✔ Container adminer                           Started                                     0.6s
```

Os containers serão iniciados e conectados via rede `data-network`.


```powershell
docker ps
```

```text
CONTAINER ID   IMAGE                           COMMAND                  CREATED              STATUS                        PORTS                    NAMES
03c10c8686cf   devops-uc01-docker-03-jupyter   "tini -g -- start-no…"   About a minute ago   Up About a minute (healthy)   0.0.0.0:8888->8888/tcp   jupyter
7f20eb27fc2f   adminer:latest                  "entrypoint.sh docke…"   About a minute ago   Up About a minute             0.0.0.0:8080->8080/tcp   adminer
cea49ed950a8   postgres:13                     "docker-entrypoint.s…"   About a minute ago   Up About a minute             0.0.0.0:5432->5432/tcp   postgres
```

**Acessando os Serviço**s

- **Jupyter Notebook**: `http://localhost:8888` (use o token `senha123`).

- **Adminer**: `http://localhost:8080`  
  - **Sistema**: PostgreSQL
  - **Servidor**: `db` (nome do serviço PostgreSQL)
  - **Usuário/Senha**: `admin/admin123`
  - **Banco**: `analytics`

---

### 4.5. Exemplo de Uso: Conectar Jupyter ao PostgreSQL

No Jupyter, crie um notebook e teste a conexão:

```python
import psycopg2

# Conexão usando o nome do serviço "db" como host
conn = psycopg2.connect(
    host="db",
    database="analytics",
    user="admin",
    password="admin123"
)

print ("[1] Conectando e criando o CURSOR de acesso")
cursor = conn.cursor()

print ("[2] Criando a tabela .:dados:.")
cursor.execute("CREATE TABLE IF NOT EXISTS dados (id SERIAL PRIMARY KEY, valor INTEGER);")

print ("[3] Aplicando as modificações no banco de dados")
conn.commit()
```

Utilizando o **Adminer**, insira alguns valores na tabela "dados"


No Jupyter, adicione no notebook um teste de consulta de dados:

```python
import psycopg2

conn = psycopg2.connect(
    host="db",
    database="analytics",
    user="admin",
    password="admin123"
)

cursor = conn.cursor()
cursor.execute("SELECT * FROM dados;")
print(cursor.fetchall())
```

---

### 4.6. Parar o Ambiente

Para encerrar os containers e manter os volumes:

```bash
docker-compose down
```

Para remover volumes (cuidado: apaga dados do PostgreSQL):

```bash
docker-compose down -v
```

## :five: Conclusão

Com **Dockerfile** e **Docker Compose**, criamos um ambiente modular e escalável para análise de dados. Esse `setup` permite a colaboração entre cientistas de dados, facilita a reprodução de experiências e melhora a gestão de dependências.


