import pandas as pd  
import matplotlib.pyplot as plt  

df = pd.read_csv('data.csv')  
df['idade'].plot(kind='hist')  
plt.title('Distribuição de Idades')  
plt.savefig('grafico.png')

