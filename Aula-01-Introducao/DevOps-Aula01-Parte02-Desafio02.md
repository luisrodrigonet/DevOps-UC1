# Aula 1 - Parte 2 - Desafio 2
> ## GIT e GitHub - Configuração e Comandos Básicos
> 
> 1. Em duplas, simule um fluxo colaborativo:
>    - Um aluno cria uma feature branch e faz alterações.
>    - O outro revisa o código e aprova o PR.
> 2. Crie um conflito proposital e resolva-o juntos.
>
> Vamos simular um fluxo colaborativo entre dois desenvolvedores, **Alice** e **Bob**, que trabalham em um projeto de análise de dados. O objetivo é criar uma feature branch, fazer alterações, revisar o código e integrar as mudanças na branch principal (`main`) através de um pull request.

--- 

# Resposta

## **Passo 1: Configuração Inicial**

### :cat: **Alice (Desenvolvedora 1):**
1. Clona o repositório:

2. Cria uma nova branch para a funcionalidade:

3. Adiciona um script para geração de gráficos:

4. Faz o commit das alterações:

5. Envia a branch para o repositório remoto:

## **Passo 2: Revisão de Código**

### :dog: **Bob (Desenvolvedor 2):**
1. Clona o repositório (se ainda não tiver):
  

2. Atualiza o repositório local:

3. Visualiza as branches disponíveis:

4. Acessa a branch da Alice para revisão:

5. Revisa o código no arquivo `graficos.py` e sugere melhorias:

6. Faz o commit das sugestões:

7. Envia as alterações para o repositório remoto:


## **Passo 3: Integração via Pull Request**

### :cat: **Alice:**

1. No GitHub, abre um **Pull Request (PR)**:

2. Solicita revisão de Bob.

### :dog: **Bob:**
1. Revisa o PR, aprova as alterações e faz comentários, se necessário.

### :cat: **Alice:**

1. Faz ajustes finais, se houver feedbacks.

2. Faz o `merge` do PR no GitHub.

---

## **Passo 4: Atualização do Repositório Local**

### :cat: **Alice e Bob:** :dog:

1. Atualizam o branch `main` local:

2. Verificam as alterações integradas:

---

## **Passo 5: Resolução de Conflitos**

Vamos simular um conflito para praticar a resolução.

### :cat: **Alice:**

1. Cria uma nova branch:

2. Adiciona um script para geração de tabelas:

3. Faz o commit:

4. Envia a branch para o repositório remoto:

### :dog: **Bob:**

1. No branch `main`, modifica o mesmo arquivo

3. Tenta fazer merge da branch da Alice:

4. Resolve o conflito manualmente:

5. Finaliza o merge:

## Resumo da atividade

1. **Repositório no GitHub:**

   - Contém as branches `feature/adiciona-graficos` e `feature/adiciona-tabelas`.
   
   - O branch `main` reflete as alterações integradas via PR e `merge`.

2. **Histórico de Commits:**
   - Use `git log --oneline` para verificar os `commits` realizados.

3. **Resolução de Conflitos:**
   - O arquivo `tabelas.py` deve conter as alterações combinadas de **Alice** e **Bob**.

4. **Fluxo de Trabalho:**
   - Colaboração eficiente com `branches`, `pull requests` e revisão de código.



