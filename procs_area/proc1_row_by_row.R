rm(list=ls())
options(scipen = 999)
options(stringsAsFactors = F)
# installing packages
library(pacman)
p_load( raster, rgdal,   dplyr, doMPI, snow,  RPostgreSQL)
#setwd('/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_area')
#source('funcoes.R')

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

source('/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_area/funcoes.R')


#dbListTables(connec)[order(dbListTables(connec))]

#dados
desmatamento <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/uso_solo/desmatamento/PRODES/pa_br_desmatamento_PRODES_30m_2000-2021.tif')
car <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/limites_administrativos/car/proc2_array_agg.tif')
NAvalue(car) <- 0
cat_fund <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/projetos/escolhas/step14_overlay.tif')
NAvalue(cat_fund) <- 0
#id_cat_fund <- dbGetQuery(connec, "select * from layer_fundiario.step15_id_label")
bss <- blockSize(desmatamento, minrows = 100) ; bss
output <- vector('list', bss$n)




#Cluster start
cl <- snow::makeSOCKcluster(16, outfile="")
registerDoMPI(cl)
#Load libraries
snow::clusterEvalQ(cl, library(raster))
snow::clusterEvalQ(cl, library(dplyr))
snow::clusterExport(cl=cl,
                    ls())

atualiza_dt()
output <- data.frame(do.call(rbind, output))
saveRDS(output, 'proc1_area.rds')
dbWriteTable(connec, 'proc1_area', a)
snow::stopCluster(cl)
