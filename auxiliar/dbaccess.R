library(RPostgreSQL)

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


dt <- dbGetQuery(connec, 'select gid, area_imovel, tipo_imove, uf, cod_munici, cd_bioma, flag, nm_cat_fund, nm_agrup, is_recente, is_ocupa_irregular, is_grande, tipo FROM irregularidades.proc5_step14_tipo_oii psto')