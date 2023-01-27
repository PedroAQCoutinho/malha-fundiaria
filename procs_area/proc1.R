rm(list=ls())
options(scipen = 999)
options(stringsAsFactors = F)

#libraries
library(raster)
library(snow)
library(doMPI)
library(RPostgreSQL)
library(dplyr)



#dados
desmatamento <- raster('/home/pedro/hd1/dados_GPP/uso_terra/desmatamento/PRODES/desmatamento_prodes_2000_2021_4326.tif')
#NAvalue(desmatamento) <- 0
car <- raster('/home/pedro/hd1/pedro/GPP/ltmodel/outputs/geotiffs/sicar_imovel.tif')
#NAvalue(car) <- 0
cat_fund <- raster('/home/pedro/hd1/pedro/GPP/ltmodel/outputs/geotiffs/step14_overlay.tif')
#NAvalue(cat_fund) <- 0
output <- data.frame()
bss <- blockSize(desmatamento, minrows = 10) ; bss


u <- 5000
dt <- data.frame(desmatamento = getValues(desmatamento, row = bss$row[u], nrows = bss$nrows[u]),
                 car = getValues(car, row = bss$row[u], nrows = bss$nrows[u]),
                 cat_fund = getValues(cat_fund, row = bss$row[u], nrows = bss$nrows[u])) %>%
  group_by(cat_fund, car, desmatamento) %>%
  summarise(count = n())




