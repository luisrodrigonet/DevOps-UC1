# Aula 02 - Atividade 01 - Demonstração prática do Docker
> Nesta atividade, serão realizadas demonstrações práticas do Docker, explorando seu uso em cenários reais de análise de dados.
> 
> Abordaremos desde o gerenciamento de imagens até o gerenciamento de `containers`, incluindo inspeção, `networking` e gerenciamento de volumes, proporcionando uma visão prática e aplicada da tecnologia.

**O que é Docker?**
`Docker` é uma plataforma de código aberto que permite automatizar a implantação, escalonamento e gerenciamento de aplicações dentro de `containers`.

**Benefícios para Análise de Dados:**
 - Isolamento de ambientes.
 - Reproducibilidade de análises.
 - Facilidade de compartilhamento de ambientes.

## :books: Pré-requisitos 

### :penguin: **Linux (Ubuntu/Debian)**

1. Atualize os pacotes e instale dependências
    ```bash
    sudo apt update
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
    ```

2. Adicione a chave GPG oficial do Docker
    ```bash
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    ```

3. Adicione o repositório do Docker
    ```bash
    echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] \
    https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee \
    /etc/apt/sources.list.d/docker.list > /dev/null
    ```

4. Instale o Docker Engine
    ```bash
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    ```

5. Inicie o serviço e habilite na inicialização
    ```bash
    sudo systemctl start docker
    sudo systemctl enable docker
    ```

6. Verifique a instalação
    ```bash
    sudo docker --version
    ```

### :penguin:  **Linux (CentOS/Fedora)**

    1. Adicione o repositório
    ```bash
    sudo yum install -y yum-utils
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    ```

2. Instale o Docker
    ```bash
    sudo yum install -y docker-ce docker-ce-cli containerd.io
    ```

3. Inicie e habilite o serviço
    ```bash
    sudo systemctl start docker
    sudo systemctl enable docker
    ```

4. Verifique a instalação
    ```bash
    sudo docker --version
    ```

### :computer: **Windows**

1. **Requisitos**:
   - Windows 10/11 64-bit (Home, Pro, ou Enterprise) com WSL 2 habilitado.
   - Hyper-V habilitado (ou use o [Docker Desktop para WSL 2](https://docs.docker.com/desktop/windows/wsl/)).

2. **Passos**:
   - Baixe o instalador do [Docker Desktop para Windows](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe).
   - Execute o instalador e siga as instruções.
   - Reinicie o computador após a instalação.

### :desktop_computer: **macOS**

1. **Requisitos**:
   - macOS 10.15 (Catalina) ou superior (Intel ou Apple Silicon).

2. **Passos**:
   - Baixe o instalador do [Docker Desktop para Mac](https://desktop.docker.com/mac/main/amd64/Docker.dmg).
   - Arraste o ícone do Docker para a pasta `Applications`.
   - Execute o Docker Desktop e aceite os privilégios de administrador.

---

### :penguin: **Pós-instalação (Linux)**

#### **Executar Docker sem `sudo`**

```bash
# Adicione seu usuário ao grupo "docker"
sudo usermod -aG docker $USER

# Reinicie a sessão (faça logout/login ou reinicie o sistema)
# Verifique com:
docker ps  # Deve funcionar sem sudo
```

#### **Verificação da Instalação**

```bash
docker --version              # Exemplo: Docker version 24.0.7, build 1110ad0
docker run hello-world        # Executa um container de teste
```

#### **Docker Hub (Registro de Imagens)**

- Crie uma conta gratuita em [https://hub.docker.com](https://hub.docker.com).
- Faça login via terminal para gerenciar imagens:

```bash
  docker login  # Insira seu usuário e senha do Docker Hub
```

---

## :books: **Demonstração dos Comandos Básicos**

### :one: **Gerenciamento de Imagens**

#### **Baixar uma imagem (ex: Ubuntu)**

**`docker pull`**: Baixar uma imagem do Docker Hub.

```bash
docker pull ubuntu:22.04
```

```bash
docker pull ubuntu:latest  # Baixa a imagem do Ubuntu
docker pull nginx:alpine  # Baixa a versão "alpine" do Nginx
```

#### **Listar imagens locais**
```bash
docker images
```

#### **Remover uma imagem**
```bash
docker rmi ubuntu:22.04
```

#### **`docker build`**: Criar uma imagem a partir de um Dockerfile.


```powershell
mkdir DevOps-UC01-Docker-01
cd DevOps-UC01-Docker-01
code dockerfile
```

**Exemplo de Dockerfile**:
```dockerfile
# Dockerfile
FROM alpine:latest
RUN apk add --no-cache python3
CMD ["echo", "Imagem customizada construída!"]
```

**Comando para construir**:

Constrói a imagem com a tag "minha-imagem:1.0"

```powershell
docker build -t minha-imagem:1.0 .  
```

```text
[+] Building 5.1s (7/7) FINISHED                                           docker:desktop-linux
 => [internal] load build definition from dockerfile                                       0.0s
 => => transferring dockerfile: 152B                                                       0.0s
 => [internal] load metadata for docker.io/library/alpine:latest                           2.3s
 => [auth] library/alpine:pull token for registry-1.docker.io                              0.0s
 => [internal] load .dockerignore                                                          0.0s
 => => transferring context: 2B                                                            0.0s
 => [1/2] FROM docker.io/library/alpine:latest@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa4  0.6s
 => => resolve docker.io/library/alpine:latest@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa4  0.0s
 => => sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3 9.22kB / 9.22kB  0.0s
 => => sha256:1c4eef651f65e2f7daee7ee785882ac164b02b78fb74503052a26dc061c 1.02kB / 1.02kB  0.0s
 => => sha256:aded1e1a5b3705116fa0a92ba074a5e0b0031647d9c315983ccba2ee5428ec8 581B / 581B  0.0s
 => => sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d 3.64MB / 3.64MB  0.3s
 => => extracting sha256:f18232174bc91741fdf3da96d85011092101a032a93a388b79e99e69c2d5c870  0.1s
 => [2/2] RUN apk add --no-cache python3                                                   1.9s
 => exporting to image                                                                     0.3s
 => => exporting layers                                                                    0.3s
 => => writing image sha256:027512eadff8aa6bb231401f3ae105af4b80b7aea0353ab24559c9f74d72e  0.0s
 => => naming to docker.io/library/minha-imagem:1.0                                        0.0s

View build details: docker-desktop://dashboard/build/desktop-linux/desktop-linux/bhl9vepfhrv90mgtkmanemnzz

What's next:
    View a summary of image vulnerabilities and recommendations → docker scout quickview
```

#### **`docker push`**: Enviar imagem para o Docker Hub.

- Renomeia a imagem
- Autentica no Docker Hub
- Envia para o repositório

```powershell
docker tag minha-imagem:1.0 seu-usuario/minha-imagem:1.0  
docker login  
docker push seu-usuario/minha-imagem:1.0  
```

```powershell
docker tag minha-imagem:1.0 luisrodrigonet/minha-imagem:1.0  
docker login  
docker push luisrodrigonet/minha-imagem:1.0  
```


---

### :two: **Executar um Container**

#### **Modo interativo (Ubuntu)**

Executando o `Containner` em modo **interativo**

```bash
docker run -it --name meu-container ubuntu:22.04 /bin/bash
```
Atualizando e lista de pacotes e instalando o crl

```bash
apt update && apt install -y curl  
exit  
```

**Explicação sobre os argumentos utilizados**

- `-it`: Modo interativo.
- `-d`: Executa em segundo plano.
- `-p 8080:80`: Mapeia a porta 80 do container para 8080 do host.
- `--name`: Define um nome para o container.

Outros exemplos

```bash
docker run -it  --name meu-ubuntu ubuntu:latest /bin/bash 
docker run -it -p 8080:80 --name meu-nginx nginx:alpine  
```


#### **Executar em segundo plano (Nginx)**

Iniciando um `container` em modo `Detached` ou segundo plano

```bash
docker run -d -p 8080:80 --name nginx-server nginx:latest
docker ps
```

```text
CONTAINER ID   IMAGE          COMMAND                  CREATED              STATUS              PORTS                  NAMES
e489b8e12da3   nginx:latest   "/docker-entrypoint.…"   About a minute ago   Up About a minute   0.0.0.0:8080->80/tcp   nginx-server
```

Para testar acesse [http://localhost:8080](http://localhost:8080) no navegador


---

### :three: **Inspecionar Containers**
#### **Listar containers em execução**
```bash
docker ps
```

```text
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
e489b8e12da3   nginx:latest   "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   0.0.0.0:8080->80/tcp   nginx-server
```


#### **Listar todos os containers**
```bash
docker ps -a
```

```text
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                  NAMES
e489b8e12da3   nginx:latest   "/docker-entrypoint.…"   2 minutes ago   Up 2 minutes   0.0.0.0:8080->80/tcp   nginx-server
PS D:\_devops\DevOps-UC01-Docker-01> docker ps -a
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS                      PORTS                    NAMES
e489b8e12da3   nginx:latest   "/docker-entrypoint.…"   3 minutes ago    Up 3 minutes                0.0.0.0:8080->80/tcp     nginx-server
f49d403de115   ubuntu:22.04   "/bin/bash"              12 minutes ago   Exited (0) 8 minutes ago                             meu-container
84e5f4bd7f6e   hello-world    "/hello"                 25 minutes ago   Exited (0) 25 minutes ago                            laughing_sutherland
20766db2ac19   projeto-web    "python /code/manage…"   2 years ago      Exited (255) 2 years ago    0.0.0.0:8000->8000/tcp   projeto-web-1
62be72c822d3   postgres:15    "docker-entrypoint.s…"   2 years ago      Exited (255) 2 years ago    5432/tcp                 projeto-db-1
```


#### **Ver logs do Nginx**
```bash
docker logs nginx-server
```

```text
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
/docker-entrypoint.sh: Sourcing /docker-entrypoint.d/15-local-resolvers.envsh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
/docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
/docker-entrypoint.sh: Configuration complete; ready for start up
2025/03/24 21:01:22 [notice] 1#1: using the "epoll" event method
2025/03/24 21:01:22 [notice] 1#1: nginx/1.27.4
2025/03/24 21:01:22 [notice] 1#1: built by gcc 12.2.0 (Debian 12.2.0-14)
2025/03/24 21:01:22 [notice] 1#1: OS: Linux 5.15.167.4-microsoft-standard-WSL2
2025/03/24 21:01:22 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2025/03/24 21:01:22 [notice] 1#1: start worker processes
2025/03/24 21:01:22 [notice] 1#1: start worker process 29
2025/03/24 21:01:22 [notice] 1#1: start worker process 30
2025/03/24 21:01:22 [notice] 1#1: start worker process 31
2025/03/24 21:01:22 [notice] 1#1: start worker process 32
2025/03/24 21:01:22 [notice] 1#1: start worker process 33
2025/03/24 21:01:22 [notice] 1#1: start worker process 34
2025/03/24 21:01:22 [notice] 1#1: start worker process 35
2025/03/24 21:01:22 [notice] 1#1: start worker process 36
2025/03/24 21:01:22 [notice] 1#1: start worker process 37
2025/03/24 21:01:22 [notice] 1#1: start worker process 38
2025/03/24 21:01:22 [notice] 1#1: start worker process 39
2025/03/24 21:01:22 [notice] 1#1: start worker process 40
2025/03/24 21:01:22 [notice] 1#1: start worker process 41
2025/03/24 21:01:22 [notice] 1#1: start worker process 42
2025/03/24 21:01:22 [notice] 1#1: start worker process 43
2025/03/24 21:01:22 [notice] 1#1: start worker process 44
172.17.0.1 - - [24/Mar/2025:21:03:27 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36" "-"
172.17.0.1 - - [24/Mar/2025:21:03:27 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://127.0.0.1:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36" "-"
2025/03/24 21:03:27 [error] 29#29: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 172.17.0.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "127.0.0.1:8080", referrer: "http://127.0.0.1:8080/"
172.17.0.1 - - [24/Mar/2025:21:03:47 +0000] "GET / HTTP/1.1" 200 615 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36" "-"
172.17.0.1 - - [24/Mar/2025:21:03:47 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://localhost:8080/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36" "-"
2025/03/24 21:03:47 [error] 32#32: *4 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 172.17.0.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "localhost:8080", referrer: "http://localhost:8080/"
```

**Outros exemplos**

- Segue os logs em tempo real (como tail -f)

    ```bash
    docker logs -f nginx-server
    ```

- Últimas 10 linhas

    ```bash
    docker logs --tail 10 nginx-server  
    ```
**`docker inspect`**: Inspecionar detalhes do container.

- Mostra metadados (IP, portas, volumes, etc.)

    ```bash
    docker inspect nginx-server
    ```

---

### :four: **Parar e Remover Containers**

**`docker start/stop`**: Iniciar/parar um container.

Para o container
```bash
docker stop  nginx-server  
docker ps
```

Reinicia o container
```bash
docker start nginx-server 
```

**`docker rm`**: Remover um container.

Remove o container (deve estar parado)
```bash
docker rm nginx-server  
```

 Força a remoção (se estiver em execução)
```bash
docker rm -f nginx-server  
```

**Exemplo de uso**

```bash
docker stop     nginx-server    # Para o container
docker start    nginx-server    # Reinicia o container
docker rm       nginx-server    # Remove o container (após parar)
```

## :books: **Networking Básico**

### :ledger: Tipos de Redes:

1. **Bridge**  
   - **Driver Padrão**: `bridge`  
   
   - **Descrição**: Cria uma rede virtual isolada no host Docker. Containers conectados a essa rede comunicam-se via NAT (Network Address Translation). Ideal para comunicação entre containers no **mesmo host**.  
   
   - **Uso**: Aplicações isoladas em um único host (ex.: microsserviços em desenvolvimento).

1. **Host**  
   - **Driver**: `host` 
   
   - **Descrição**: Remove o isolamento de rede do container, utilizando diretamente a interface de rede do host. Não há NAT ou IPs virtuais.  
   
   - **Uso**: Aplicações que exigem **alto desempenho** (ex.: streaming de dados em tempo real).

1. **None**  
   - **Driver**: `none`  
   
   - **Descrição**: Desabilita toda a conectividade de rede. O container só possui a interface `loopback`. 
   
   - **Uso**: Containers que não requerem acesso à rede (ex.: tarefas de processamento batch).


### :ledger: **Listar redes**:
```bash
docker network ls
```

```text
NETWORK ID     NAME              DRIVER    SCOPE
ccfc0a85ae23   bridge            bridge    local
9b5cb6e48016   host              host      local
dd122d7680b6   none              null      local
9d033380f092   projeto_default   bridge    local
```

### :ledger: **Criar uma rede personalizada**:

Cria a rede `minha-rede`

```bash
docker network create minha-rede
```

#### :bookmark: **Executar container em uma rede específica**:


Conecta a rede em dois container, o primeiro iniciado no segundo plano e e o segundo e modo interativo

```bash
docker run -d   --name container1 --network minha-rede nginx:alpine
docker run -it  --name container2 --network minha-rede alpine:latest sh
```

#### :bookmark: **Testar comunicação entre containers**:

Para testar a conectividade, realiza um `ping` no container `container1`

```bash
ping container1 
exit
```

### :ledger: **Conectando um container a uma rede**
```sh
docker network  connect     minha-rede  meu-container
```

### :ledger: **Desconectando um container de uma rede**
```sh
docker network  disconnect  minha-rede  meu-container
```

### :ledger: **Mapeamento de portas**:

**Porta do Container vs. Porta do Host**:
   
   - Todo container Docker executa serviços em portas específicas (ex.: `80` para HTTP, `5432` para PostgreSQL).
   
   - Por padrão, essas portas são **isoladas** dentro do container.
   
   - Para expor o serviço, mapeamos uma porta do **host** (máquina física ou VM) para a porta do **container**.

**Sintaxe Básica**:

   ```bash
   docker run -p <PORTA_HOST>:<PORTA_CONTAINER> <imagem>
   ```

**Protocolos**:
   - Por padrão, o mapeamento usa **TCP**.
   - Para UDP, especifique o protocolo: `-p 53:53/udp`.

**Endereços Específicos**:
   - Restrinja o acesso à interface de rede do host:
     ```bash
     docker run -p 127.0.0.1:8080:80 nginx 
     ```

**Exemplo de uso** 

- alpine expondo porta 80/tcp interna do container na porta 8080/tcp do host

    ```bash
    docker run -d -p 8080:80 --name nginx-host nginx:alpine  
    ```

## :books: **Gerenciamento de Volumes**

### :ledger: **Tipos de Volumes**

1. **Volumes Nomeados**  
   - Criados e gerenciados pelo Docker (armazenados em `/var/lib/docker/volumes/` no host).  
   - Recomendados para persistência de dados em produção.  

2. **Bind Mounts**  
   - Vinculam um diretório/arquivo específico do host ao container.  
   - Úteis para desenvolvimento (ex.: código-fonte).  

3. **Volumes Anônimos**  
   - Criados automaticamente pelo Docker (sem nome definido).  
   - Menos gerenciáveis, pois dependem do ciclo de vida do container.  

4. **Volumes em Memória (`tmpfs`)**  
   - Armazenam dados na memória RAM do host.  
   - Úteis para dados temporários e sensíveis (ex.: tokens).  

### :ledger: **Comandos Básicos de Gerenciamento**

| Comando                     | Descrição                                  |
|-----------------------------|--------------------------------------------|
| `docker volume create <nome>` | Cria um volume nomeado.                   |
| `docker volume ls`            | Lista volumes existentes.                 |
| `docker volume inspect <nome>`| Exibe detalhes do volume (localização, etc). |
| `docker volume prune`         | Remove volumes não utilizados.            |


### :ledger: **Criar um volume**:

**Listando volumes**
```sh
docker volume ls
```

```text
DRIVER    VOLUME NAME
local     f890a0eec0889b2327468f75081cdf506218d87754b2df87c4606c36e9d8ea90
```

**Criando um Volume**

```bash
docker volume create meu-volume
```

**Listando volumes**

```sh
docker volume ls
```

```text
DRIVER    VOLUME NAME
local     f890a0eec0889b2327468f75081cdf506218d87754b2df87c4606c36e9d8ea90
local     meu-volume
```

### :ledger: **Montar volume em um container**:

**Usando um volume em um container**
```sh
docker run -d --name container-com-volume -v meu-volume:/dados ubuntu
```

**Exemplo de uso em um container rodando MySQL**

```bash
docker run -d --name mysql-db -v meu-volume:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=senha mysql:latest
```

**Funcionalidade**:  

- Os dados do `MySQL` são armazenados no volume `meu-volume`, sobrevivendo à remoção do container.  

### :ledger: **Inspecionar volumes**:

**Listando os Volumes**

```bash
docker volume ls 
```
```text
DRIVER    VOLUME NAME
local     f890a0eec0889b2327468f75081cdf506218d87754b2df87c4606c36e9d8ea90
local     meu-volume
```

**Obtendo mais informações sobre o volume**

```bash
docker volume inspect meu-volume 
```

```text
[
    {
        "CreatedAt": "2025-03-25T11:52:06Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/meu-volume/_data",
        "Name": "meu-volume",
        "Options": null,
        "Scope": "local"
    }
]
```


### :ledger: **Persistência de dados**:

- Os dados em `/var/lib/mysql` são mantidos mesmo após remover o container:

**Removendo o container**

```bash
docker rm -f mysql-db
```

**Criando um novo container**

O novo container utilizará o mesmo volume do anterior

```bash
docker run -d --name novo-mysql -v meu-volume:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=senha mysql:latest
```
```bash
docker ps
```
```text
CONTAINER ID   IMAGE          COMMAND                  CREATED         STATUS         PORTS                 NAMES
b4999ac11f85   mysql:latest   "docker-entrypoint.s…"   7 seconds ago   Up 6 seconds   3306/tcp, 33060/tcp   novo-mysql
```

**Verificando o volume**

```bash
docker volume inspect meu-volume 
```

```text
[
    {
        "CreatedAt": "2025-03-25T11:52:06Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/meu-volume/_data",
        "Name": "meu-volume",
        "Options": null,
        "Scope": "local"
    }
]
```

**Inspecionando o Container**

```powershell
docker container inspect novo-mysql
```

```text
...
"Mounts": [
            {
                "Type": "volume",
                "Name": "meu-volume",
                "Source": "/var/lib/docker/volumes/meu-volume/_data",
                "Destination": "/var/lib/mysql",
                "Driver": "local",
                "Mode": "z",
                "RW": true,
                "Propagation": ""
            }
        ],
...
```


### :ledger: **Removendo um volume**


Antes de remover o volume devemos remover os containers associados

```powershell
docker rm -f novo-mysql
```

Em seguida podemos remover o volume 


```sh
docker volume rm meu-volume
```

**Verificando se o volume ainda existe**

```sh
docker volume ls
```

```sh
DRIVER    VOLUME NAME
local     f890a0eec0889b2327468f75081cdf506218d87754b2df87c4606c36e9d8ea9
```

## :books: **Limpeza de Recursos**

### Remover containers parados:

```bash
docker container prune
```

```text
WARNING! This will remove all stopped containers.
Are you sure you want to continue? [y/N] y
```

```text
Deleted Containers:
080ec28b7cebf61d0a92063e0eccdefafd7a3c3bcca7b6a482498a203beb02db
e489b8e12da32bea4ef64a20a12d95e2bbd28a59e93d4b96c93d78a6dccec67b
f49d403de115b295569c31f8e15cedce6f5acc3bc0e3ddcf4d29c053512dd133
84e5f4bd7f6eb8e6dd7dee2671a201cda303d9c0652f38d163f4e6278c0827e6
20766db2ac19245bae884fe9e98314b87e2df8b76068798818f190dd7ffc91d6
62be72c822d3d369100a283019ed3be2670584e473a5d6dfd4df8a8c63dfc585

Total reclaimed space: 67.25MB
```

### Remover volumes não utilizados:


```bash
docker volume prune
```

```text
WARNING! This will remove anonymous local volumes not used by at least one container.
Are you sure you want to continue? [y/N] y

```

```text
Deleted Volumes:
f890a0eec0889b2327468f75081cdf506218d87754b2df87c4606c36e9d8ea90

Total reclaimed space: 21.06kB
```

### Remover todas as imagens não utilizadas:
```bash
docker image prune -a
```

```text
WARNING! This will remove all images without at least one container associated to them.
Are you sure you want to continue? [y/N] y
```

```text
Deleted Images:
untagged: projeto-web:latest
deleted: sha256:6af2b8bdc8cd8a683e6cb3a5e01b306cbb90898d11436cac33ff337b3fbb590b
deleted: sha256:8987a2dd6a95a11ff8e2c690e3d8c052dcad499f4e51817af316a0cd8568f43d
deleted: sha256:b01baff68e43cfe6b8b4a06de3417a164d5fd14aae84811d80a4daac88e8b283
deleted: sha256:69358d9962e8e664f9c6caebfd8698e2d612bd0db0fc220fadcc2dafda1eb142
deleted: sha256:9cd28823ab7151b28c94fd3872ef013a1ded2d5ce63f60d0af841d241d7cd7a3
deleted: sha256:4572173d18c9aa21f61cb056797ddde2990aab0c04118eec95e330574031b627
deleted: sha256:7a3737c530097bcecdd2300e841018c36d7620e20264dd97131a61f3bb2dbe96
deleted: sha256:62331077ceecc73296ff049d4c3a035dd8d03c878e3d1bea811177ae7ca5edf0
deleted: sha256:27bc05b1fea3965941811202ee8a32cfb567bbcd0797fd65d9fe6cfafabec072
...
deleted: sha256:270a1170e7e398434ff1b31e17e233f7d7b71aa99a40473615860068e86720af
untagged: alpine:latest
untagged: alpine@sha256:a8560b36e8b8210634f77d9f7f9efd7ffa463e380b75e2e74aff4511df3ef88c
deleted: sha256:aded1e1a5b3705116fa0a92ba074a5e0b0031647d9c315983ccba2ee5428ec8b
```

---

