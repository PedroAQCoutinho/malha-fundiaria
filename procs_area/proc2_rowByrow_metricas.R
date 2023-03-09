rm(list=ls())
options(scipen = 999)
options(stringsAsFactors = F)
# installing packages
library(pacman)
p_load( raster, rgdal,   dplyr, doMPI, snow,  RPostgreSQL)
#setwd('/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_area')
#source('funcoes.R')
start <- Sys.time()
source('procs_area/funcoes_metricas.R')
tryCatch({
  drv <- dbDriver("PostgreSQL")
  print("Connecting to Database…")
  connec <- dbConnect(drv, 
                      dbname = 'malha_fundiaria',
                      host = 'localhost',
                      port = '5432',
                      user = 'postgres', 
                      password = 'gpp-es@lq')
  print("Database Connected!")
},
error=function(cond) {
  print("Unable to connect to Database.")
})




#dbListTables(connec)[order(dbListTables(connec))]

#dados zonais
car <- raster('../../outputs/car/proc2_array_agg.tif')
cat_fund <- raster('../../outputs/geotiffs/step14_overlay.tif')
#desmatamento
desmatamento <- raster('/home/pedro/hd1/dados_GPP/uso_terra/desmatamento/PRODES/pa_br_desmatamento_PRODES_30m_2000-2021.tif')
#infra
rodovias <- raster('/home/pedro/hd1/dados_GPP/infra/rodovias/rodovias/pa_br_rodoviasProximity_DNIT_30m_2021.tif')
ferovias <- raster('/home/pedro/hd1/dados_GPP/infra/ferrovias/ferrovias/pa_br_ferroviasProximity_DNIT_30m_2021.tif')
silos <- raster('/home/pedro/hd1/dados_GPP/infra/ferrovias/ferrovias/pa_br_ferroviasProximity_DNIT_30m_2021.tif')
frigorificos <- raster('/home/pedro/hd1/dados_GPP/infra/ferrovias/ferrovias/pa_br_ferroviasProximity_DNIT_30m_2021.tif')
#aptidao
aptidao <- raster('/home/pedro/hd1/dados_GPP/uso_terra/mapbiomas/c7/pa_br_usoterra_1986_mapbiomas7_30m.tif')
#uso da terra
uso2000 <- raster('/home/pedro/hd1/dados_GPP/uso_terra/mapbiomas/c7/pa_br_usoterra_2000_mapbiomas7_30m.tif')
uso2005 <- raster('/home/pedro/hd1/dados_GPP/uso_terra/mapbiomas/c7/pa_br_usoterra_2005_mapbiomas7_30m.tif')
uso2010 <- raster('/home/pedro/hd1/dados_GPP/uso_terra/mapbiomas/c7/pa_br_usoterra_2010_mapbiomas7_30m.tif')
uso2015 <- raster('/home/pedro/hd1/dados_GPP/uso_terra/mapbiomas/c7/pa_br_usoterra_2015_mapbiomas7_30m.tif')
uso2021 <- raster('/home/pedro/hd1/dados_GPP/uso_terra/mapbiomas/c7/pa_br_usoterra_2021_mapbiomas7_30m.tif')



#id_cat_fund <- dbGetQuery(connec, "select * from layer_fundiario.step15_id_label")
bss <- blockSize(desmatamento, minrows = 100) ; bss
output <- vector('list', bss$n)

out <- dbGetQuery(connec, 'select distinct gid from dados_brutos.valid_sicar_imovel where gid < 200')



dt <- data.frame(desmatamento = getValues(desmatamento, row = bss$row[i], nrows = bss$nrows[i]),
                 car = getValues(car, row = bss$row[i], nrows = bss$nrows[i]),
                 cat_fund = getValues(cat_fund, row = bss$row[i], nrows = bss$nrows[i])) %>%
  group_by(cat_fund, car, desmatamento) %>%
  summarise(count = n())











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
dbWriteTable(connec, 'proc1_area', output)
snow::stopCluster(cl)
print(paste0('Elapsed time: ', Sys.time()-start))