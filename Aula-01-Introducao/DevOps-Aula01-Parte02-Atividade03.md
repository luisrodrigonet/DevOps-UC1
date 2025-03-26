# Aula 1 - Parte 2 - Atividades 3
> Esta atividade envolve a colaboração no Git, abrangendo desde a criação de branches até a integração final na branch principal por meio de pull requests.
> 
> Serão explorados comandos essenciais (push, pull, fetch), além de conceitos como revisão de código (code review), resolução de conflitos e boas práticas no fluxo de trabalho

## :one: Visão Geral do Trabalho Colaborativo

O Git é uma ferramenta distribuída de controle de versão que possibilita a colaboração entre diversos desenvolvedores ou analistas em um mesmo projeto. 

Quando pensamos em trabalho colaborativo apoiado pelo `git`, destacamos:

- **Branches**: criação, navegação e fusão (*merge*).

- **Repositórios remotos**: operações de *push*, *pull* e *fetch*.

- **Pull requests**: como propor mudanças para revisão (*code review*) antes de mesclar no código principal.

- **Resolução de conflitos**: como lidar com divergências no código quando duas ou mais alterações entram em choque.

---

## :two: Branches

### :books: Conceito de Branch

Uma `branch` é uma linha de desenvolvimento independente dentro do repositório Git. Seu objetivo é isolar novas **funcionalidades**, **correções** ou **experimentos** sem afetar o código principal (geralmente a *branch* `main` ou `master`).

**Vantagens de usar branches**:
- Manter o código principal estável.
- Possibilitar o trabalho simultâneo de vários desenvolvedores em diferentes funcionalidades.
- Facilitar a revisão e a fusão das mudanças de maneira organizada.

### :books: Criação de Branch

Para criar uma nova `branch`, utilizamos o comando:

```bash
git checkout -b nome-da-branch
```

:pushpin: Esse comando:
1. Cria a `branch` (`git branch nome-da-branch`).
2. Faz o `checkout` (troca) para essa nova `branch` (`git checkout nome-da-branch`).

### :books: Navegação entre Branches

Para trocar de `branch`, usamos:

```bash
git checkout nome-da-branch
```

Ou, em versões mais recentes do Git, pode-se usar:

```bash
git switch nome-da-branch
```

Listar branches existentes:

```bash
git branch
```

- Trocar de branch:
```powershell
git checkout main
```

- Criar e trocar para um novo branch em um único comando:

```powershell
  git checkout -b bugfix/correcao-erro
```

### :books: Merge de Branches

Após concluir o desenvolvimento em uma `branch`, precisamos mesclá-la (fazer `merge`) na `branch` principal ou em outra `branch`. Há duas abordagens comuns:

1. **Merge direto** (fast-forward ou merge commit):

    Supondo que queremos mesclar "feature-branch" em "main"

   ```powershell
      git checkout main
      git merge feature-branch
   ```

**Observação:**  

    - Sempre faça merge a partir do branch que receberá as alterações (ex: `main`).

2. **Pull request** (abordagem recomendada em plataformas como **GitHub**, **GitLab** e **Bitbucket**):

   - Você cria um `pull request` para a `branch` principal.
   - Equipe revisa as mudanças e aprova.
   - Ao final, mescla-se a `branch` no repositório remoto.

    Este assunto será tratada em um outro momento.

---

## :three: Repositórios Remotos

Um repositório remoto é uma versão do seu projeto hospedada em um servidor (por exemplo, **GitHub**, **GitLab** ou **Bitbucket**), que permite colaboração entre diversas pessoas.

### :books: Configuração de Remote

Para vincular um repositório local a um repositório remoto, usamos:

```bash
git remote add origin https://github.com/usuario/repositorio.git
```

**Observações**:

- `origin` é o nome padrão do repositório remoto principal.
- Pode haver vários remotos, cada um com um nome diferente, porem geralmente utilizamos apenas um, que é o `origin`

--- 

### :books: Enviando alterações para o repositório remoto (*push*)

Após realizar `commits` localmente, usamos:

```bash
git push origin nome-da-branch
```

Exemplo de como enviar uma `branch` para o repositório remoto:

```bash
git push origin feature/nova-funcionalidade
```

Outro exemplo seria:

```
git push origin feature-branch` 
```

Neste segundo exemplo estamos enviando a `branch` `feature-branch` para o repositório remoto.

### :books: Obtendo alterações do repositório remoto (*pull* e *fetch*)


### `git fetch` 
- busca as atualizações do repositório remoto
- não mescla automaticamente com sua *branch* local. 
- você pode ver o que mudou antes de mesclar.

**Baixar alterações**:
  ```bash
  git fetch origin
  ```

**Verificar diferenças**:
  ```bash
  git diff main origin/main
  ```

### `git pull`

- equivale a `git fetch` + `git merge` (ou `git rebase`, dependendo da configuração). 

- traz as mudanças remotas e as mescla diretamente na sua *branch* atual.

Como exemplo de uso na `branch` `main`, podemos executar:

  ```bash
  git pull origin main
  ```

---

## :four: Pull Requests e Code Review

### :books: O que é um Pull Request

O `pull request` (PR) é um pedido de integração de uma *branch* com outra (geralmente da *branch* de feature para a *branch* `main`). 

O pedido é aberto no serviço de hospedagem do repositório (**GitHub**, **GitLab**, etc.). 

### :books: Fluxo de Trabalho com Pull Requests

#### **Descrição do processo**

1. **Crie uma branch** (ex.: `feature-branch`) e implemente suas alterações.

2. **Faça commits** das mudanças localmente e envie (*push*) a *branch* para o repositório remoto.

3. **Abra um pull request** na plataforma, escolhendo a *branch* de destino (ex.: `main`).

4. **Revisão de código (code review)**:
   - Outros membros do time analisam o PR, fazem comentários, solicitam mudanças ou aprovam.

5. **Merge**:
   - Após aprovação, o PR é mesclado. A *branch* `feature-branch` passa a integrar a *branch* principal.

#### **Executando o processo**

1. Envie seu branch para o repositório remoto:
   ```bash
   git push origin feature/nova-funcionalidade
   ```

2. No GitHub (ou outro serviço), abra um **Pull Request (PR)**:
   
   - Acesse a página do repositório.
   
   - Clique em **"Pull Requests"** > **"New Pull Request"**.
   
   - Selecione o branch de origem (`feature/nova-funcionalidade`) e o branch de destino (`main`).
   
   - Adicione uma descrição clara do que foi feito.

3. Solicite revisão de colegas (code review).

### :books: Code Review

#### **Descrição do processo**

- Verificar se as mudanças atendem ao propósito.
- Avaliar qualidade do código, organização e padrões adotados.
- Testar se há impactos em outras partes do sistema.
- Sugerir melhorias.
- Revisores podem comentar no código, sugerir melhorias ou aprovar o PR.
- Faça ajustes, se necessário, e envie novos `commits` ao `branch`:

#### **Executando o processo**

```bash
git add arquivo_modificado.py
git commit -m "Corrige sugestões do code review"
git 
```

###  :books:  Merge do Pull Request**
- Após aprovação, faça o merge do PR no GitHub.
- Exclua o branch remoto após o merge (opcional).

---

## :five: Resolução de Conflitos

Conflitos surgem quando duas ou mais pessoas alteram a mesma parte de um arquivo de maneiras diferentes. 

Ao tentar fazer `merge` ou `pull`, o Git avisa sobre conflitos:
```
CONFLICT (content): Merge conflict in arquivo.py
Automatic merge failed; fix conflicts and then commit the result.
```

O Git marca essas diferenças em seu arquivo, por exemplo:

```bash
<<<<<<< HEAD
  console.log("Mudança na branch local");
=======
  console.log("Mudança na branch remota");
>>>>>>> origin/main
```


### :books: Como Resolver Conflitos

1. **Identifique** o arquivo em conflito (o Git avisará durante o `git merge` ou `git pull`).

2. **Edite o arquivo** removendo as marcações `<<<<<<<`, `=======` e `>>>>>>>`, escolhendo manualmente a melhor forma de unir as alterações.

3. **Adicione** o arquivo novamente com `git add arquivo`.

4. **Finalize** com `git commit` para concluir a mesclagem.

```bash
git add arquivo.py
git commit
```


### :books: Dicas para Evitar Conflitos Frequentes

- Fazer *pull* ou *fetch* regularmente, mantendo a *branch* atualizada.
- Criar *branches* específicas para cada funcionalidade.
- Comunicar-se com a equipe sobre partes sensíveis do código que possam sofrer alterações.

## :six:  Exemplo Prático

Para este exemplo utilizaremos o **repositório da atividade 02** (`DevOps-UC1-Atividade1.2`)

### Passo a Passo

1. **Verificando as branchs existentes**:
    ```powershell
    git branch
    ```
    
    ```text
    * main
    ```

1. **Crie uma branch de feature**:
   ```bash
   git checkout -b feature-login
   ```
   
   ```text
   Switched to a new branch 'feature-login'
   ```
   
1. **Verificando as branchs existentes**:
    ```powershell
    git branch
    ```
    
    ```text
    * feature-login
    main
    ```
   
1. **Implemente as alterações** no código (por exemplo, um novo formulário de login).

    ```powershell
    echo "# Formulário" > cad_form.py
    dir
    ```
    
1. Verificando o status do repositorio

    ```powershell
    git status
    ```
    
    ```text
    On branch feature-login
    Untracked files:
      (use "git add <file>..." to include in what will be committed)
            cad_form.py
    
    nothing added to commit but untracked files present (use "git add" to track)
    ```
   
1. **Faça commits**:
   ```bash
   git add .
   git commit -m "Formulário de Cadastro"
   ```
   
    ```text
    [feature-login 5d3db61] Formulário de Cadastro
     1 file changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 cad_form.py
    ```

1. **Envie a branch** para o remoto:
   ```bash
   git push origin feature-login
   ```
   
   ```text
   Enumerating objects: 4, done.
    Counting objects: 100% (4/4), done.
    Delta compression using up to 16 threads
    Compressing objects: 100% (2/2), done.
    Writing objects: 100% (3/3), 421 bytes | 421.00 KiB/s, done.
    Total 3 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
    remote:
    remote: Create a pull request for 'feature-login' on GitHub by visiting:
    remote:      https://github.com/luisrodrigonet/DevOps-UC1-Atividade1.2/pull/new/feature-login
    remote:
    To https://github.com/luisrodrigonet/DevOps-UC1-Atividade1.2
     * [new branch]      feature-login -> feature-login
   ```


1. **Abra um Pull Request** no GitHub (ou outra plataforma), selecionando `feature-login` como branch de origem e `main` como destino.

    - Acesse o github

        ![00 pull request001](img/00-pull-request001-.png)
        
    - Selecione a opção "Pull Request"
        
        ![00 pull request002](img/00-pull-request002.png)
    
    - Somos direcionados para uma nova tela
    
        ![00 pull request003](img/00-pull-request003.png)
    
    - Selecione o botão **New pull request**

    - Selecione o `branch` `feature-login`
    
        ![00 pull request004](img/00-pull-request004.png)
        
    - Somos direcionados a tela confirmando a criação do `Pull Request`
    
        ![00 pull request005](img/00-pull-request005.png)

    - Selecione o botão `Create pull request`
    
    - Adicione uma descrição e selecione o botão `Create pull request`
        
        ![00 pull request006](img/00-pull-request006.png)
        
    - Finalizamos a criação do `pull request`

        ![00 pull request007](img/00-pull-request007.png)


1. **Solicite revisão** de colegas. Aguarde comentários ou aprovações.


1. **Caso haja conflitos**, resolva localmente ou pela interface web:
   - Puxe as alterações da `main` para a sua *branch* (ou rebase), corrija os conflitos e faça novo commit.
   

1. **Após aprovação**, faça o merge do pull request. As mudanças da `feature-login` serão integradas à `main`.

    - Ao acessar a lista de "Pull Request" podemos observar a solicitação realizada

    ![00 pull request008](img/00-pull-request008.png)
    
    - Selecionando-a somos direcionados a tela onde podemos realizar o "Merge". Selecione o botão "Merge pull request"

    ![00 pull request009](img/00-pull-request009.png)
    
    - Selecione "Confirm Merge"
    
    ![00 pull request010](img/00-pull-request010.png)
    
    - A partir deste ponto podemos remover o Branch
    
    ![00 pull request011](img/00-pull-request011.png)
    

---

## :seven:  Fluxo Completo de Trabalho Colaborativo

Vamos simular um fluxo completo, desde a criação de uma feature branch até sua integração na branch principal.

### **Passo 1: Clonar o Repositório**
```powersell
https://github.com/luisrodrigonet/DevOps-UC1-Atividade1.2.git
cd DevOps-UC1-Atividade1.2
```

### **Passo 2: Criar uma Feature Branch**
```powersell
git checkout -b feature/adiciona-graficos
```

### **Passo 3: Fazer Alterações**
1. Adicione um novo script:
   ```powersell
   code graficos.py
   ```

    ```text
    # Gerador de Gráficos
    ```

2. Faça commits:
   ```powersell
   git add graficos.py
   git commit -m "Adiciona script para geração de gráficos"
   ```

### **Passo 4: Enviar para o Repositório Remoto**
```powersell
git push origin feature/adiciona-graficos
```

### **Passo 5: Abrir um Pull Request**

- No GitHub, abra um PR de `feature/adiciona-graficos` para `main`.

- Solicite revisão de colegas.

### **Passo 6: Code Review e Ajustes**

- Faça ajustes com base nos feedbacks:
  ```powersell
  git add graficos.py
  git commit -m "Corrige labels dos gráficos"
  git push origin feature/adiciona-graficos
  ```

### **Passo 7: Merge do Pull Request**

- Após aprovação, faça o merge no GitHub.

- Anternativamente execute o merge localmente
    ```powershell
      git checkout main
      git merge feature/adiciona-graficos
   ```
   
   ```text
    Updating 028d4a4..30cdd97
    Fast-forward
     cad_form.py | Bin 0 -> 30 bytes
     graficos.py |   1 +
     2 files changed, 1 insertion(+)
     create mode 100644 cad_form.py
     create mode 100644 graficos.py
     ```

### **Passo 8: Atualizar o Repositório Local**

1. Volte para o branch `main`:
   ```powersell
   git checkout main
   ```

2. Atualize com as alterações mais recentes:
   ```bash
   git pull origin main

---

### Passo 9: Exclua o branch remoto (opcional).

1. Verificar o histórico local e remoto

    ```powershell
    git log --oneline --graph --all
    ```
    
    ```text
    * 30cdd97 (HEAD -> main, origin/feature/adiciona-graficos, feature/adiciona-graficos) Adiciona script para geração de gráficos
    * 5d3db61 (origin/feature-login, feature-login) Formulário de Cadastro
    * 028d4a4 (origin/main, origin/HEAD) Adiciona script de análise de vendas e dados iniciais
    * c592e37 Initial commit
    ```

    ou utilize uma interface gráfica
    
    ```powershell
    gitk --all
    ```
    

2. Remova os branchs 

    - Localmente 

        ```powershell
        git branch -d feature/adiciona-graficos
        ```
        
        ```text
        Deleted branch feature/adiciona-graficos (was 30cdd97).
        ```
    
    - Remoto 
    
        ```powershell
        git push origin --delete feature/adiciona-graficos
        ```
        
        ```
        To https://github.com/luisrodrigonet/DevOps-UC1-Atividade1.2
        - [deleted]         feature/adiciona-graficos
        ```
        
 
## :eight: Conclusão e Boas Práticas

- **Commits Atômicos:** Faça commits pequenos e focados em uma única alteração.

- **Mensagens Descritivas:** Use mensagens claras e concisas.

- **Use branches para cada feature** ou correção de bug.

- **Sempre faça pull request**: mantenha o *code review* e a qualidade do código.

- **Respeite o fluxo de revisão**: feedback do time é essencial para melhorar a qualidade e evitar problemas futuros.

- **Resolva conflitos prontamente**: quanto mais cedo você integra suas alterações, menos conflitos tendem a aparecer.
