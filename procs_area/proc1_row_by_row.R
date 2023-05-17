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
            
DROP TABLE IF EXISTS public.proc1_row_by_row_mapbiomas_17052023; 
CREATE TABLE public.proc1_row_by_row_mapbiomas_17052023 (
cat_fund integer null,
desmatamento integer null,
uso integer null,
prioritarias integer null,
count integer null

);


CREATE INDEX proc1_row_by_row_mapbiomas_17052023_cat_fund_idx ON public.proc1_row_by_row_mapbiomas_17052023 USING btree (cat_fund);
CREATE INDEX proc1_row_by_row_mapbiomas_17052023_desmatamento_idx ON public.proc1_row_by_row_mapbiomas_17052023 USING btree (desmatamento);
CREATE INDEX proc1_row_by_row_mapbiomas_17052023_uso_idx ON public.proc1_row_by_row_mapbiomas_17052023 USING btree (uso);
CREATE INDEX proc1_row_by_row_mapbiomas_17052023_prioritarias_idx ON public.proc1_row_by_row_mapbiomas_17052023 USING btree (prioritarias);
CREATE INDEX proc1_row_by_row_mapbiomas_17052023_count_idx ON public.proc1_row_by_row_mapbiomas_17052023 USING btree (count);

")



#dados
desmatamento <- raster('/home/arquivos/dados_espaciais/uso_solo/desmatamento/PRODES/pa_br_desmatamento_PRODES_30m_2000-2021.tif')
uso <- raster('/home/arquivos/dados_espaciais/uso_solo/mapbiomas7/pa_br_usoterra_2021_mapbiomas7_30m.tif')
prioritarias <- raster('/home/arquivos/dados_espaciais/projetos/escolhas/pa_br_areasPrioritariasPreservacao_MMA_30m.tif')
NAvalue(prioritarias) <- 0
cat_fund <- raster('/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_area/proc6_malha.tif')
NAvalue(cat_fund) <- 0
#id_cat_fund <- dbGetQuery(connec, "select * from layer_fundiario.step15_id_label")
bss <- blockSize(desmatamento, minrows = 100) ; bss
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







