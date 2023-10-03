# Primeiro,importar os dados para o R usando a funcao import dataset do Rstudio
#depois converter os dados para um dataframe usando a funcao as.dataframe
#exemplo
#importei a planilha excel intitulada 
# dados-completos-para-r-microclima-modulo-2-biourb-2023-02.xls
#esta planilha tem as seguintes colunas:
# grupo medida ambiente altura temp umid
# a coluna grupo tem o nome do grupo
# a coluna medida tem o ponto de medicao que foi feita (calcada1, calcada2, etc)
# a coluna ambiente tem o habitat medido: calcada, gramado, arvore, bosque, cerrado, emergente
# a coluna altura tem o nome da altura medida: chao, joelho, cintura
# a coluna temp tem a temperatura medida em graus celsius
# a coluna umid tem a umidade relativa medida em %
#
#Depois que importei vou converter para um dataframe:
microclima <- as.data.frame(dados_completos_para_r_microclima_modulo_2_biourb_2023_02)
# Agora tenho um dataframe com os dados. Vamos converter as variaveis grupo, medida, ambiente, altura
# para variaveis categoricas, embora tenham sido importadas como caracter
microclima$grupo <- as.factor(microclima$grupo)
microclima$medida <- as.factor(microclima$medida)
microclima$ambiente <- as.factor(microclima$ambiente)
microclima$altura <- as.factor(microclima$altura)

#Vamos salvar o dataframe para uso futuro no computador:
saveRDS(microclima,file="microclima.Rda")

# Agora vamos fazer um boxplot da temperatura por ambiente:
boxplot(temp~ambiente,
        data=microclima,
        main="Temperatura por Ambiente",
        xlab="Ambiente",
        ylab="temp celsius",
        col="orange",
        border="brown"
)
# E um boxplot da umidade por ambiente:
boxplot(umid~ambiente,
        data=microclima,
        main="Umidade por Ambiente",
        xlab="Ambiente",
        ylab="umidade relativa %",
        col="orange",
        border="brown"
)
# Mais um boxplot de temperatura por altura
boxplot(temp~altura,
        data=microclima,
        main="Temperatura por Altura",
        xlab="Altura",
        ylab="temp celsius",
        col="orange",
        border="brown"
)
# E um boxplot de umidade por altura
boxplot(umid~altura,
        data=microclima,
        main="Umidade por Altura",
        xlab="Altura",
        ylab="umidade relativa %",
        col="orange",
        border="brown"
)
# E agora vamos fazer uma analise de variancia  para ver se ha 
# efeito significativo de habitat na temperatura e na umidade

#Primeiro temos de testar as hipoteses de normalidade e de homogeneidade de variancias:
# Premissas
# 1. Normalidade
shapiro.test(microclima$temp)
shapiro.test(microclima$umid)

# 2. Homocedasticidade
# Usaremos o test de levene que calcula a homocedasticidade
# H0 = variancia entre os grupos igual
# levene.test(y = vetor numerico, group = fator dos dados)
install.packages("lawstat")
library(lawstat)
levene.test(microclima$temp, group = microclima$ambiente)
levene.test(microclima$umid, group = microclima$ambiente)

# Os resultados mostram que os dados nao sao normais nem homoscedasticos
# Portanto nao podemos usar anova parametrica
#Iremos entao usar o teste nao parametrico de analise de variancia Kruskall Wallis

# Comparacao da temperatura por habitat teste Kruskall Wallis
kruskal.test(temp ~ ambiente, data = microclima)

#Comparacao da umidade por habitat teste Kruskall Wallis
kruskal.test(umid ~ ambiente, data = microclima)

# A variacao entre habitats para temperatura e umidade e altamente significativa

