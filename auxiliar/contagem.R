# O que será feito ?

#• Gráfico da área desmatada acumulada x tempo: dentro e fora dos polígonos do CAR por total, categoria fundiária por bioma
#◦ Incluir tabela com a quantificação por período tratado e com mapa condizente ao período
#• Gráfico do NUMERO de polígonos do CAR x tempo (flagear a data de ocupação de cada polígono com base na data do 1° pixel desmatado) por categoria fundiária, por bioma e por tamanho de imóvel
#◦ Incluir tabela com a quantificação por período tratado e com mapa condizente ao período
#• Gráfico da ÁREA de polígonos do CAR x tempo (flagear a data de ocupação de cada polígono com base na data do 1° pixel desmatado) por categoria fundiária, por bioma e por tamanho de imóvel
#◦ Incluir tabela com a quantificação por período tratado e com mapa condizente ao período


#Area desmatada acumulada x tempo
# - desmatamento x categorias fundiarias
# - contagem de veg nativa por ano (mapbiomas) x categorias fundiarias


#Número de poligonos do CAR por tempo
#- Flagear CAR para valor min(ano desmatamento) x categorias fundiarias


# Área de poligonos do CAR
#- CAR group by ano sum(area)

#opções
rm(list=ls())
options(stringsAsFactors = F)
options(scipen = 999)

#bibliotecas
library(raster)
library(dplyr)
library(foreach)
library(doSNOW)




#dados de entrada
usos <- paste0('/home/pedro/hd1/dados_GPP/uso_terra/mapbiomas/c7/', 
                list.files('/home/pedro/hd1/dados_GPP/uso_terra/mapbiomas/c7/', pattern = '.tif$'))
for (u in seq_along(usos)) {
  
  assign(paste0('uso_', u), raster(usos[u]))

}


NAvalue(uso_1) <-0
NAvalue(uso_2) <-0
NAvalue(uso_3) <-0
NAvalue(uso_4) <-0
NAvalue(uso_5) <-0
NAvalue(uso_6) <-0
NAvalue(uso_7) <-0
NAvalue(uso_8) <-0
NAvalue(uso_9) <-0
NAvalue(uso_10) <- 0
NAvalue(uso_11) <- 0
NAvalue(uso_12) <- 0
NAvalue(uso_13) <- 0
NAvalue(uso_14) <- 0
NAvalue(uso_15) <- 0
NAvalue(uso_16) <- 0
NAvalue(uso_17) <- 0
NAvalue(uso_18) <- 0
NAvalue(uso_19) <- 0
NAvalue(uso_20) <- 0
NAvalue(uso_21) <- 0
NAvalue(uso_22) <- 0
NAvalue(uso_23) <- 0
NAvalue(uso_24) <- 0
NAvalue(uso_25) <- 0
NAvalue(uso_26) <- 0
NAvalue(uso_27) <- 0
NAvalue(uso_28) <- 0
NAvalue(uso_29) <- 0
NAvalue(uso_30) <- 0
NAvalue(uso_31) <- 0
NAvalue(uso_32) <- 0
NAvalue(uso_33) <- 0
NAvalue(uso_34) <- 0
NAvalue(uso_35) <- 0
NAvalue(uso_36) <- 0
NAvalue(uso_37) <- 0


desmatamento <- raster('/home/pedro/hd1/dados_GPP/uso_terra/desmatamento/PRODES/desmatamento_prodes_2000_2021_4326.tif')
NAvalue(desmatamento) <- 0
categorias <- raster('/home/pedro/hd1/pedro/GPP/ltmodel/outputs/categorias_fundiarias_label.tif')
NAvalue(categorias) <- 0
car <- raster('/home/pedro/hd1/pedro/GPP/ltmodel/inputs/CAR/sicar_imovel.tif')
NAvalue(car) <- 0
pixelvn = c(1,3,4,5,49,10,11,12,32,29,50,13)





#Cluster start
cl <- snow::makeCluster(7)
options(rasterClusterObject = cl)
options(rasterClusterCores = length(cl))
options(rasterCluster = TRUE)
options(rasterClusterExclude = NULL)
snow::clusterEvalQ(cl, library(raster))
snow::clusterExport(cl=cl,
                    ls())

bss <- blockSize(car)

output <- foreach(i=1:bss$n, .combine = rbind) %dopar% {
  
  x <- data.frame(car = getValues(car, row = bss$row[i], nrows = bss$nrows[i]),
                  prodes = getValues(desmatamento, row = bss$row[i], nrows = bss$nrows[i]),
                  mapbiomas = getValues(uso_23, row = bss$row[i], nrows = bss$nrows[i]))

  x$mapbiomas <- ifelse(x$mapbiomas %in% pixelvn, 1, 0)
  
  d47 <- which(x$prodes == 7 & x$mapbiomas == 1)
  x$prodes[d47] <- 4
  
  return(x %>% 
           group_by(car) %>%
           filter(!is.na(car)) %>%
           summarise(antropizacao = min(prodes, na.rm=T)) %>%
           mutate(antropizacao = ifelse(is.infinite(antropizacao), 0, antropizacao)))
  
  
}


saveRDS(output, '/home/pedro/hd1/pedro/GPP/ltmodel/outputs/car_flag/car_flag.rds')





