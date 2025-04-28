# Aula 03 - Atividade 02.02
> **Terra Form - Módulos e Estado** 
> - Criar módulo reutilizável para ambiente de análise 
> - Configurar backend remoto (S3) 
> - Implementar workspaces 
> - Usar data sources para recursos existentes

Esta atividade aborda **módulos, estados, workspaces e data sources** no Terraform. Além disso, simularemos um **backend remoto (S3) em infraestrutura local** usando Docker.  

A atividade será desenvolvida tendo como base o Sistema Operacional Windows 10 ou 11

📌 **Tecnologias utilizadas**:  
- Terraform  
- Docker  
- Jupyter Notebook  
- PostgreSQL  
- MinIO (alternativa ao AWS S3)  

📌 **Requisitos**:  
- Windows 11  
- Docker Desktop instalado  
- Terraform instalado  
- AWS Cli

# **1. Introdução ao Terraform**  

O **Terraform** é uma ferramenta de **Infraestrutura como Código (IaC)** que permite criar, gerenciar e versionar infraestrutura de forma declarativa.  

**Conceitos Importantes:**  
✔️ **Módulos:** Permitem reutilizar código para criar infraestruturas padronizadas.  
✔️ **Estado (State):** Mantém o rastreamento dos recursos criados pelo Terraform.  
✔️ **Backend Remoto:** Guarda o estado do Terraform em um serviço externo (como AWS S3).  
✔️ **Workspaces:** Permitem criar múltiplas instâncias de uma mesma configuração.  
✔️ **Data Sources:** Permitem acessar recursos já existentes na infraestrutura.  

## **2. Configuração do Ambiente no Windows 11**  

## **2.1. Instalando o Terraform**  

1️⃣ Baixe o Terraform em [terraform.io/downloads](https://developer.hashicorp.com/terraform/downloads).  
2️⃣ Extraia e adicione o caminho do Terraform ao **Path do Windows**.  
3️⃣ Confirme a instalação com:  
   ```sh
   terraform version
   ```

O comando deve gerar uma saída semelhante à:

```text
Terraform v1.11.2
on windows_amd64
```
 
## **2.2. Instalando o Docker Desktop**  
Baixe e instale o Docker Desktop: [docker.com](https://www.docker.com/products/docker-desktop/).  

🚨 **Importante:** Ative o suporte a **WSL 2** durante a instalação.  

---

## 2.3 Instalando o AWS Cli 


**Utilizando o Chocolatey**

```
choco install awscli
```

```
aws --version
```

```
aws-cli/2.24.25 Python/3.12.9 Windows/11 exe/AMD64
```

**Manualmente** 

Baixe e instale o AWS CLI:  
🔗 [Download do AWS CLI v2](https://awscli.amazonaws.com/AWSCLIV2.msi)

1️⃣ Execute o instalador (`AWSCLIV2.msi`).  
2️⃣ Conclua a instalação e reinicie o computador.  
3️⃣ Verifique a instalação novamente com:  
   ```sh
   aws --version
   ```

** Adicionar o AWS CLI ao PATH (se necessário)**  

Se o comando `aws --version` ainda não for reconhecido:  

1️⃣ **Abra o Explorador de Arquivos** e vá para:  
   ```
   C:\Program Files\Amazon\AWSCLIV2\
   ```
2️⃣ Copie o caminho completo, por exemplo:  
   ```
   C:\Program Files\Amazon\AWSCLIV2\
   ```
3️⃣ No **Painel de Controle**, vá para:  
   ```
   Sistema → Configurações Avançadas → Variáveis de Ambiente
   ```
4️⃣ Na variável `Path`, clique em **Editar** e **Adicione o caminho copiado**.  
5️⃣ Clique em **OK** e reinicie o computador.  


---

## 2.4 Configurando o LocalStack para Simular o S3

O **LocalStack** é uma ferramenta que simula serviços AWS localmente.  


1. Suba o container do LocalStack:  

    Executando em modo interativo

   ```sh
   docker run --name localstack --rm -it -p 4566:4566 localstack/localstack
   ```
   ou  executando em modo Daemon 
   
   ```sh
   docker run --name localstack -d -it -p 4566:4566 localstack/localstack
   ```
   
   ```
   docker ps
   ```
   
   
1.  Configurar Credenciais para o LocalStack

    ```powershell
    aws configure
    ```
    
    Informe os valores de teste
    
    ```text
    AWS Access Key ID [None]: test
    AWS Secret Access Key [None]: test
    Default region name [None]: us-east-1
    Default output format [None]: json

    ```
    
 1. Configuração Temporária

    Se você não quiser salvar as credenciais globalmente, defina-as apenas para a sessão atual:

    No PowerShell, execute:

    ```bash
    $env:AWS_ACCESS_KEY_ID="test"
    $env:AWS_SECRET_ACCESS_KEY="test"
    $env:AWS_DEFAULT_REGION="us-east-1"
    ```
    Ou, no cmd:
    
    ```bash
    set AWS_ACCESS_KEY_ID=test
    set AWS_SECRET_ACCESS_KEY=test
    set AWS_DEFAULT_REGION=us-east-1
    ```
   
 1. Crie um bucket S3 no LocalStack para armazenar o estado remoto:  
 
    ```sh
    aws --endpoint-url=http://localhost:4566 s3 mb s3://meu-terraform-state
    ```
    
    O comando deve gerar uma saída semelhante à:
    
    ```text
    make_bucket: meu-terraform-state
    ```
   
    Para listar os Buckets utilize o comando abaixo:
   
    ```
    aws --endpoint-url=http://localhost:4566 s3 ls
    ```

# 3. Criando um Módulo Reutilizável no Terraform

## **3.1. Estrutura do Módulo**  

Crie uma pasta chamada **terraform-modules** e dentro dela crie o módulo **"analyze-environment"**:  

```
terraform-atividade02/
│── analyze-environment/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
```

```
d:
mkdir D:\_devops\terraform-atividade02\analyze-environment
cd D:\_devops\terraform-atividade02\analyze-environment
```


📌 **main.tf** (Define um container Docker como ambiente de análise)  

```powershell
code main.tf
```

```text
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
  }
}

#provider "docker" {}

resource "docker_network" "analysis_net" {
  name = "analysis_network"
}

resource "docker_container" "jupyter" {
  name  = var.jupyter_name
  image = "jupyter/datascience-notebook"
  ports {
    internal = 8888
    external = var.jupyter_port
  }
  networks_advanced {
    name = docker_network.analysis_net.name
  }
}

resource "docker_container" "postgres" {
  name  = var.postgres_name
  image = "postgres:15"
  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}"
  ]
  ports {
    internal = 5432
    external = var.postgres_port
  }
  networks_advanced {
    name = docker_network.analysis_net.name
  }
}

resource "docker_container" "minio" {
  name  = var.minio_name
  image = "minio/minio"
  command = ["server", "/data"]
  env = [
    "MINIO_ACCESS_KEY=${var.minio_access_key}",
    "MINIO_SECRET_KEY=${var.minio_secret_key}"
  ]
  ports {
    internal = 9000
    external = var.minio_port
  }
  networks_advanced {
    name = docker_network.analysis_net.name
  }
}

```

📌 **variables.tf** (Variáveis do módulo)  

```
code variables.tf
```


```text
variable "jupyter_name" { default = "jupyter-notebook" }
variable "jupyter_port" { default = 8888 }
variable "postgres_name" { default = "postgres-db" }
variable "postgres_port" { default = 5432 }
variable "db_user" { default = "admin" }
variable "db_password" { default = "password" }
variable "db_name" { default = "analytics" }
variable "minio_name" { default = "minio-storage" }
variable "minio_port" { default = 9000 }
variable "minio_access_key" { default = "minioadmin" }
variable "minio_secret_key" { default = "minioadmin" }
```

📌 **outputs.tf** (Saída do módulo)  

```
code outputs.tf
```


```hcl
output "jupyter_url" {
  value = "http://localhost:${var.jupyter_port}"
}

output "postgres_host" {
  value = "localhost:${var.postgres_port}"
}

output "minio_console" {
  value = "http://localhost:${var.minio_port}"
}
```

---

# **4. Gerenciando o Estado do Terraform com Backend Remoto**  

## **4.1. Configuração do Backend Remoto**  

```
cd ..
code backend.tf
```


No diretório principal, crie um **backend.tf**:  

```hcl
terraform {
  backend "s3" {
    bucket                      = "meu-terraform-state"
    key                         = "terraform.tfstate"
    region                      = "us-east-1"
    endpoints = {
      s3 = "http://127.0.0.1:4566"
    }
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    use_path_style              = true
    skip_requesting_account_id  = true
  }
}
```

## **4.2. Inicializando o Backend**  

Execute:  
```sh
terraform init
```

Se tudo estiver correto, o Terraform armazenará o estado no **LocalStack S3**.

```
Initializing the backend...

Successfully configured the backend "s3"! Terraform will automatically
use this backend unless the backend configuration changes.
Initializing provider plugins...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

---


# **5. Implementando Workspaces**  

Workspaces permitem gerenciar múltiplos ambientes sem alterar o código.

## **5.1. Criando e Alternando Workspaces**  

📌 Criar um novo workspace:  
```sh
terraform workspace new desenvolvimento
```

```text
Created and switched to workspace "desenvolvimento"!

You're now on a new, empty workspace. Workspaces isolate their state,
so if you run "terraform plan" Terraform will not see any existing state
for this configuratio
```


📌 Alternar entre workspaces:  
```sh
terraform workspace select desenvolvimento
```

📌 Verificar workspaces disponíveis:  
```sh
terraform workspace list
```

O comando deve gerar uma saída semelhante à :

```
  default
* desenvolvimento
```

Agora, cada workspace terá seu próprio estado.

---

# **6. Usando Data Sources para Consultar Recursos Existentes**  

O **data source** permite consultar recursos já criados.

## **6.1. Consultando um Bucket S3 Existente**  

Adicione no `main.tf` principal:  

```powershell
code main.tf
```

```text
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"  # Credenciais fictícias
  secret_key                  = "test"  # Credenciais fictícias
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  # Configuração correta do endpoint para LocalStack
  endpoints {
    s3 = "http://127.0.0.1:4566"
  }
}



# Criação do bucket
resource "aws_s3_bucket" "meu_state_bucket" {
  bucket = "meu-terraform-state-unique"
}

# ACL separada para o bucket
resource "aws_s3_bucket_acl" "meu_state_bucket_acl" {
  bucket = aws_s3_bucket.meu_state_bucket.id
  acl    = "private"
}

# Referenciar o bucket
data "aws_s3_bucket" "state_bucket" {
  bucket = aws_s3_bucket.meu_state_bucket.bucket
}

output "bucket_name" {
  value = data.aws_s3_bucket.state_bucket.bucket
}


module "analyze-environment" {
  source = "./analyze-environment"  # Caminho para o módulo  
}
```

---


# **7. Testando a Infraestrutura**  

## **7.1. Aplicando as Configurações**  

1. Inicie o Terraform:  
   ```sh
   terraform init
   ```  
   
    ``` text
    Initializing the backend...
    Initializing modules...
    - analyze-environment in analyze-environment
    Initializing provider plugins...
    - Finding latest version of hashicorp/aws...
    - Finding kreuzwerker/docker versions matching "~> 3.0.2"...
    - Installing kreuzwerker/docker v3.0.2...
    - Installed kreuzwerker/docker v3.0.2 (self-signed, key ID BD080C4571C6104C)
    - Installing hashicorp/aws v5.91.0...
    - Installed hashicorp/aws v5.91.0 (signed by HashiCorp)
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
   
  
1. Execute o plano para visualizar as mudanças:  
   ```sh
   terraform plan
   ```  
   
    ```text
    Terraform used the selected providers to generate the following execution plan. Resource
    actions are indicated with the following symbols:
      + create
     <= read (data resources)
    
    Terraform will perform the following actions:
    
      # data.aws_s3_bucket.state_bucket will be read during apply
      # (depends on a resource or a module with changes pending)
     <= data "aws_s3_bucket" "state_bucket" {
          + arn                         = (known after apply)
          + bucket                      = "meu-terraform-state-unique"
          + bucket_domain_name          = (known after apply)
          + bucket_regional_domain_name = (known after apply)
          + hosted_zone_id              = (known after apply)
          + id                          = (known after apply)
          + region                      = (known after apply)
          + website_domain              = (known after apply)
          + website_endpoint            = (known after apply)
        }
    
      # aws_s3_bucket.meu_state_bucket will be created
      + resource "aws_s3_bucket" "meu_state_bucket" {
          + acceleration_status         = (known after apply)
          + acl                         = (known after apply)
          + arn                         = (known after apply)
          + bucket                      = "meu-terraform-state-unique"
          + bucket_domain_name          = (known after apply)
          + bucket_prefix               = (known after apply)
          + bucket_regional_domain_name = (known after apply)
          + force_destroy               = false
          + hosted_zone_id              = (known after apply)
          + id                          = (known after apply)
          + object_lock_enabled         = (known after apply)
          + policy                      = (known after apply)
          + region                      = (known after apply)
          + request_payer               = (known after apply)
          + tags_all                    = (known after apply)
          + website_domain              = (known after apply)
          + website_endpoint            = (known after apply)
    
          + cors_rule (known after apply)
    
          + grant (known after apply)
    
          + lifecycle_rule (known after apply)
    
          + logging (known after apply)
    
          + object_lock_configuration (known after apply)
    
          + replication_configuration (known after apply)
    
          + server_side_encryption_configuration (known after apply)
    
          + versioning (known after apply)
    
          + website (known after apply)
        }
    
      # aws_s3_bucket_acl.meu_state_bucket_acl will be created
      + resource "aws_s3_bucket_acl" "meu_state_bucket_acl" {
          + acl    = "private"
          + bucket = (known after apply)
          + id     = (known after apply)
    
          + access_control_policy (known after apply)
        }
    
      # module.analyze-environment.docker_container.jupyter will be created
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
          + image                                       = "jupyter/datascience-notebook"
          + init                                        = (known after apply)
          + ipc_mode                                    = (known after apply)
          + log_driver                                  = (known after apply)
          + logs                                        = false
          + must_run                                    = true
          + name                                        = "jupyter-notebook"
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
        }
    
      # module.analyze-environment.docker_container.minio will be created
      + resource "docker_container" "minio" {
          + attach                                      = false
          + bridge                                      = (known after apply)
          + command                                     = [
              + "server",
              + "/data",
            ]
          + container_logs                              = (known after apply)
          + container_read_refresh_timeout_milliseconds = 15000
          + entrypoint                                  = (known after apply)
          + env                                         = [
              + "MINIO_ACCESS_KEY=minioadmin",
              + "MINIO_SECRET_KEY=minioadmin",
            ]
          + exit_code                                   = (known after apply)
          + hostname                                    = (known after apply)
          + id                                          = (known after apply)
          + image                                       = "minio/minio"
          + init                                        = (known after apply)
          + ipc_mode                                    = (known after apply)
          + log_driver                                  = (known after apply)
          + logs                                        = false
          + must_run                                    = true
          + name                                        = "minio-storage"
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
              + external = 9000
              + internal = 9000
              + ip       = "0.0.0.0"
              + protocol = "tcp"
            }
        }
    
      # module.analyze-environment.docker_container.postgres will be created
      + resource "docker_container" "postgres" {
          + attach                                      = false
          + bridge                                      = (known after apply)
          + command                                     = (known after apply)
          + container_logs                              = (known after apply)
          + container_read_refresh_timeout_milliseconds = 15000
          + entrypoint                                  = (known after apply)
          + env                                         = [
              + "POSTGRES_DB=analytics",
              + "POSTGRES_PASSWORD=password",
              + "POSTGRES_USER=admin",
            ]
          + exit_code                                   = (known after apply)
          + hostname                                    = (known after apply)
          + id                                          = (known after apply)
          + image                                       = "postgres:15"
          + init                                        = (known after apply)
          + ipc_mode                                    = (known after apply)
          + log_driver                                  = (known after apply)
          + logs                                        = false
          + must_run                                    = true
          + name                                        = "postgres-db"
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
    
      # module.analyze-environment.docker_network.analysis_net will be created
      + resource "docker_network" "analysis_net" {
          + driver      = (known after apply)
          + id          = (known after apply)
          + internal    = (known after apply)
          + ipam_driver = "default"
          + name        = "analysis_network"
          + options     = (known after apply)
          + scope       = (known after apply)
    
          + ipam_config (known after apply)
        }
    
    Plan: 6 to add, 0 to change, 0 to destroy.
    
    Changes to Outputs:
      + bucket_name = "meu-terraform-state-unique"
    
    ───────────────────────────────────────────────────────────────────────────────────────────────
    
    Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take
    exactly these actions if you run "terraform apply" now.
    ```

1. Aplique a infraestrutura:  


   ```sh
   #aws --endpoint-url=http://localhost:4566 s3 rb s3://meu-terraform-state --force
   terraform apply -auto-approve
   ```
   
## 7.2 Acessando o Jupyter

```powershell
docker ps -a 
docker logs jupyter-notebook
```

```
To access the server, open this file in a browser:
    file:///home/jovyan/.local/share/jupyter/runtime/jpserver-7-open.html
Or copy and paste one of these URLs:
    http://13e97a5b5ca8:8888/lab?token=4b0bcfa7e9b1c5dc5a5331353f8da375b5edcaacd7510019
    http://127.0.0.1:8888/lab?token=4b0bcfa7e9b1c5dc5a5331353f8da375b5edcaacd7510019
```


## 7.3 Destuindo os Recursos

Para remover tudo:  
```sh
terraform destroy -auto-approve
```

--- 