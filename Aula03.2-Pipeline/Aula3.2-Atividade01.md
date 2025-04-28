# Aula 3.2 - Pipeline CI/CD - Atividade 01
> ## Projeto Pipeline CI/CD - Pipeline Básico
> ### Atividades da UC
>   - Validar dados
>   - Gerar relatório
>   - Gerar um gráfico
> 
> ### **Objetivos da Aula**
> 1. Entender os conceitos básicos de CI/CD e sua aplicação em projetos de análise de dados.
> 2. Aprender comandos básicos do Git e configuração de repositórios no GitHub.
> 3. Criar um pipeline CI/CD com GitHub Actions para automatizar tarefas como validação de dados e geração de relatórios.
> 
> ### **Materiais Necessários**
> - Computadores com acesso à internet.
> - Contas no GitHub (criadas previamente ou durante a aula).
> - Editor de texto simples (VS Code, Sublime, ou similar).
> - Exemplo de conjunto de dados (ex: `dados.csv`).
> - Scripts Python de exemplo (validação de dados e geração de relatório).

# **Introdução a CI/CD**  

## **Conceitos-Chave:**  
- **CI (Integração Contínua):** Automatizar testes e validações sempre que código é alterado.  

- **CD (Entrega/Implantação Contínua):** Automatizar a entrega do código validado em produção.  

- **Por que CI/CD para análise de dados?**  
  - Validar dados automaticamente (ex: formato, valores ausentes).  
  - Gerar relatórios atualizados após mudanças no código.  
  - Evitar erros em scripts de processamento.  

>## **Exemplo Prático:**  
> - **Cenário**: Um script Python que processa um CSV diário.  
> - **Problema**: Se o CSV tem valores nulos, o script falha.  
> - **Solução CI/CD**: Um pipeline testa automaticamente o CSV antes de processá-lo.  

# **Git e GitHub Básico**  

- **Git:** Sistema de controle de versão para rastrear mudanças no código.  
- **GitHub:** Plataforma para hospedar repositórios Git e configurar CI/CD.  

## **Atividade Prática:**  
- Criar um repositório no GitHub.  
- Adicionar um arquivo `README.md` e um script `validar_dados.py`.  
- Clonar o repositório remoto em uma pasta local . 

## **Passo a Passo:**  

1. **Instalação do Git** (se necessário) e configuração inicial:  
   ```bash  
   git config --global user.name "Seu Nome"  
   git config --global user.email "seu@email.com"  
   ```  

2. **Comandos Básicos:**  
   - `git init`: Inicializa um repositório local.  
   - `git add .`: Adiciona arquivos ao "stage".  
   - `git commit -m "mensagem"`: Salva as alterações com uma descrição.  
   - `git push`: Envia alterações para o GitHub.  

3. **Criar um Repositório no GitHub:**  
   
   - Crie um novo repositório no GitHub (ex: `meu-projeto-dados`). 
        - **DevOps-UC1-Pipeline01**
   
   - Vincular ao repositório local:  
   
     ```powershell  
     d:
     mkdir -p .\_devops\
     cd .\_devops\
     git clone https://github.com/luisrodrigonet/DevOps-UC1-Pipeline01.git
     cd DevOps-UC1-Pipeline01
     dir 
     ```  

---

# Configuração Inicial

## Criando o arquivo `data.csv` (Dados de Exemplo)

```powershell
code data.csv
```

```txt  
id,nome,idade,salario  
1,Ana,28,5000  
2,Pedro,,4500   # Valor ausente em "idade" 
3,Carla,35,6000  
4,João,40,  # Valor ausente em "salario"
```

*(Obs: Valores ausentes em "idade" e "salario" para teste de validação.)*  

**Explicação:**  
- **Propósito:** Simular um conjunto de dados com valores nulos para testar a validação automática.  
- **Detalhes:**  
  - Colunas: `id` (identificador), `nome`, `idade`, `salario`.  
  - Linhas 2 e 4 possuem valores ausentes (campos vazios), que serão detectados pelo script de validação.  

## Criando o script `validar_dados.py`

```powershell
code validar_dados.py
```

```python  
import pandas as pd  

try:  
    df = pd.read_csv('data.csv')  
    nulos = df.isnull().sum().sum()  
    if nulos > 0:  
        raise ValueError(f"Dados inválidos: {nulos} valores nulos encontrados!")  
    print("Validação concluída: dados OK!")  
except Exception as e:  
    print(f"Erro: {e}")  
    exit(1)  # Falha no pipeline
    
```  

**Explicação:**  

- **Propósito:** Validar automaticamente a integridade dos dados.  
- **Parâmetros/Funcionalidades:**  
  - `pd.read_csv('data.csv')`: Carrega o arquivo CSV em um DataFrame do Pandas.  
  - `df.isnull().sum().sum()`: Calcula o total de valores nulos em todas as colunas.  
  - `exit(1)`: Força a falha do pipeline CI/CD (código de saída 1 indica erro).  


## Atualizar o repositório no GitHub 

Fazer commit e push:  

```bash  
git add .  
git commit -m "Adiciona dados e script de validação"  
git push origin main  
```
---
 
# **Configurando um Pipeline CI/CD com GitHub Actions**  

## **Conceitos:**  
- **Workflow:** Arquivo YAML que define etapas do pipeline.  
- **Eventos:** Gatilhos como `push` ou `pull_request`.  
- **Jobs e Steps:** Tarefas executadas em sequência.  

## **Exemplo de Workflow:**  

1. Criar o arquivo `.github/workflows/ci.yml`:  

    ```powershell
    code .github/workflows/ci.yml
    ```


    ```yaml  
    name: Pipeline de Validação de Dados  
    on: [push] # Executa o pipeline ao detectar um push no repositório  
    
    jobs:  
      validar-dados: # Nome do job 
        runs-on: ubuntu-latest  
        steps:  
          - name: Baixar Código  
            uses: actions/checkout@v4  # Baixa o código do repositório
    
          - name: Configurar Python  
            uses: actions/setup-python@v4  # Instala Python  
            with:  
              python-version: '3.10'  # Versão do Python
    
          - name: Instalar Dependências  
            run: pip install pandas  # Instala o Pandas via pip
    
          - name: Validar Dados  
            run: python validar_dados.py  # Executa o script de validação
    ```

**Explicação Detalhada:**  

- **Estrutura do Workflow:**  
  - **`name`:** Nome do pipeline (aparece na aba **Actions** do GitHub).  
  - **`on: [push]`:** Define o gatilho do pipeline (executa após um `push`).  
  - **`jobs`:** Bloco que agrupa tarefas (jobs) do pipeline.  
  - **`validar-dados`:** Nome do job (pode haver múltiplos jobs).  
  - **`runs-on: ubuntu-latest`:** Executa o job em um servidor Ubuntu.  
    
- **Passos (Steps):**  
  1. **`actions/checkout@v4`:**  
     - **Propósito:** Baixa o código do repositório para o servidor do GitHub Actions.  
     
  2. **`actions/setup-python@v4`:**  
     - **Propósito:** Configura o ambiente Python.  
     - **Parâmetro `python-version`:** Define a versão do Python (ex: 3.10).  
     
  3. **`Instalar Dependências`:**  
     - **Comando `pip install pandas`:** Instala a biblioteca Pandas para o script.  
     
  4. **`Validar Dados`:**  
     - **Comando `python validar_dados.py`:** Executa o script de validação. 
     
**Testando o Pipeline:**  

1. Fazer push do código para o GitHub.  

```bash  
git add .  
git commit -m "Adiciona Workflow"  
git push origin main  
```

2. Acessar a aba **Actions** no repositório para ver o pipeline em execução.  

3. **Resultado Esperado:** O pipeline falhará devido aos valores nulos em `data.csv`.   

# Pipeline com Geração de Relatório

## Script gerar_relatorio.py

```powershell
code gerar_relatorio.py
```

```python  
import pandas as pd  

df = pd.read_csv('data.csv')  
relatorio = df.describe().to_html() # Gera estatísticas em HTML   

with open('relatorio.html', 'w') as f:  
    f.write(f"<h1>Relatório de Dados</h1>\n{relatorio}")  # Salva o HTML 
```  

**Explicação:**  
- **Propósito:** Gerar um relatório HTML com estatísticas descritivas dos dados.  
- **Funcionalidades:**  
  - `df.describe()`: Calcula estatísticas como média, desvio padrão, etc.  
  - `.to_html()`: Converte o DataFrame para formato HTML.  


## **Atualização do Workflow `.github/workflows/ci.yml`**  

```
code .github/workflows/ci.yml
```

```yaml  
name: Pipeline Completo  
on: [push]  

jobs:  
  validar-dados:  
    runs-on: ubuntu-latest  
    steps:  
      - name: Baixar Código
        uses: actions/checkout@v4

      - name: Configurar Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'

      - name: Instalar Dependências
        run: pip install pandas matplotlib  # Adicionado matplotlib para gráficos

      - name: Validar Dados
        run: python validar_dados.py  

      - name: Gerar Relatório  
        run: |  
          python gerar_relatorio.py  
          mv relatorio.html relatorio-${{ github.sha }}.html  # Renomeia o arquivo com o hash do commit 

      - name: Upload Relatório  
        uses: actions/upload-artifact@v4  # Faz upload do relatório  
        with:  
          name: relatorio  
          path: relatorio-*.html  # Caminho do arquivo a ser salvo  
```  

**Explicação dos Novos Passos:**  

1. **`Gerar Relatório`:**  
   - **Comando `mv relatorio.html relatorio-${{ github.sha }}.html`:**  
     - **Propósito:** Renomeia o arquivo com o hash do commit (`github.sha`) para evitar conflitos de nomes.  
   - **`${{ github.sha }}`:** Variável de contexto do GitHub Actions que retorna o hash do commit atual.  

2. **`Upload Relatório`:**  
   - **Ação `actions/upload-artifact@v3`:**  
     - **Propósito:** Salva o relatório como um artefato para download posterior.  
   - **Parâmetros:**  
     - **`name: relatorio`:** Nome do artefato na interface do GitHub.  
     - **`path: relatorio-*.html`:** Padrão para encontrar o arquivo (ex: `relatorio-a1b2c3.html`).


**Testando:**  

1. Corrigir `data.csv` removendo valores nulos.  

2. Fazer push e verificar o relatório na aba **Actions > Artifacts**.  

```powershell
git add .
git status
git commit -m "Atualizacao do arquivo de dados, inclusão do script para gerar o relatório e arquivo ci.yml"
git push origin main
```

# Geração de Grafico após cada commit 

Atualizar o pipeline para
  1. Validar dados.  
  2. Executar um script de análise.  
  3. Gerar um gráfico e o salve como artefato.  
  
## **Script `gerar_grafico.py`**  

```powershell
code gerar_grafico.py
```

```python  
import pandas as pd  
import matplotlib.pyplot as plt  

df = pd.read_csv('data.csv')  
df['idade'].plot(kind='hist')  
plt.title('Distribuição de Idades')  
plt.savefig('grafico.png')  
```  

## **Workflow Atualizado:**  

```powershell
code .github/workflows/ci.yml
```

```yaml 
name: Pipeline Completo
on: [push]

jobs:
  validar-dados:
    runs-on: ubuntu-latest
    steps:
      - name: Baixar Código
        uses: actions/checkout@v4

      - name: Configurar Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.10'

      - name: Instalar Dependências
        run: pip install pandas matplotlib  # Adicionado matplotlib para gráficos

      - name: Validar Dados
        run: python validar_dados.py

      - name: Gerar Relatório e Gráfico
        run: |
          python gerar_relatorio.py
          python gerar_grafico.py
          # Renomeia os arquivos com o hash do commit para evitar conflitos
          mv relatorio.html relatorio-${{ github.sha }}.html
          mv grafico.png grafico-${{ github.sha }}.png # Renomeia com o hash do commit  

      - name: Upload Artefatos
        uses: actions/upload-artifact@v4  # Versão mais recente (v4)
        with:
          name: artefatos-processados
          path: |
            relatorio-*.html
            grafico-*.png # Faz upload de todos os arquivos .png com esse padrão 
```  

**Explicação:**  
- **`plt.savefig('grafico.png')`:** Salva o gráfico como imagem PNG.  
- **`path: grafico-*.png`:** O asterisco (`*`) é um curinga para capturar nomes dinâmicos (ex: `grafico-a1b2c3.png`).  


Fazer push e verificar o relatório na aba **Actions > Artifacts**.  

```powershell
git add .
git status
git commit -m "Inclusão do script para gerar grafico e arquivo ci.yml"
git push origin main
```



---

# **Recursos Adicionais**  

1. **Variáveis de Contexto do GitHub Actions:**  
   - `github.sha`: Hash do commit.  
   - `github.repository`: Nome do repositório.  
   - [Documentação Completa](https://docs.github.com/en/actions/learn-github-actions/contexts).  

2. **Ações Úteis:**  
   - `actions/download-artifact@v4`: Baixa artefatos de workflows anteriores.  
   - `codecov/codecov-action@v4`: Integração com ferramentas de cobertura de código.  

**Observação:**  
- Sempre teste o pipeline após alterações usando `git push`.  
- Use a aba **Actions** do GitHub para depurar erros.  

---

# **Dicas e Melhores Práticas**  
- **Nomenclatura:** Use mensagens de commit claras (ex: "Corrige cálculo de métricas").  
- **Testes:** Adicione testes automatizados para scripts críticos.  
- **Segurança:** Use **Secrets** no GitHub para dados sensíveis (ex: senhas de bancos de dados).  

