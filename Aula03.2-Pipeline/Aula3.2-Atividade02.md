# Aula 3.2 - Atividade 02
> ## Introdução a CI/CD com GitHub Actions, Docker e Terraform para Analistas de Dados
>
> ### Atividades da UC
>   - Executar testes
>   - Construir imagem Docker
>   - Publicar imagem no registry
>   - Aplicar configuração Terraform
>
> ### Objetivos da Aula:
> 1. Introduzir conceitos básicos de Git/GitHub.
> 2. Configurar um pipeline CI/CD com GitHub Actions.
> 3. Construir e publicar uma imagem Docker no Docker Hub.
> 4. Aplicar infraestrutura com Terraform (v1.11.2+).
> 5. Demonstrar automação de deploy em um contexto simples.
> 
> ### Pré-requisitos:
> - Windows 11.
> - Git instalado ([Download](https://git-scm.com/)).
> - Docker Desktop instalado ([Download](https://www.docker.com/products/docker-desktop/)).
> - Terraform v1.11.2+ ([Instalação](https://developer.hashicorp.com/terraform/downloads)).
> - Conta no GitHub e Docker Hub.
> - Editor de código (VS Code recomendado).

# Introdução ao Git e GitHub

## **Conceitos:**
- **Repositório:** Pasta versionada do projeto.
- **Commit:** "Snapshot" das alterações.
- **Push:** Envio de commits para o GitHub.

## **Demonstração:**
```bash
# Configurar usuário
git config --global user.name "Seu Nome"
git config --global user.email "seu@email.com"

# Iniciar repositório
cd D:\_devops
mkdir DevOps-UC1-Pipeline02
cd DevOps-UC1-Pipeline02
git init

# Criar arquivo README.md
echo "# Aula 3.2 - Atividiade 02" >> README.md

# Primeiro commit
git add .
git commit -m "Primeiro commit"

# Vincular ao GitHub (crie um repositório vazio no GitHub antes)
git remote add origin https://github.com/luisrodrigonet/DevOps-UC1-Pipeline02.git

# Verifique qual branch existe localmente
git branch

# Renomeie a branch local para main (se necessário)
git branch -m master main

git push -u origin main

# Configure o Git para usar main como branch padrão globalmente
git config --global init.defaultBranch main
```

---

# **2. Estrutura do Projeto (15 minutos)**

Crie os seguintes arquivos:

##  `app/main.py` - Aplicação Python simples

```powershell
code app/main.py
```

```python
print("Pipeline CI/CD funcionando!")
```


**Explicação:**

- **Objetivo:** Simula um script de análise de dados (poderia ser um processamento de dados real).

- **Detalhes:**
  - `print()`: Exibe uma mensagem no terminal (em um cenário real, aqui estariam funções de análise de dados, carregamento de datasets, etc.).
  - **Extensões comuns:** Pode ser substituído por scripts que usem `pandas`, `matplotlib`, ou outras bibliotecas de análise.



## `Dockerfile` - Instruções para construir a imagem Docker

```powershell
code dockerfile
```

```dockerfile
# Use uma imagem leve do Python
FROM python:3.9-slim

# Copie o código para o container
COPY app/main.py /app/main.py

# Defina o comando de execução
CMD ["python", "/app/main.py"]
```

**Parâmetros e Propósito:**

| Instrução         | Explicação                                                                                   |
|-------------------|---------------------------------------------------------------------------------------------|
| `FROM`            | Define a imagem base. `python:3.9-slim` é uma versão leve do Python, ideal para containers. |
| `COPY`            | Copia o arquivo `main.py` do diretório local (`app/`) para o diretório `/app/` no container. |
| `CMD`             | Comando executado quando o container inicia. Aqui, roda o script Python.                    |

**Por que usar o Docker?**  
- Isola o ambiente de execução (ex: versões de bibliotecas não conflitam com o sistema do usuário).
- Facilita a reprodução da análise em qualquer máquina.


## `terraform/main.tf` - Configuração do Terraform para implantar o container


```powershell
code terraform/main.tf
```

```text
terraform {
  required_version = ">= 1.11.2"
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

# Autenticação no Docker Hub (usará variáveis de ambiente)
provider "docker" {}

# Puxar imagem do Docker Hub e executar
resource "docker_container" "meu_container" {
  name  = "app-ci-cd"
  image = "seu-usuario-docker/app-ci-cd:latest"
  restart = "always"
}
```

---

# Configuração do GitHub Actions

Crie o arquivo **`.github/workflows/pipeline.yml`**:

```powershell
code .github/workflows/pipeline.yml
```

```yaml
name: CI/CD Pipeline

on:
  push:
    branches: [ "main" ]

jobs:
  build-and-deploy:
    runs-on: windows-latest

    steps:
    # Passo 1: Baixar código
    - name: Checkout
      uses: actions/checkout@v4

    # Passo 2: Configurar Terraform
    - name: Setup Terraform
      uses: hashicorp/setup-terraform@v2
      with:
        terraform_version: 1.11.2

    # Passo 3: Login no Docker Hub
    - name: Login no Docker Hub
      uses: docker/login-action@v3
      with:
        username: ${{ secrets.DOCKERHUB_USERNAME }}
        password: ${{ secrets.DOCKERHUB_TOKEN }}

    # Passo 4: Construir e publicar imagem Docker
    - name: Build and Push Docker Image
      run: |
        docker build -t seu-usuario-docker/app-ci-cd:latest .
        docker push seu-usuario-docker/app-ci-cd:latest

    # Passo 5: Aplicar Terraform
    - name: Terraform Apply
      working-directory: ./terraform
      run: |
        terraform init
        terraform plan
        terraform apply -auto-approve
      env:
        DOCKER_REGISTRY_USER: ${{ secrets.DOCKERHUB_USERNAME }}
        DOCKER_REGISTRY_PASSWORD: ${{ secrets.DOCKERHUB_TOKEN }}
```

**Explicação de Parâmetros:**

- **`on: push`:** Aciona o pipeline ao detectar push na branch `main`.

- **`secrets.DOCKERHUB_USERNAME`:** Variável segura no GitHub (configure em *Settings > Secrets*).

- **`terraform apply -auto-approve`:** Aplica mudanças sem confirmação manual (use com cautela).

---

# Execução do Pipeline 

1. Envie o código para o GitHub:
   ```bash
   git add .
   git commit -m "Pipeline configurado"
   git push
   ```
   
2. Acesse **Actions** no repositório GitHub para ver o pipeline em execução.

3. Verifique a imagem no Docker Hub e o container em execução (`docker ps` no terminal).

---

# Melhores Práticas 

- **`.dockerignore` e `.gitignore`:** Ignore arquivos desnecessários (ex: `__pycache__`, `.env`).

- **Segurança:** Nunca exponha credenciais em código (use GitHub Secrets).

- **Testes:** Adicione testes automatizados antes do deploy (ex: testes unitários em Python).

---

### **Recursos Adicionais:**
- [GitHub Actions Docs](https://docs.github.com/en/actions)
- [Terraform Docker Provider](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs)
- [Docker Hub](https://hub.docker.com/)




