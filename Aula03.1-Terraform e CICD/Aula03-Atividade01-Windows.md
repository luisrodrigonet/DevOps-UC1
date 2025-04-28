# Aula 03 - Atividade 01 - Windows
> **Terraform**  - Introdução
>  - Comandos Básicos
>  - Gerenciamento de Estado
>  - Providers e Recursos
>  - Variáveis
>  - Outputs

## Introdução

**Comandos Básicos do Terraform**
- O Terraform é uma ferramenta de Infraestrutura como Código (IaC) que permite gerenciar infraestrutura de forma declarativa. 

- Neste atividade, exploraremos os comandos básicos do Terraform, incluindo inicialização, planejamento, aplicação, destruição e importação de recursos existentes. 

- Assim como, demonstraremos como usar esses comandos para gerenciar infraestrutura de forma prática.

**Princípios Fundamentais:**

- **Infraestrutura como Código (IaC):** Defina recursos em arquivos de configuração (`.tf`), versionáveis e reutilizáveis.

- **Plano de Execução:** Gera um plano antes de aplicar mudanças, garantindo controle sobre alterações.

- **Gráfico de Recursos:** Cria um mapa de dependências entre recursos para otimizar a execução.

- **Estado (State):** Mantém um arquivo de estado (`terraform.tfstate`) para rastrear o estado atual da infraestrutura.



---

## Instalação do Terraform

### Linux

**Passo 1:** Baixe o binário adequado para seu sistema operacional no [site oficial](https://www.terraform.io/downloads).  

**Passo 2:** Extraia o arquivo e mova-o para um diretório no `PATH` do sistema (ex: `/usr/local/bin` no Linux/macOS).  

**Passo 3:** Verifique a instalação:  
```bash
terraform -v
```

### **macOS:** 
```bash
brew install terraform
```


### **Windows:** 

Use o Chocolatey: 

```powershell
choco install terraform
```

Verifique a instalação:  

```powershell
terraform -v
```

---

## Configuração Inicial

**Passo 1:** Crie um diretório para o projeto:  
```bash
mkdir meu-projeto-terraform && cd meu-projeto-terraform
```

**Passo 2:** Crie um arquivo de configuração (`main.tf`):  
```hcl
# main.tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web_server" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "ServidorWeb"
  }
}
```

**Explicação:**
- `provider`: Define o provedor de nuvem (AWS, neste caso).
- `resource`: Declara um recurso a ser criado (ex: instância EC2).

---

## **4. Comandos Básicos do Terraform**

| Comando                | Descrição                                                                 |
|------------------------|---------------------------------------------------------------------------|
| `terraform init`       | Inicializa o diretório, baixando plugins do provedor.                     |
| `terraform plan`       | Gera um plano de execução mostrando as mudanças propostas.                |
| `terraform apply`      | Aplica as mudanças para criar/atualizar recursos.                         |
| `terraform destroy`    | Destrói todos os recursos gerenciados pelo Terraform no projeto.          |
| `terraform fmt`        | Formata os arquivos `.tf` para um estilo consistente.                     |
| `terraform validate`   | Valida a sintaxe dos arquivos de configuração.                            |
| `terraform state list` | Lista todos os recursos rastreados no estado.                             |

---

## **5. Fluxo de Trabalho Básico**

**Passo 1:** Inicialize o diretório:  
```bash
terraform init
```

**Passo 2:** Revise o plano de execução:  
```bash
terraform plan
```

**Passo 3:** Aplique as mudanças (digite `yes` para confirmar):  
```bash
terraform apply
```

**Passo 4:** Destrua os recursos após o uso:  
```bash
terraform destroy
```

---

## **6. Gerenciamento de Estado**

- O arquivo `terraform.tfstate` armazena o estado atual da infraestrutura.  

- **Nunca edite manualmente** este arquivo. Use comandos como `terraform state rm` ou `terraform import` para modificações seguras.  

- Para ambientes colaborativos, use **backends remotos** (ex: Amazon S3, Terraform Cloud).

---

### Exemplo de Uso:

Utilizando Terraform em uma Infraestrutura Local Baseada em Docker para Suportar um Projeto de Análise de Dados, esta seção tem como objetivo realizar a configuração de uma infraestrutura local utilizando Terraform e Docker para suportar um projeto de análise de dados. 

### Pré-requisitos

1. **WSL 2 (Windows Subsystem for Linux)** – Recomendado para melhor compatibilidade com Docker e Terraform.

1. **Docker Desktop**: Certifique-se de que o Docker Desktop está instalado e funcionando corretamente em sua máquina. Você pode baixar e instalar o Docker Desktop a partir do [site oficial](https://www.docker.com/get-started).

1. **Terraform**: Instale o Terraform seguindo as instruções do [site oficial](https://www.terraform.io/downloads.html).

1. **Git** – Para versionamento e facilitar downloads via terminal.

1. **Editor de Texto**: Um editor de texto como **VSCode**, **Sublime Text** ou qualquer outro de sua preferência.


#### **Verificando Instalação**
Abra o **PowerShell** ou o **WSL** e execute:

```powershell
wsl --list --verbose
docker --version
terraform --version
```


### Passo 1: Configuração do Ambiente


1. **Crie um Diretório para o Projeto**:
   
   ```bash
   mkdir projeto-analise-dados
   cd projeto-analise-dados
   mkdir notebooks
   ```

1. Crie os seguintes arquivos dentro deste diretório:

    - `main.tf`
    - `variables.tf`
    - `outputs.tf`


### Passo 2: Definindo a Infraestrutura com Terraform

#### **Definindo o Arquivo `main.tf`**

O arquivo **`main.tf`** conterá a configuração principal do Terraform para provisionar os containers.

```bash
code main.tf
```


```powershell
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

provider "docker" {}

# Rede Docker
resource "docker_network" "analysis_network" {
  name = "analysis_network"
}

# Banco de Dados PostgreSQL
resource "docker_container" "postgres" {
  name  = "postgres_db"
  image = "postgres:15"
  env   = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}"
  ]
  ports {
    internal = 5432
    external = 5432
  }
  networks_advanced {
    name = docker_network.analysis_network.name
  }
}

# Jupyter Notebook
resource "docker_container" "jupyter" {
  name  = "jupyter_notebook"
  image = "jupyter/datascience-notebook:latest"
  ports {
    internal = 8888
    external = 8888
  }
  volumes {
    container_path = "/home/jovyan/work"
    host_path      = "C:/terraform-docker/workspace"
  }
  networks_advanced {
    name = docker_network.analysis_network.name
  }
}
```

---

### **Definindo o Arquivo `variables.tf`**

Este arquivo define as variáveis usadas no `main.tf`.

```powershell
code variables.tf
```

```powershell
variable "db_user" {
  description = "Usuário do banco de dados PostgreSQL"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Senha do banco de dados PostgreSQL"
  type        = string
  sensitive   = true
  default     = "admin123"
}

variable "db_name" {
  description = "Nome do banco de dados"
  type        = string
  default     = "analytics"
}
```

---

### **2.4. Definindo o Arquivo `outputs.tf`**

Aqui configuramos a saída de informações úteis, como a URL do Jupyter Notebook.

```powershell
code outputs.tf
```

```powershell
output "jupyter_url" {
  value = "http://localhost:8888"
}

output "postgres_connection" {
  value = "postgres://${var.db_user}:${var.db_password}@localhost:5432/${var.db_name}"
  sensitive = true
}
```

---


### Passo 3: Aplicando a Configuração


1. **Inicialize o Terraform**:
   
   ```powershell
   terraform init
   ```
   
   Isso prepara o diretório para usar o Terraform.
   
    ```powershell
    Initializing the backend...
    Initializing provider plugins...
    - Finding kreuzwerker/docker versions matching "~> 3.0.2"...
    - Installing kreuzwerker/docker v3.0.2...
    - Installed kreuzwerker/docker v3.0.2 (self-signed, key ID BD080C4571C6104C)
    Partner and community providers are signed by their developers.
    If you'd like to know more about provider signing, you can read about it here:
    https://www.terraform.io/docs/cli/plugins/signing.html
    Terraform has created a lock file .terraform.lock.hcl to record the provider
    selections it made above. Include this file in your version control repository
    so that Terraform can guarantee to make the same selections by default when
    you run "terraform init" in the future.
    
    Terraform has been successfully initialized!
    
    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.
    
    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.
    ```

1. **Criar um plano de execução**  

   ```powershell
   terraform plan
   ```

   Ele exibirá os recursos que serão criados.

    ```powershell
    Terraform used the selected providers to generate the following execution plan. Resource
    actions are indicated with the following symbols:
      + create
    
    Terraform will perform the following actions:
    
      # docker_container.jupyter will be created
      + resource "docker_container" "jupyter" {
          + attach                                      = false
          + bridge                                      = (known after apply)
          + command                                     = (known after apply)
          + container_logs                              = (known after apply)
          + container_read_refresh_timeout_milliseconds = 15000
          + entrypoint                                  = (known after apply)
          + env                                         = (known after apply)
          + exit_code                                   = (known after apply)
          + hostname                                    = (known after apply)
          + id                                          = (known after apply)
          + image                                       = "jupyter/datascience-notebook:latest"
          + init                                        = (known after apply)
          + ipc_mode                                    = (known after apply)
          + log_driver                                  = (known after apply)
          + logs                                        = false
          + must_run                                    = true
          + name                                        = "jupyter_notebook"
          + network_data                                = (known after apply)
          + read_only                                   = false
          + remove_volumes                              = true
          + restart                                     = "no"
          + rm                                          = false
          + runtime                                     = (known after apply)
          + security_opts                               = (known after apply)
          + shm_size                                    = (known after apply)
          + start                                       = true
          + stdin_open                                  = false
          + stop_signal                                 = (known after apply)
          + stop_timeout                                = (known after apply)
          + tty                                         = false
          + wait                                        = false
          + wait_timeout                                = 60
    
          + healthcheck (known after apply)
    
          + labels (known after apply)
    
          + networks_advanced {
              + aliases      = []
              + name         = "analysis_network"
                # (2 unchanged attributes hidden)
            }
    
          + ports {
              + external = 8888
              + internal = 8888
              + ip       = "0.0.0.0"
              + protocol = "tcp"
            }
    
          + volumes {
              + container_path = "/home/jovyan/work"
              + host_path      = "C:/terraform-docker/workspace"
                # (2 unchanged attributes hidden)
            }
        }
    
      # docker_container.postgres will be created
      + resource "docker_container" "postgres" {
          + attach                                      = false
          + bridge                                      = (known after apply)
          + command                                     = (known after apply)
          + container_logs                              = (known after apply)
          + container_read_refresh_timeout_milliseconds = 15000
          + entrypoint                                  = (known after apply)
          + env                                         = (sensitive value)
          + exit_code                                   = (known after apply)
          + hostname                                    = (known after apply)
          + id                                          = (known after apply)
          + image                                       = "postgres:15"
          + init                                        = (known after apply)
          + ipc_mode                                    = (known after apply)
          + log_driver                                  = (known after apply)
          + logs                                        = false
          + must_run                                    = true
          + name                                        = "postgres_db"
          + network_data                                = (known after apply)
          + read_only                                   = false
          + remove_volumes                              = true
          + restart                                     = "no"
          + rm                                          = false
          + runtime                                     = (known after apply)
          + security_opts                               = (known after apply)
          + shm_size                                    = (known after apply)
          + start                                       = true
          + stdin_open                                  = false
          + stop_signal                                 = (known after apply)
          + stop_timeout                                = (known after apply)
          + tty                                         = false
          + wait                                        = false
          + wait_timeout                                = 60
    
          + healthcheck (known after apply)
    
          + labels (known after apply)
    
          + networks_advanced {
              + aliases      = []
              + name         = "analysis_network"
                # (2 unchanged attributes hidden)
            }
    
          + ports {
              + external = 5432
              + internal = 5432
              + ip       = "0.0.0.0"
              + protocol = "tcp"
            }
        }
    
      # docker_network.analysis_network will be created
      + resource "docker_network" "analysis_network" {
          + driver      = (known after apply)
          + id          = (known after apply)
          + internal    = (known after apply)
          + ipam_driver = "default"
          + name        = "analysis_network"
          + options     = (known after apply)
          + scope       = (known after apply)
    
          + ipam_config (known after apply)
        }
    
    Plan: 3 to add, 0 to change, 0 to destroy.
    
    Changes to Outputs:
      + jupyter_url         = "http://localhost:8888"
      + postgres_connection = (sensitive value)
    
    ───────────────────────────────────────────────────────────────────────────────────────────────
    
    Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take
    exactly these actions if you run "terraform apply" now.
    
    ``` 


1. **Aplique a Configuração**:

   Execute o comando abaixo para criar os contêineres Docker conforme definido:
   
   ```powershell
   terraform apply
   ```
   
   ou 
   
   ```powershell
   terraform apply -auto-approve
   ```
   
   O Terraform mostrará um plano de execução e pedirá confirmação. Digite `yes` para prosseguir.
   
   Isso provisionará os containers do **PostgreSQL** e do **Jupyter Notebook**.

1. **Verifique os Contêineres**:

   Após a execução, você pode verificar se os contêineres estão rodando com:
   ```bash
   docker ps
   ```



### Passo 4: Utilizando a Infraestrutura

- **Acesse o Jupyter Notebook**: Abra o navegador e vá para `http://localhost:8888`. Você deve ver a interface do Jupyter Notebook.

```powershell
docker logs jupyter_notebook
```

Obtenha o token:

```text
To access the server, open this file in a browser:
        file:///home/jovyan/.local/share/jupyter/runtime/jpserver-7-open.html
    Or copy and paste one of these URLs:
        http://1634fdd9b516:8888/lab?token=9950d1e94b69269439b924b36b3a8b147b13ffbd6e5a17b6
        http://127.0.0.1:8888/lab?token=9950d1e94b69269439b924b36b3a8b147b13ffbd6e5a17b6
```

- **Acessar o PostgreSQL via `psql`**  
   
   Se você tem o cliente `psql` instalado:

   ```powershell
   psql -h localhost -U admin -d analytics
   ```

### Passo 5: Manutenção e Expansão

- **Atualize a Configuração**: Para adicionar ou modificar serviços, edite o arquivo `main.tf` e reaplique com `terraform apply`.

- **Destrua a Infraestrutura**: Quando não precisar mais da infraestrutura, você pode destruí-la com:
  ```bash
  terraform destroy
  ```

### Arquivos utilizados no projeto

1. **main.tf**: Este é o arquivo principal de configuração do Terraform. Ele define os provedores e os recursos que serão criados.

1. **terraform.tfstate**: Este arquivo é gerado automaticamente pelo Terraform e contém o estado atual da infraestrutura. Ele é usado para gerenciar e atualizar os recursos.

1. **terraform.tfstate.backup**: Este é um backup do arquivo de estado, criado automaticamente pelo Terraform.

### Explicação dos Parâmetros Utilizados

- **provider "docker"**: Define o provedor Docker, que permite ao Terraform gerenciar contêineres Docker.

  - **host**: Especifica o socket do Docker. O valor padrão é `npipe:////./pipe/docker_engine`, que é o socket padrão do Docker no Windows.

- **resource "docker_image"**: Define uma imagem Docker que será usada para criar contêineres.

  - **name**: O nome da imagem Docker, seguido por uma tag (por exemplo, `postgres:latest`).

- **resource "docker_container"**: Define um contêiner Docker.

  - **image**: A imagem Docker que será usada para criar o contêiner.

  - **name**: O nome do contêiner.

  - **env**: Variáveis de ambiente que serão passadas para o contêiner.

  - **ports**: Mapeamento de portas entre o host e o contêiner.

    - **internal**: A porta dentro do contêiner.

    - **external**: A porta no host que será mapeada para a porta interna do contêiner.

  - **volumes**: Mapeamento de volumes entre o host e o contêiner.

    - **container_path**: O caminho dentro do contêiner onde o volume será montado.

    - **host_path**: O caminho no host que será montado no contêiner.


--- 
