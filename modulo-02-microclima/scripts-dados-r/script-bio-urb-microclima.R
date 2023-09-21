microclimadados_daylonmatheusvicky <- microclimas_para_r_daylon_matheus_vicky
microclimadados_daylonmatheusvicky <- as.data.frame(microclimadados_daylonmatheusvicky)
microclimadados_daylonmatheusvicky$altura = factor(microclimadados_daylonmatheusvicky$altura,ordered=T)

saveRDS(microclimadados_daylonmatheusvicky,file="microclimas-daylon-matheus-vicky.Rda")
boxplot(umidpc~altura,
        data=microclimadados_daylonmatheusvicky,
        main="Temperatura por altura",
        xlab="Altura",
        ylab="umidade %",
        col="orange",
        border="brown"
)
