rm(list=ls())
options(scipen = 999)
options(stringsAsFactors = F)
# installing packages
library(pacman)
p_load( raster, rgdal,   dplyr, doMPI, snow, raster, RPostgreSQL)
setwd('/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_area')
source('funcoes.R')

tryCatch({
  drv <- dbDriver("PostgreSQL")
  print("Connecting to Database…")
  connec <- dbConnect(drv, 
                      dbname = 'malha_fundiaria',
                      host = '34.71.4.88', 
                      port = '5433',
                      user = 'postgres', 
                      password = 'gpp-es@lq')
  print("Database Connected!")
},
error=function(cond) {
  print("Unable to connect to Database.")
})

dbWriteTable()
#dbListTables(connec)[order(dbListTables(connec))]

#dados
desmatamento <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/projetos/escolhas/pa_br_desmatamento_GPP_30m_1988-2021.tif')
car <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/projetos/escolhas/sicar_imovel.tif')
Navalues(car) <- 0
cat_fund <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/projetos/escolhas/step14_overlay.tif')
Navalues(cat_fund) <- 0
#id_cat_fund <- dbGetQuery(connec, "select * from layer_fundiario.step15_id_label")
bss <- blockSize(desmatamento, minrows = 100) ; bss
output <- vector('list', bss$n)


#Cluster start
cl <- snow::makeSOCKcluster(32)
registerDoMPI(cl)
#Load libraries
snow::clusterEvalQ(cl, library(raster))
snow::clusterEvalQ(cl, library(dplyr))
snow::clusterExport(cl=cl,
                    ls())

atualiza_dt()
output <- data.frame(do.call(rbind, output))
saveRDS(output, '/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_area/proc1_area.rds')
dbWriteTable(connec, Id(schema = "layer_fundiario", table = "proc1_area_raw"), a)
snow::stopCluster(cl)
