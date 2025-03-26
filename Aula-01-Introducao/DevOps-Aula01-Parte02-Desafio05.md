# Aula 1 - Parte 2 - Desafio 5
> ## :globe_with_meridians: **Desafio de Branches**
>   - Implementar gitflow em um projeto existente
>   - Criar branches para:
>       - Features 
>       - Hotfixes
>       - Release
>   - Documentar o processo de merge e versionamento
> 
> Neste exercício, vamos implementar o **Gitflow** em um projeto existente. 
>  O Gitflow é um modelo de branching que define um fluxo de trabalho estruturado para desenvolvimento, lançamento e manutenção de software.
> Vamos criar branches para **features**, **hotfixes** e **release**, além de documentar o processo de merge e versionamento.

## :one: Visão Geral do Gitflow

O **gitflow** é um modelo de ramificação que organiza o desenvolvimento e o versionamento de um projeto de forma estruturada. 

Seus principais elementos são:

- **Branch `master` (ou `main`)**: Contém apenas os commits de produção, que já foram testados e versionados (marcados com tags).

- **Branch `develop`**: É a linha de integração para os commits de features que serão lançadas na próxima release.

- **Branches de feature (`feature/…`)**: Ramificações criadas a partir de `develop` para desenvolver novas funcionalidades.

- **Branches de release (`release/…`)**: Criadas a partir de `develop` quando se inicia um ciclo de lançamento, para preparar e corrigir detalhes antes da publicação.

- **Branches de hotfix (`hotfix/…`)**: Criadas a partir de `master` para correção rápida de bugs em produção, que devem ser mescladas tanto em `master` quanto em `develop`.

### Instalando a extensão `git-flow`

Se você quiser usar a extensão `git-flow`, instale-a:
- No Linux:
    ```bash
    sudo apt-get install git-flow
    ```
  
- No macOS (com Homebrew):
    ```bash
    brew install git-flow
    ```

- No Windows 11 (Chocolatey )

    O **Chocolatey** é um gerenciador de pacotes para Windows que simplifica a instalação. 
    
    Se você ainda não o tem instalado, siga estas etapas:
    
    1. **Instale o Chocolatey** (como administrador):  
       Abra o PowerShell como **Administrador** e execute:
       ```powershell
       Set-ExecutionPolicy Bypass -Scope Process -Force
       iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/insta ll.ps1'))
        ```

    1. **Instale o git-flow AVH Edition** (versão mais atualizada):
       ```powershell
       choco install git-flow-avh
       ```
   
    1. **Verificação da Instalação**
        Abra o **Git Bash** ou **PowerShell** e execute:
        ```bash
        git flow version
        ```
        Se a instalação foi bem-sucedida, você verá uma mensagem como:
        ```
        git-flow (AVH Edition) X.X.X
        ```

---

## :two: Implementação do Gitflow em um Projeto Existente

### :books: Criando e clonando um repositório

:books: **Criar repositório no GitHub**  

  1. Crie um repositório público/privado (ex: `DevOps-UC1-Desafio1.2.5`). 
        - Nome: `DevOps-UC1-Desafio1.2.5`.
        - Descrição: "DevOps-UC1-Desafio1.2.5 - GitFlow"
        - Marque a opção **"Add a README file"**.
        
  1. Realize o clone do repositório: 
  ```power
  git clone  https://github.com/luisrodrigonet/DevOps-UC1-Desafio1.2.5.git
  cd DevOps-UC1-Desafio1.2.5
  ```

### :books: Preparação: Criar a Branch `develop`

No diretório do projeto, inicialize o Gitflow:
```bash
git flow init
```

```text
Which branch should be used for bringing forth production releases?
   - main
Branch name for production releases: [main]
Branch name for "next release" development: [develop]

How to name your supporting branch prefixes?
Feature branches? [feature/]
Bugfix branches? [bugfix/]
Release branches? [release/]
Hotfix branches? [hotfix/]
Support branches? [support/]
Version tag prefix? []
```

Aceite as configurações padrão para os nomes das branches:
- `main` (ou `master`) para produção.
- `develop` para desenvolvimento.

Se o projeto atual possui apenas a branch principal (por exemplo, `master`), é necessário criar a branch `develop` a partir dela:

```powershell
# Partindo da branch master, crie a branch develop
git checkout -b develop master

# Verifique a branch atual 
git branch

# Faça o push da branch develop para o repositório remoto (se aplicável)
git push -u origin develop
```

> **Nota:** A branch `develop` será a base para todas as funcionalidades futuras.

---

### :books: Criação de Branches para Features

Cada nova funcionalidade deve ser desenvolvida em uma branch separada, criada a partir de `develop`.

**Exemplo para uma feature:**

```bash
# Cria e muda para a branch de feature
git checkout -b feature/minha-nova-funcionalidade develop

# Verificando a Branch atual
git branch

# Desenvolva sua feature, edite os arquivos e faça commits
git add .
git commit -m "Implementa a funcionalidade X"

# Após concluir, envie a branch para o remoto
git push -u origin feature/minha-nova-funcionalidade
```

**Merge da Feature:**

Depois que a feature for revisada (via pull request, por exemplo) e aprovada, ela deverá ser mesclada de volta em `develop`:

```bash
# Mude para a branch develop
git checkout develop

# Mescle a feature
git merge --no-ff feature/minha-nova-funcionalidade -m "Merge da feature: Implementa a funcionalidade X"

# Opcional: Exclua a branch de feature localmente
git branch -d feature/minha-nova-funcionalidade

# Envie a atualização de develop para o remoto
git push origin develop
```

### :loudspeaker: Feature com `git-flow`

- Retorna para a `branch` **main**

    ```powershell
    git checkout main
    ```

- Crie uma `branch` para uma nova funcionalidade (ex: adicionar normalização de dados):

    ```bash
    git flow feature start normalizacao-dados
    ```

    ```text
    Switched to a new branch 'feature/normalizacao-dados'

    Summary of actions:
    
    - A new branch 'feature/normalizacao-dados' was created, based on 'develop'
    - You are now on branch 'feature/normalizacao-dados'
    
    Now, start committing on your feature. When done, use:
    
         git flow feature finish normalizacao-dados
    ```

- Adicione o código no script `limpeza.py`:

    ```powershell
    code scripts/limpeza.py
    ```

    ```python
    def normalizar_dados(dados):
       return (dados - dados.mean()) / dados.std()
    ```

- Faça o commit:
   ```bash
   git add scripts/limpeza.py
   git commit -m "Adiciona função para normalização de dados"
   ```

- Finalize a feature e faça o merge na branch `develop`:
   ```bash
   git flow feature finish normalizacao-dados
   ```

    ```text
    Switched to branch 'develop'
    Updating f3b3905..674b537
    Fast-forward
     scripts/limpeza.py | 2 ++
     1 file changed, 2 insertions(+)
     create mode 100644 scripts/limpeza.py
    Deleted branch feature/normalizacao-dados (was 674b537).
    
    Summary of actions:
    - The feature branch 'feature/normalizacao-dados' was merged into 'develop'
    - Feature branch 'feature/normalizacao-dados' has been locally deleted
    - You are now on branch 'develop'
    ```

---

### :books: Criação de Branch de Release

Quando estiver pronto para preparar um novo lançamento, crie uma branch de release a partir de `develop`.

**Exemplo:**

```bash
# Crie a branch release a partir de develop
git checkout -b release/1.0 develop

# Faça ajustes necessários: atualização de versão, documentação, correções de pequenos bugs, etc.
# Exemplo: Atualize a versão no README.md ou em um arquivo de configuração

git add .
git commit -m "Prepara release 1.0: atualiza versão e documentação"

# Envie a branch de release para o remoto
git push -u origin release/1.0
```

**Finalização da Release:**

Quando a branch de release estiver pronta:

1. **Mesclar na `main`:**

   ```bash
   git checkout main
   git merge --no-ff release/1.0 -m "Merge da release 1.0: versão pronta para produção"
   ```

2. **Marcar a versão (tag):**

   ```bash
   git tag -a v1.0 -m "Release versão 1.0"
   ```

3. **Mesclar na `develop`:**

   ```bash
   git checkout develop
   git merge --no-ff release/1.0 -m "Merge da release 1.0 em develop"
   ```

4. **Excluir a branch de release:**

   ```bash
   git branch -d release/1.0
   git push origin --delete release/1.0
   ```

5. **Enviar as alterações e as tags para o remoto:**

   ```bash
   git push origin main
   git push origin develop
   git push origin --tags
   ```
   
   
### :loudspeaker: Release com `git-flow`

1. Prepare uma nova versão para lançamento:
   ```bash
   git flow release start v1.0.0
   ```

2. Atualize o `README.md` com as novas funcionalidades:
   ```markdown
   # Projeto de Análise de Dados

   ## Versão 1.0.0
   - Adicionada normalização de dados.
   - Corrigido cálculo de média.
   ```

3. Faça o commit:
   ```bash
   git add README.md
   git commit -m "Prepara release v1.0.0"
   ```

4. Finalize a release e faça o merge nas branches `main` e `develop`:
   ```bash
   git flow release finish v1.0.0
   ```

---

### :books: Criação de Branch de Hotfix

Quando for necessário corrigir um bug crítico em produção, crie uma branch de hotfix a partir da branch `master`.

**Exemplo:**

```bash
# Crie a branch hotfix a partir de master
git checkout -b hotfix/1.0.1 master

# Faça as correções necessárias
# Exemplo: Corrija um bug crítico em um arquivo

git add .
git commit -m "Corrige bug crítico na funcionalidade Y (hotfix 1.0.1)"

# Envie a branch de hotfix para o remoto
git push -u origin hotfix/1.0.1
```

**Finalização do Hotfix:**

Após a correção:

1. **Mesclar na `master`:**

   ```bash
   git checkout master
   git merge --no-ff hotfix/1.0.1 -m "Merge do hotfix 1.0.1: correção de bug crítico"
   ```

2. **Marcar a nova versão:**

   ```bash
   git tag -a v1.0.1 -m "Hotfix versão 1.0.1"
   ```

3. **Mesclar na `develop`:**

   ```bash
   git checkout develop
   git merge --no-ff hotfix/1.0.1 -m "Merge do hotfix 1.0.1 em develop"
   ```

4. **Excluir a branch de hotfix:**

   ```bash
   git branch -d hotfix/1.0.1
   git push origin --delete hotfix/1.0.1
   ```

5. **Enviar as alterações e as tags para o remoto:**

   ```bash
   git push origin master
   git push origin develop
   git push origin --tags
   ```

### :loudspeaker: Hotfix com git-flow

1. Suponha que há um bug na função de média no script `analise.py`. Crie uma branch para o hotfix:
   ```bash
   git flow hotfix start correcao-media
   ```

2. Corrija o bug:
   ```python
   def media(valores):
       return sum(valores) / len(valores) if valores else 0
   ```

3. Faça o commit:
   ```bash
   git add scripts/analise.py
   git commit -m "Corrige cálculo de média para lista vazia"
   ```

4. Finalize o hotfix e faça o merge nas branches `main` e `develop`:
   ```bash
   git flow hotfix finish correcao-media
   ```


---

## :three: Documentação do Processo de Merge e Versionamento

É fundamental documentar todo o fluxo de trabalho. Uma sugestão é atualizar o arquivo `CHANGELOG.md` ou incluir uma seção no `README.md` explicando:

### :books: Exemplo de Documentação:

**Conteúdo do arquivo:**

```md
# Processo de Versionamento e Merge – Gitflow

## Branches Principais
- **master**: Contém o código em produção. Cada merge nesta branch é acompanhado por uma tag de versão.
- **develop**: Branch de integração das features. Todas as novas funcionalidades são mescladas aqui.

## Fluxo de Trabalho

### Features
1. Criação da branch:
   ```
   git checkout -b feature/nome-da-feature develop
   ```
2. Desenvolvimento e commits com mensagens claras.
3. Merge na branch `develop` após revisão:
   ```
   git checkout develop
   git merge --no-ff feature/nome-da-feature -m "Merge da feature: descrição"
   ```

### Releases
1. Criação da branch de release:
   ```
   git checkout -b release/1.0 develop
   ```
2. Atualizações de versão, documentação e correções finais.
3. Merge na `master` e `develop`, criação de tag:
   ```
   git checkout master
   git merge --no-ff release/1.0 -m "Merge da release 1.0"
   git tag -a v1.0 -m "Release 1.0"
   git checkout develop
   git merge --no-ff release/1.0 -m "Merge da release 1.0 em develop"
   ```
4. Exclusão da branch de release.

### Hotfixes
1. Criação da branch de hotfix:
   ```
   git checkout -b hotfix/1.0.1 master
   ```
2. Correção do bug e commits.
3. Merge na `master` e `develop`, criação de tag:
   ```
   git checkout master
   git merge --no-ff hotfix/1.0.1 -m "Merge do hotfix 1.0.1"
   git tag -a v1.0.1 -m "Hotfix 1.0.1"
   git checkout develop
   git merge --no-ff hotfix/1.0.1 -m "Merge do hotfix 1.0.1 em develop"
   ```
4. Exclusão da branch de hotfix.

## Observações
- Utilize o comando `--no-ff` para manter um histórico de merge claro.
- Sempre sincronize as branches locais com o remoto (utilize `git pull` ou `git fetch` + `git merge`).
- Atualize o `CHANGELOG.md` com as mudanças de cada release/hotfix para facilitar o acompanhamento do histórico de versões.
```

---

## :four: Conclusão

Esta atividade apresenta um fluxo completo de implementação do `gitflow` em um projeto existente, com:

- Criação da branch `develop` a partir da `master`.
- Desenvolvimento de funcionalidades em branches de feature.
- Preparação de releases em branches dedicadas, com merge tanto na `master` quanto na `develop` e criação de tags de versão.
- Correção rápida de bugs em produção por meio de branches de hotfix, mescladas em ambas as branches principais.
- Documentação clara do processo de merge e versionamento, facilitando a comunicação e a manutenção do projeto.

Seguir esses passos garante um fluxo colaborativo bem estruturado, com histórico limpo e versionamento eficiente, facilitando a manutenção e o crescimento do projeto.
