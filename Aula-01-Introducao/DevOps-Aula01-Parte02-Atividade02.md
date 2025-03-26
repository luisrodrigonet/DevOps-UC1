# Aula 1 - Parte 2 - Atividades 2
> ## Exercício Prático
> 1. Crie um repositório no GitHub e clone-o localmente.
> 2. Adicione um script Python ou notebook Jupyter.
> 3. Faça commits com mensagens claras (ex: "Adiciona limpeza de dados").
> 4. Use `git log` para revisar o histórico.
> 
> O objetivo é criar um repositório no GitHub, cloná-lo localmente, adicionar um `script Python` ou `notebook Jupyter`, realizar alguns commits com mensagens claras e revisar o histórico.

## :books: **Passo 1: Criar um Repositório no GitHub**

1. Acesse o GitHub (https://github.com) e faça login na sua conta.
2. Clique no botão **"New"** para criar um novo repositório.
3. Preencha os detalhes:
   - **Repository name:** `DevOps-UC1-Atividade1.2`
   - **Description:** Aula 01 - Parte 02 - Atividade 02
   - Escolha **Public**.
   - Marque a opção **"Add a README file"**.
4. Clique em **"Create repository"**.

## :books: **Passo 2: Clonar o Repositório Localmente**

1. No terminal, navegue até o diretório onde deseja clonar o repositório:

   ```powershell
    c:
    mkdir -p _/devops/
    cd _/devops/
   ```

2. Clone o repositório usando o comando `git clone`:
   ```powershell
   git clone https://github.com/luisrodrigonet/DevOps-UC1-Atividade1.2
   ```

3. Navegue até o diretório do repositório:
   ```powershell
   cd DevOps-UC1-Atividade1.2
   dir
   ```

## :books: **Passo 3: Adicionar um Script Python ou Notebook Jupyter**

1. Crie um arquivo Python para análise de dados:
   ```powershell
   code analise_vendas.py
   ```

2. Abra o arquivo em um editor de texto (ex: VSCode) e adicione o seguinte código:
   ```python
   import pandas as pd

   # Carregar dados de vendas
   dados = pd.read_csv("data/vendas.csv")

   # Calcular total de vendas
   total_vendas = dados["valor"].sum()
   print(f"Total de vendas: R${total_vendas:.2f}")
   ```

3. Crie uma pasta para os dados e adicione um arquivo CSV de exemplo:
   ```powershell
   mkdir data
   echo "id,valor\n1,100.50\n2,200.75\n3,150.00" > data/vendas.csv
   ```

## :books: **Passo 4: Fazer Commits com Mensagens Claras**

1. Verifique o status do repositório:
   ```powershell
   git status
   ```

   Saída esperada:
   ```
   Untracked files:
     (use "git add <file>..." to include in what will be committed)
       analise_vendas.py
       data/
   ```
2. Adicione os arquivos à área de preparação:
   ```powershell
   git add analise_vendas.py data/vendas.csv
   ```

3. Faça o primeiro commit:
   ```powershell
   git commit -m "Adiciona script de análise de vendas e dados iniciais"
   ```

    ```text
     [main 028d4a4] Adiciona script de análise de vendas e dados iniciais
     2 files changed, 9 insertions(+)
     create mode 100644 analise_vendas.py
     create mode 100644 data/vendas.csv
    ```
## :books: **Passo 5: Revisar o Histórico**

1. Visualize o histórico de commits:
   ```powershell
   git log --oneline
   ```

   Saída esperada:
   ```text
   abc1234 (HEAD -> main) Atualiza README com descrição do projeto
   def5678 Adiciona script de análise de vendas e dados iniciais
   ghi9012 Initial commit
   ```

2. Para ver detalhes de um commit específico:
   ```powershell
   git show abc1234
   ```

## :books: **Passo 6: Enviar Alterações para o Repositório Remoto**

1. Envie os commits para o GitHub:
   ```powershell
   git push origin main
   ```
   
   ```text
    Enumerating objects: 6, done.
    Counting objects: 100% (6/6), done.
    Delta compression using up to 16 threads
    Compressing objects: 100% (4/4), done.
    Writing objects: 100% (5/5), 626 bytes | 313.00 KiB/s, done.
    Total 5 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
    To https://github.com/luisrodrigonet/DevOps-UC1-Atividade1.2
       c592e37..028d4a4  main -> main
   
   ```

2. Verifique no GitHub se as alterações foram enviadas corretamente.

    [Github - Respositório - DevOps-UC1-Atividade1.2](https://github.com/luisrodrigonet/DevOps-UC1-Atividade1.2)
    

## :bookmark: **Resultado Final**

- **Repositório no GitHub:** Contém os arquivos `analise_vendas.py`, `data/vendas.csv` e `README.md`.
- **Histórico de Commits:** Registra todas as alterações com mensagens claras e descritivas.
- **Fluxo de Trabalho:** Pronto para colaboração e versionamento contínuo.

## :dart: **Dicas Adicionais**

1. **.gitignore:**  
   Adicione um arquivo `.gitignore` para excluir arquivos desnecessários (ex: `.env`, `__pycache__/`):
   ```bash
   echo "__pycache__/" > .gitignore
   echo ".env" >> .gitignore
   git add .gitignore
   git commit -m "Adiciona .gitignore"
   ```

2. **Branching:**  
   Crie branches para novas funcionalidades ou análises:
   ```bash
   git checkout -b feature/nova-analise
   ```

3. **Pull Requests:**  
   Use pull requests no GitHub para revisar e integrar alterações de branches.





