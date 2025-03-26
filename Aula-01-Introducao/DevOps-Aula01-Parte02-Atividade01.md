# Aula 1 - Parte 2 - Atividades 1

>  ## GIT e GitHub - Configuração e Comandos Básicos
>
> Serão apresentados os conceitos e comandos básicos 

## :one: Introdução ao Git

O Git é um sistema de controle de versão distribuído que possibilita o rastreamento de alterações no código, a colaboração em equipe e a manutenção do histórico completo de um projeto. Em desenvolvimento de software e análise de dados, ele assegura que cada modificação seja registrada, facilitando a identificação de erros e garantindo a reprodutibilidade dos resultados.

## :two: Configuração Inicial do Git

> Antes de começar a trabalhar, é importante configurar o Git com seus dados pessoais. Essas informações serão usadas para identificar os commits que você criar.

Para configurar o Nome de Usuário e o Email no Git, abra o terminal (ou Git Bash) e execute os seguintes comandos, substituindo os valores pelos seus dados:

```powershell
git config --global user.name "Seu Nome"
git config --global user.email "seuemail@example.com"
git config --global init.defaultBranch main
```

**Sintaxe**:

-  **--global**: Aplica a configuração para todos os repositórios do seu sistema.  

**Atenção**:
 
-  Cada commit será "assinado" com estas informações, permitindo que você e os demais colaboradores saibam quem realizou cada alteração.

Para verificar as configurações, use:

```powershell
git config --list
```

## :three: Comandos Essenciais do Git

### :books: Inicialização de Repositório (`git init`)

O comando `git init` transforma um diretório em um repositório Git, criando uma pasta oculta `.git` onde todo o histórico e metadados serão armazenados.

**Exemplo:**

```powershell
c:
mkdir -p _/devops/meu-projeto
cd _/devops/meu-projeto
git init
```

**Saída Esperada:**

```
Initialized empty Git repository in /caminho/do/diretorio/meu-projeto/.git/
```

**Contexto de Uso:** 
 
 - Utilize esse comando quando você iniciar um projeto do zero ou quiser versionar um diretório que ainda não está sob controle de versão.

**Observação:**  
 
 - A pasta `.git` (oculta) armazena todo o histórico e metadados do repositório. Não a modifique manualmente!

### :books: Clonagem de Repositório (`git clone`)

O comando `git clone` copia um repositório remoto para sua máquina local. Ele baixa todo o histórico e os arquivos do repositório.

**Exemplo:**

```powershell
git clone https://github.com/usuario/nome-do-repositorio.git
```

**Saída Esperada:**

```
Cloning into 'repositorio'...
remote: Enumerating objects: 100, done.
remote: Counting objects: 100% (100/100), done.
remote: Compressing objects: 100% (80/80), done.
Receiving objects: 100% (100/100), 1.5 MiB | 2.3 MiB/s, done.
Resolving deltas: 100% (40/40), done.
```

 **Contexto de Uso:** 
 
  - Quando você deseja colaborar em um projeto já existente ou obter uma cópia completa de um repositório remoto.

### :books: Adição de Arquivos (`git add`)

O comando `git add` é usado para colocar alterações (novos arquivos, modificações ou exclusões) na área de preparação (staging area) antes do commit.

**Exemplos:**

- Adicionar um único arquivo:
  
  ```powershell
  echo "#Script em python" > script.py
  git add script.py
  ```

- Adicionar todos os arquivos modificados:
  
  ```powershell
  git add .
  ```

- Adicionar todos os arquivos de uma pasta:
  
  ```bash
  git add pasta/
  ```

**Contexto de Uso:** 
 
    - Sempre que você fizer alterações e quiser prepará-las para um commit, use o `git add`.

**Observação:**  
 
    - A área de staging permite selecionar quais alterações serão registradas no commit.

---

### :books: Criação de Commits (`git commit`)

Após preparar as alterações com o `git add`, o comando `git commit` grava essas mudanças no repositório local como um "instantâneo" do projeto.

**Exemplo:**

```powershell
git commit -m "Adiciona script de análise inicial"
```

**Saída Esperada:**

```
[main 1a2b3c4] Adiciona script de análise inicial
 1 file changed, 100 insertions(+)
 create mode 100644 arquivo.csv
```

**Contexto de Uso:** 

- Sempre que um conjunto de alterações estiver pronto para ser registrado de forma permanente no histórico do projeto.

**Importância da Mensagem:** 

- Use mensagens claras e descritivas para facilitar a compreensão das alterações realizadas.

### :books: Verificação de Status (`git status`)

O comando `git status` mostra o estado atual do seu diretório de trabalho e da área de preparação. Ele indica quais arquivos foram modificados, quais estão sendo rastreados e quais estão prontos para commit.

**Exemplo:**

```powershell
git status
```

**Saída Típica:**

```
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
    modified:   script.py

Untracked files:
  (use "git add <file>..." to include in what will be committed)
    novo_arquivo.ipynb
```

**Saída Comum:** 

- Pode informar “**nothing to commit, working directory clean**” quando não há alterações não commitadas, ou listar arquivos “modificados” e “não rastreados”.

**Contexto de Uso:** 

- Use este comando frequentemente para saber em que ponto do fluxo de trabalho você está.

### :books: Visualização de Histórico (`git log`)

O comando `git log` exibe o histórico de commits do repositório, mostrando informações como o ID do commit, autor, data e mensagem.

**Exemplo:**

```powershell
git log
```

**Saída:**

```
commit 1a2b3c4d5e6f7g8h9i0j (HEAD -> main)
Author: João Silva <joao@email.com>
Date:   Mon Sep 25 10:00:00 2023 -0300

    Adiciona visualização de dados no notebook

commit a1b2c3d4e5f6g7h8i9j0k
Author: Maria Souza <maria@email.com>
Date:   Sun Sep 24 15:30:00 2023 -0300

    Corrige erro na importação de dados
```

**Opções Úteis:**
 
    - `git log --oneline`: Exibe o histórico de forma resumida (um commit por linha).
    
    - `git log --graph --decorate --all`: Mostra o histórico de forma gráfica, ideal para visualizar branches.
    
    - `git log --graph --all`:  Histórico com gráfico de branches

**Contexto de Uso:** 

    -  Use `git log` para revisar as alterações realizadas e entender a evolução do projeto.

## :four:  Demonstração Prática - Fluxo Básico de Trabalho:

1. Configure o Git:
   
   ```bash
   git config --global user.name "Luis Rodrigo dot Net"
   git config --global user.email "luis.rodrigo.net@gmail.com"
   git config --global init.defaultBranch main
   ```

2. Crie um repositório:
   
   ```bash
   mkdir projeto-analise
   cd projeto-analise
   git init
   ```

3. Adicione um arquivo e faça o primeiro commit:
   
   ```bash
   echo "# Análise de Dados de Vendas" > README.md
   git add README.md
   git commit -m "Cria README inicial"
   ```

4. Verifique o histórico:
   
   ```bash
   git log --oneline
   ```

## :five: Dicas Finais

1. **Ignore Arquivos Desnecessários:**  
   Crie um arquivo `.gitignore` para excluir pastas como `data/temp/` ou arquivos como `.env`.

2. **Sincronização com Repositório Remoto:**  
   Após clonar ou criar um repositório, use `git push` para enviar commits ao GitHub/GitLab.

3. **Corrija Commits Recentes:**  
   Use `git commit --amend` para corrigir mensagens ou adicionar arquivos esquecidos.

## :six: Resumo dos comandos

| Comando           |   Descrição                   |
| --------------    | -----------                   |             
| **git init**    | para iniciar um repositório   | 
| **git clone**   | para copiar um repositório remoto |
| **git add**     | para preparar alterações  |
| **git commit**  | para salvar um instantâneo das alterações |
| **git status**  | para verificar o estado do repositório |
| **git log**     | para visualizar o histórico de commits |
