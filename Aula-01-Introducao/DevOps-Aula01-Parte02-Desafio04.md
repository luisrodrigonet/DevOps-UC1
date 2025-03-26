# Aula 1 - Parte 2 - Desafio 4
> ## Exercício Prático Individual - Fundamentos Git
>     1. Projeto de Análise de Dados Colaborativo
>       - Equipes de **3-4** pessoas
>       - Criar um **repositório compartilhado** para análise de um dataset
>       - Cada membro responsável por uma parte específica:
>           1. Limpeza de dados
>           1. Análise exploratória
>           1. Visualizações
>           1. Documentação
> 
>       - Implementar fluxo de trabalho com pull requests e code review

## :triangular_flag_on_post: **Passo 1. Configuração Inicial do Repositório**


:books: **Criar repositório no GitHub**  

  1. Um membro cria um repositório público/privado (ex: `DevOps-UC1-Desafio1.2.4`).   
    
  1. Adiciona os colaboradores ao repositório
  
        
  1. Cada convidado receberá um e-mail de confirmação do convite, que deve ser aceito, antes que ele possa ter acesso ao repositório
  
  1. Quem criou o repositório deve clona-lo e e montar a estrutura de diretórios abaixo:
  
        - Estrutura sugerida do repositório:  
  
            ```bash
            ├── data/                 # Pasta para datasets (raw e limpos)
            ├── scripts/  
            │   ├── limpeza.py        # Script de limpeza de dados  
            │   ├── analise.py        # Análise exploratória  
            │   └── visualizacoes.py  # Visualizações  
            ├── docs/  
            │   └── README.md         # Documentação do projeto  
            └── .gitignore            # Ignorar arquivos temporários/desnecessários
            ```


   1. Todos os demais membros clonam o repositório:
   
---

## :triangular_flag_on_post:**Passo 2. Divisão de Tarefas e Branching**

:books: Cada membro será responsável por uma parte do projeto:

1. **Limpeza de Dados:** Preparar o dataset para análise.
2. **Análise Exploratória:** Realizar estatísticas descritivas e identificar padrões.
3. **Visualizações:** Criar gráficos para representar os dados.
4. **Documentação:** Escrever o README e documentar o processo.

:books: Cada membro trabalha em uma **branch específica** para sua tarefa:  

:books: Cada membro cria uma branch para sua tarefa:

1. :cat: **Membro 00 (Alice) (Limpeza de Dados):**
   ```bash
   git checkout -b feature/limpeza-dados
   ```

2. :dog: **Membro 01 (Bob) (Análise Exploratória):**
   ```bash
   git checkout -b feature/analise-exploratoria
   ```

3. :koala: **Membro 10 (Carol) (Visualizações):**
   ```bash
   git checkout -b feature/visualizacoes
   ```

4. :bear: **Membro 11 (Dave) (Documentação):**
   ```bash
   git checkout -b feature/documentacao
   ```

---

## :triangular_flag_on_post: **Passo 3. Desenvolvimento das Tarefas**

### :books:  :cat: **Alice - Limpeza de Dados:**  

**Adiciona um script `limpeza.py`:**
**Faz o commit:**
**Envia a branch para o repositório remoto**:

### :dog :books: **BOB - Análise Exploratória**:  

Utiliza o dataset limpo para gerar estatísticas e insights (ex: `scripts/analise.py`).  

**Adiciona um script `analise.py`**:

**Faz o commit**:

**Envia a branch para o repositório remoto**:

### :books: :koala:  **Carol - Visualizações**:  

Desenvolve gráficos (ex: histogramas, heatmaps) em `scripts/visualizacoes.py`.  

**Adiciona um script `visualizacoes.py`**:

**Faz o commit**:


**Envia a branch para o repositório remoto**:


### :books: :bear: **Dave - Documentação**:  

Atualiza o `README.md` com objetivos, instruções de uso e resultados.  

```powershell
code docs/README.md
```

**Atualiza o `README.md`**:
   ```markdown
   # Projeto de Análise de Dados

   Este projeto é uma análise colaborativa de um dataset.

   ## Tarefas
   - Limpeza de dados
   - Análise exploratória
   - Visualizações
   ```

**Faz o commit**:
**Envia a branch para o repositório remoto**:

---

## :triangular_flag_on_post: **Passo 4. Fluxo de Trabalho com Pull Requests (PRs) e Code Review**

### :books: **Criar Pull Request no GitHub**:  

Acessar o repositório > *Pull Requests > New Pull Request*.  

Cada membro abre um **Pull Request (PR)** no GitHub:

1. :cat: **Alice:**
   - Branch: `feature/limpeza-dados` → `main`.
   - Descrição: "Adiciona script para limpeza de dados."

2. :dog **Bob:**
   - Branch: `feature/analise-exploratoria` → `main`.
   - Descrição: "Adiciona script para análise exploratória."

3. :koala: **Carol:**
   - Branch: `feature/visualizacoes` → `main`.
   - Descrição: "Adiciona script para visualizações."

4. :bear: **Dave:**
   - Branch: `feature/documentacao` → `main`.
   - Descrição: "Atualiza README com descrição do projeto."

### :books: **Revisão de Código (Code Review)**:  

**Membros revisam o código:** 

- Cada Pull Request (PR) é revisado por pelo menos um outro membro da equipe.

- Verificam lógica, formatação e integridade dos dados.  

- Deixam comentários no Pull Request (PR) (*Files changed* > ícone de comentário).  

- Comentários e sugestões são feitos diretamente no GitHub.

- O autor do Pull Request (PR) faz ajustes, se necessário, e envia novos commits.


### :books: **Aprovação e Merge**:  

- Após ajustes, um revisor aprova o Pull Request (PR) e faz o merge em `main`.  

---

## :triangular_flag_on_post: **Passo 5. Resolução de Conflitos (Cenário Opcional)**

**Se houver conflitos durante o merge**

- O Git avisará sobre conflitos.
- Abra o arquivo com conflitos e combine as alterações manualmente.
- Adicione o arquivo resolvido e finalize o merge:

```bash
git add arquivo_conflitante.py
git commit
```
   
--- 

## :triangular_flag_on_post: **Passo 6. Integração Final**

Após todas as partes serem mescladas em `main`, o repositório final deve conter:  
- Dataset processado e scripts funcionais.  
- Documentação clara e visualizações exportadas (ex: `results/graph1.png`).  


## :triangular_flag_on_post: **Passo 7. Atualização do Repositório Local**


##  :computer: Conteúdo dos arquivos

### :snake: **scripts/limpeza.py**  
```python
import pandas as pd

def limpar_dados():
    # Carregar dados brutos
    df = pd.read_csv('data/raw_data.csv')
    
    # Remover dados faltantes
    df.dropna(inplace=True)
    
    # Remover duplicatas
    df.drop_duplicates(inplace=True)
    
    # Corrigir tipos de dados (exemplo)
    df['data'] = pd.to_datetime(df['data'])
    
    # Salvar dados limpos
    df.to_csv('data/cleaned_data.csv', index=False)
    print("Dados limpos salvos em data/cleaned_data.csv")

if __name__ == "__main__":
    limpar_dados()
```

---

### :snake: **scripts/analise.py**  
```python
import pandas as pd

def analisar_dados():
    df = pd.read_csv('data/cleaned_data.csv')
    
    # Estatísticas básicas
    print("Estatísticas Descritivas:")
    print(df.describe())
    
    # Correlações
    print("\nCorrelações:")
    print(df.corr())
    
    # Contagem de categorias (exemplo)
    print("\nContagem de Categorias:")
    print(df['categoria'].value_counts())

if __name__ == "__main__":
    analisar_dados()
```

---

### :snake: **scripts/visualizacoes.py**  
```python
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

def gerar_visualizacoes():
    df = pd.read_csv('data/cleaned_data.csv')
    
    # Histograma
    plt.figure(figsize=(10, 6))
    sns.histplot(df['valor'], kde=True)
    plt.title('Distribuição de Valores')
    plt.savefig('results/histograma_valores.png')
    
    # Heatmap de correlações
    plt.figure(figsize=(10, 6))
    sns.heatmap(df.corr(), annot=True)
    plt.title('Heatmap de Correlações')
    plt.savefig('results/heatmap.png')
    
    # Boxplot por categoria
    plt.figure(figsize=(10, 6))
    sns.boxplot(x='categoria', y='valor', data=df)
    plt.title('Distribuição por Categoria')
    plt.savefig('results/boxplot_categorias.png')

if __name__ == "__main__":
    gerar_visualizacoes()
```

---

### :snake: **docs/README.md**  

```markdown
# Projeto de Análise de Dados Colaborativo

## Objetivo
Análise do dataset [Nome do Dataset] para identificar padrões e insights relevantes.

## Como Executar
1. Clone o repositório:
   `` `bash
   git clone https://github.com/[usuário]/analise-dados-projeto.git
   `` `
2. Instale as dependências:
   `` `bash
   pip install pandas matplotlib seaborn
   `` `
3. Execute os scripts em ordem:
   `` `bash
   python scripts/limpeza.py
   python scripts/analise.py
   python scripts/visualizacoes.py
   `` `
## Resultados
- Gráficos salvos em `results/`:
  - `histograma_valores.png`: Distribuição dos valores.
  - `heatmap.png`: Correlações entre variáveis.
  - `boxplot_categorias.png`: Comparação por categoria.

## Contribuidores
- [Membro 1]: Limpeza de dados
- [Membro 2]: Análise exploratória
- [Membro 3]: Visualizações
- [Membro 4]: Documentação
```

---

### :snake: **.gitignore**  
```
# Ignorar arquivos temporários e dados sensíveis
__pycache__/
*.pyc
*.pyo
*.pyd
.env
data/raw_data.csv   # Manter apenas cleaned_data.csv no repositório
results/*.png       # Opcional: remover se gráficos forem gerados localmente

# Ignorar configurações de IDE
.idea/
.vscode/
```

---

## :computer: **Checklist de Boas Práticas**

✅ Commits atômicos e mensagens descritivas (ex: "Corrige normalização na limpeza").  
✅ Revisar Pull Request (PR) com atenção a conflitos e dependências entre tarefas.  
✅ Usar `.gitignore` para excluir arquivos temporários (ex: `.ipynb_checkpoints`).  
✅ Garantir que os scripts sejam testados após o merge.

---


