rm(list=ls())
options(scipen = 999)
options(stringsAsFactors = F)
# installing packages
library(pacman)
p_load( raster, rgdal,   dplyr, doMPI, snow,  RPostgreSQL)
#setwd('/home/pedro_alves_coutinho_usp_br/malha-fundiaria/procs_area')
#source('funcoes.R')
start <- Sys.time()
source('funcoes_metricas.R')
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

#dbListTables(connec)[order(dbListTables(connec))]

#dados zonais
car <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/projetos/escolhas/proc2_array_agg.tif')
NAvalue(car) <- 0
#desmatamento
desmatamento <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/uso_solo/desmatamento/PRODES/pa_br_desmatamento_PRODES_30m_2000-2021.tif')
#infra
rodovias <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/infra/rodovias/pa_br_rodoviasProximity_DNIT_30m_2021.tif')
ferrovias <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/infra/ferrovias/pa_br_ferroviasProximity_DNIT_30m_2021.tif')
silos <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/infra/silos/pa_br_silosProximity_30m.tif')
frigorificos <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/infra/silos/pa_br_frigorificosProximity_30m.tif')
#aptidao
aptidao <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/biofisicos/aptidao/pa_br_csr_30m.tif')
#uso da terra
mpb2000 <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/uso_solo/mapbiomas7/pa_br_usoterra_2000_mapbiomas7_30m.tif')
mpb2005 <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/uso_solo/mapbiomas7/pa_br_usoterra_2005_mapbiomas7_30m.tif')
mpb2010 <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/uso_solo/mapbiomas7/pa_br_usoterra_2010_mapbiomas7_30m.tif')
mpb2015 <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/uso_solo/mapbiomas7/pa_br_usoterra_2015_mapbiomas7_30m.tif')
mpb2021 <- raster('/home/pedro_alves_coutinho_usp_br/arquivos/dados_espaciais/uso_solo/mapbiomas7/pa_br_usoterra_2021_mapbiomas7_30m.tif')



#id_cat_fund <- dbGetQuery(connec, "select * from layer_fundiario.step15_id_label")
bss <- blockSize(desmatamento) ; bss

dbSendQuery(connec, "DROP TABLE IF EXISTS public.proc1_contagem_infra;")
dbSendQuery(connec, 'CREATE TABLE public.proc1_contagem_infra (
	gid serial4 not null,
	car integer NULL,
	desmatamento integer NULL,
	rodovias integer NULL,
	ferrovias integer NULL,
	silos integer NULL,
	frigorificos integer NULL,
	aptidao decimal NULL
);')
dbSendQuery(connec, 'CREATE INDEX proc1_contagem_infra_car_idx ON public.proc1_contagem_infra (car);
                    CREATE INDEX proc1_contagem_infra_gid_idx ON public.proc1_contagem_infra (gid);')


dbSendQuery(connec, "DROP TABLE IF EXISTS public.proc1_contagem_uso;")
dbSendQuery(connec, 'CREATE TABLE public.proc1_contagem_uso (
	gid serial4 not null,
  car integer NULL,
  uso integer NULL,
  uso2000 integer NULL,
  uso2005 integer NULL,
  uso2010 integer NULL,
  uso2015 integer NULL,
  uso2021 integer NULL);')
dbSendQuery(connec, 'CREATE INDEX proc1_contagem_uso_car_idx ON public.proc1_contagem_uso USING btree (car);
                    CREATE INDEX proc1_contagem_uso_gid_idx ON public.proc1_contagem_uso USING btree (gid);')

            
            
#Cluster start
cl <- snow::makeSOCKcluster(16, outfile="")
registerDoMPI(cl)
#Load libraries
snow::clusterEvalQ(cl, library(raster))
snow::clusterEvalQ(cl, library(dplyr))
snow::clusterExport(cl=cl,
                    ls())

run()


snow::stopCluster(cl)
print(paste0('Elapsed time: ', Sys.time()-start))