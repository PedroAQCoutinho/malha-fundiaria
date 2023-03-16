rm(list=ls())
options(scipen = 999)
options(stringsAsFactors = F)
# installing packages
library(pacman)
p_load( raster, rgdal,   dplyr, doMPI, snow,  RPostgreSQL)
#setwd('/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_area')
#source('funcoes.R')
source('../malha-fundiaria/procs_area/funcoes.R')
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


#dados
desmatamento <- raster('../../outputs/geotiffs/pa_br_desmatamento_GPP_30m_1988-2021.tif')
car <- raster('../../outputs/car/proc2_array_agg.tif')
NAvalue(car) <- 0
cat_fund <- raster('../../outputs/geotiffs/step14_overlay.tif')
NAvalue(cat_fund) <- 0
#id_cat_fund <- dbGetQuery(connec, "select * from layer_fundiario.step15_id_label")
bss <- blockSize(desmatamento, minrows = 100) ; bss
output <- vector('list', bss$n)




#Cluster start
cl <- snow::makeSOCKcluster(4, outfile="")
registerDoMPI(cl)
#Load libraries
snow::clusterEvalQ(cl, library(raster))
snow::clusterEvalQ(cl, library(dplyr))
snow::clusterExport(cl=cl,
                    ls())



atualiza_dt()



snow::stopCluster(cl)
print(paste0('Elapsed time: ', Sys.time()-start))







