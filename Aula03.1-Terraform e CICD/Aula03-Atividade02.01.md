# Aula 03 - Atividade 02 - Parte 1
> Construindo uma Infraestrutura Local com Terraform e Docker para Análise de Dados
> 
> Terraform - Infraestrutura Básica
>   - Viáveis
>   - Output
>   - Modulos
>   - Rede (VPC, Subnet e Security Group)
>   - Monitoramento

## **1. Introdução**

Nesta atividade criaremos uma infraestrutura local para análise de dados utilizando **Terraform** e **Docker** em um ambiente Windows 11. 

A infraestrutura suportará um ambiente de **Jupyter Notebook**, um banco de dados **PostgreSQL**, gerenciamento via **pgAdmin** e um sistema de **monitoramento**.

## **2. Configuração Inicial**

### **2.1 Instalação de Dependências**

1. **Instale o Terraform**:
   - Baixe o Terraform em: [https://developer.hashicorp.com/terraform/downloads](https://developer.hashicorp.com/terraform/downloads)
   - Adicione o binário ao PATH.

2. **Instale o Docker Desktop**:
   - Baixe e instale o Docker Desktop em [https://www.docker.com/products/docker-desktop/](https://www.docker.com/products/docker-desktop/)
   - Certifique-se de que o Docker está em execução.

3. **Verifique a instalação**:
   ```sh
   terraform -version
   docker -v
   ```

## **3. Estrutura do Projeto**
Crie a seguinte estrutura de diretórios:
```
terraform-docker/
│── main.tf
│── variables.tf
│── outputs.tf
│── modules/
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── compute/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── monitoring/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
```

Criando os diretórios

```powershell
c:
mkdir -p _devops/terraform-docker/modules/
mkdir -p _devops/terraform-docker/compute/
mkdir -p _devops/terraform-docker/monitoring/
```

## **4. Módulos Terraform**

### **4.1 Módulo: Network (VPC, Subnet e Security Group)**
Crie `modules/network/main.tf`:



```hcl
resource "docker_network" "vpc_network" {
  name = var.network_name
}
```


Crie `modules/network/variables.tf`:
```hcl
variable "network_name" {
  type    = string
  default = "analysis_network"
}
```

Crie `modules/network/outputs.tf`:
```hcl
output "network_id" {
  value = docker_network.vpc_network.id
}
```

### **4.2 Módulo: Compute (Jupyter, PostgreSQL, pgAdmin)**
Crie `modules/compute/main.tf`:
```hcl
resource "docker_container" "postgres" {
  name  = "postgres_db"
  image = "postgres:latest"
  env   = ["POSTGRES_USER=${var.db_user}", "POSTGRES_PASSWORD=${var.db_password}", "POSTGRES_DB=${var.db_name}"]
  networks_advanced {
    name = var.network_id
  }
  volumes {
    host_path      = "./data/postgres"
    container_path = "/var/lib/postgresql/data"
  }
}

resource "docker_container" "pgadmin" {
  name  = "pgadmin"
  image = "dpage/pgadmin4"
  env   = ["PGADMIN_DEFAULT_EMAIL=${var.pgadmin_email}", "PGADMIN_DEFAULT_PASSWORD=${var.pgadmin_password}"]
  ports {
    internal = 80
    external = 5050
  }
  networks_advanced {
    name = var.network_id
  }
  volumes {
    host_path      = "./data/pgadmin"
    container_path = "/var/lib/pgadmin"
  }
}

resource "docker_container" "jupyter" {
  name  = "jupyter_notebook"
  image = "jupyter/datascience-notebook"
  ports {
    internal = 8888
    external = 8888
  }
  networks_advanced {
    name = var.network_id
  }
  volumes {
    host_path      = "./data/jupyter"
    container_path = "/home/jovyan/work"
  }
}
```

### **4.3 Módulo: Monitoramento (Prometheus e Grafana)**
Crie `modules/monitoring/main.tf`:
```hcl
resource "docker_container" "prometheus" {
  name  = "prometheus"
  image = "prom/prometheus"
  ports {
    internal = 9090
    external = 9090
  }
  networks_advanced {
    name = var.network_id
  }
  volumes {
    host_path      = "./data/prometheus"
    container_path = "/etc/prometheus"
  }
}

resource "docker_container" "grafana" {
  name  = "grafana"
  image = "grafana/grafana"
  ports {
    internal = 3000
    external = 3000
  }
  networks_advanced {
    name = var.network_id
  }
  volumes {
    host_path      = "./data/grafana"
    container_path = "/var/lib/grafana"
  }
}
```

## **5. Arquivos Principais do Terraform**
Crie `main.tf`:
```hcl
module "network" {
  source = "./modules/network"
}

module "compute" {
  source     = "./modules/compute"
  network_id = module.network.network_id
}

module "monitoring" {
  source     = "./modules/monitoring"
  network_id = module.network.network_id
}
```

## **6. Executando o Terraform**
1. **Inicialize o Terraform**:
   ```sh
   terraform init
   ```
2. **Valide a configuração**:
   ```sh
   terraform validate
   ```
3. **Aplique a infraestrutura**:
   ```sh
   terraform apply -auto-approve
   ```
4. **Verifique os outputs**:
   ```sh
   terraform output
   ```

## **7. Conclusão**
Este tutorial demonstrou como utilizar **Terraform e Docker** para criar uma infraestrutura local de análise de dados. A separação por módulos e o uso de variáveis facilitam a reutilização e a manutenção da infraestrutura.
