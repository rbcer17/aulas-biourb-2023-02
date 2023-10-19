# Primeiro,importar os dados para o R usando a funcao import dataset do Rstudio
#depois converter os dados para um dataframe usando a funcao as.dataframe
#exemplo
#importei a planilha excel intitulada 
# dados-microclima-jardim-louise-e-ib.xls
#esta planilha tem as seguintes colunas:
# grupo jardim estrutura individuo classe medicao altura umidade temperatura
# a coluna jardim tem 2 classes, exotico ou nativo
# a coluna estrutura  tem 3 classes, arvore arbusto touceira
# a coluna individuo tem 1 classe para cada individuo medido
# a coluna medicao tem 1 classe para cada individuo e altura medido
# a coluna altura tem 3 classes: 5cm 55cm, 105cm
# a coluna temperatura tem a temperatura medida em graus celsius
# a coluna umidade tem a umidade relativa medida em %
#
#Depois que importei vou converter para um dataframe:
microclima <- as.data.frame(dados-microclima-jardim-louise-e-ib)
# Agora tenho um dataframe com os dados. Vamos converter as variaveis grupo, medida, ambiente, altura
# para variaveis categoricas, embora tenham sido importadas como caracter
microclima$jardim <- as.factor(microclima$jardim)
microclima$estrutura <- as.factor(microclima$estrutura)
microclima$altura <- as.factor(microclima$altura)

#Vamos salvar o dataframe para uso futuro no computador:
saveRDS(microclima,file="microclima.Rda")

# Agora vamos fazer um boxplot da temperatura por ambiente:
boxplot(temperatura~jardim,
        data=microclima,
        main="Temperatura por Ambiente",
        xlab="Ambiente",
        ylab="temp celsius",
        col="orange",
        border="brown"
)
# E um boxplot da umidade por ambiente:
boxplot(umidade~jardim,
        data=microclima,
        main="Umidade por Ambiente",
        xlab="Ambiente",
        ylab="umidade relativa %",
        col="orange",
        border="brown"
)
# Mais um boxplot de temperatura por altura
boxplot(temperatura~altura,
        data=microclima,
        main="Temperatura por Altura",
        xlab="Altura",
        ylab="temp celsius",
        col="orange",
        border="brown"
)
# E um boxplot de umidade por altura
boxplot(umidade~altura,
        data=microclima,
        main="Umidade por Altura",
        xlab="Altura",
        ylab="umidade relativa %",
        col="orange",
        border="brown"
)
# E agora vamos fazer uma analise de variancia  para ver se ha 
# efeito significativo de habitat na temperatura e na umidade

resultado3 <- aov(umid ~ ambiente+altura+ambiente:altura, data = microclima)
summary(resultado3)
resultado4 <- lm(umid ~ ambiente+altura+ambiente:altura, data = microclima)
summary(resultado4)

resultado5 <- aov(temp ~ ambiente+altura+ambiente:altura, data = microclima)
summary(resultado5)
resultado6 <- lm(temp ~ ambiente+altura+ambiente:altura, data = microclima)
summary(resultado6)

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

