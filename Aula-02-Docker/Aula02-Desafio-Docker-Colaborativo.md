# Aula 02 - Docker Colaborativo
> 
> Construção colaborativa de um ambiente para análise de dados
>
> Elaborar de forma colaborativa o arquivo `docker-compose.yml` para construção de um ambiente de análise de dados
>
> --- 

**Passo 1:** Criar um `repositório` de uso compartilhado

1. Um aluno deve criar novo repositório privado no GitHub com o arquivo README.md
2. O Proprietário do repositório deve liberar o aceso aos demais membros do grupo
3. Demais membros devem aceitar o acesso ao Repositório
4. Todos devem clonar o repositório. (c:\_devops\)


**Passo 2** Criar uma nova imagem e enviar para o register

- Todos - abrir o arquivo **Aula02-Desafio2.1.md**
- Todos - executar a **Atividade 2️⃣ - Construção de Imagens**

**Objetivo:** Criar um Dockerfile para um ambiente de análise de dados com Python, Pandas e Jupyter, otimizar com multi-stage builds e publicar no Docker Hub.


**Passo 3:** Construir o arquivo `docker-compose.yml`

> Execução da atividade Atividade **3️⃣ - Network e Volumes**de forma colaborativa.

- **Aluno 1** - docker-compose.yml
    - jupyter


- **Aluno 2** - docker-compose.yml
	- postgres


- **Aluno 3** - docker-compose.yml
	- adminer


- **Todos** - Iniciam o ambiente de Análise da dados em suas máquinas