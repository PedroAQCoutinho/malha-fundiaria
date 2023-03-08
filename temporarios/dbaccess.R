## Codigo para executar queries direto na VM. Vc pode executar as queries lá, usando o processamento da nuvem (não afeta o seu PC)
# E só pega os resultados sumarizados para o seu PC

rm(list=ls())
options(scipen = 999)
options(stringsAsFactors = F)
# installing packages
library(pacman)
p_load( raster, rgdal,   dplyr, doMPI, snow,  RPostgreSQL)
#setwd('/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_area')
#source('funcoes.R')
start <- Sys.time()
tryCatch({
  drv <- dbDriver("PostgreSQL")
  print("Connecting to Database…")
  connec <- dbConnect(drv, 
                      dbname = 'malha_fundiaria',
                      host = 'localhost',
                      port = '5433',
                      user = 'postgres', 
                      password = 'gpp-es@lq')
  print("Database Connected!")
},
error=function(cond) {
  print("Unable to connect to Database.")
})


dt <- dbGetQuery(connec, 'SELECT nm_agrup, iscar , sum(area_count) area FROM irregularidades.proc22_step14_desmatamento_anual GROUP BY nm_agrup, iscar')