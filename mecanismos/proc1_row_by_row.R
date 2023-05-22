rm(list=ls())
options(scipen = 999)
options(stringsAsFactors = F)
# installing packages
library(pacman)
p_load( raster, rgdal,   dplyr, doMPI, snow,  RPostgreSQL)
#setwd('/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_area')
#source('funcoes.R')
source('/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_area/funcoes.R')
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



dbSendQuery(connec, "
            
DROP TABLE IF EXISTS public.proc_mecanismos; 
CREATE TABLE public.proc_mecanismos (
mecanismo integer null,
mun integer null,
uso integer null,
count integer null

);


CREATE INDEX proc_mecanismos_mecanismo_idx ON public.proc_mecanismos USING btree (mecanismo);
CREATE INDEX proc_mecanismos_mun_idx ON public.proc_mecanismos USING btree (mun);
CREATE INDEX proc_mecanismos_uso_idx ON public.proc_mecanismos USING btree (uso);
CREATE INDEX proc_mecanismos_count_idx ON public.proc_mecanismos USING btree (count);

")



#dados
mecanismo <- raster('/home/arquivos/dados_espaciais/projetos/escolhas/mecanismos.tif')
uso <- raster('/home/arquivos/dados_espaciais/uso_solo/mapbiomas7/pa_br_usoterra_2021_mapbiomas7_30m.tif')
mun <- raster('/home/arquivos/dados_espaciais/limites_administrativos/pa_br_limiteMunicipios_30m_2006_ibge_4326.tif')
bss <- blockSize(mecanismo, minrows = 100) ; bss
output <- vector('list', bss$n)




#Cluster start
cl <- snow::makeSOCKcluster(8, outfile="")
registerDoMPI(cl)
#Load libraries
snow::clusterEvalQ(cl, library(raster))
snow::clusterEvalQ(cl, library(dplyr))
snow::clusterExport(cl=cl,
                    ls())



atualiza_dt()



snow::stopCluster(cl)
print(paste0('Elapsed time: ', Sys.time()-start))







