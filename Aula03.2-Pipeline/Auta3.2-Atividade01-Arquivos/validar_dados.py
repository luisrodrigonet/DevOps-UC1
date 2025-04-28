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
    