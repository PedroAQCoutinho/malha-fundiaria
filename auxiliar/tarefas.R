library(RPostgre)

tryCatch({
  drv <- dbDriver("Postgre")
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



#tabela de sobreposições das categorias fundiarias que acumulam 95%
dt <- dbGetQuery(connec, 'WITH foo AS (SELECT orilabel , sum(area) area FROM layer_fundiario.proc4_step14_id_label psil 
WHERE nm_cat_fund = "zonas_sobreposicao" and am_legal
GROUP BY orilabel
ORDER BY sum(area) DESC),
bar AS (SELECT *, (sum(area) OVER (ORDER BY area desc))/(sum(area) OVER ()) parea FROM foo)
SELECT * FROM bar WHERE parea<0.96')

write.csv2(dt, 'area_sobreposicoes.csv', row.number = F)


#area dos agrupamentos fundiarios
dt <- dbGetQuery(connec, 'SELECT nm_agrup, sum(area) area FROM layer_fundiario.proc4_step14_id_label psil 
WHERE am_legal
GROUP BY nm_agrup ')

write.csv2(dt, 'area_agrupamentos.csv', row.number = F)


#area da ocii sem sobreposicao
dbGetQuery(connec, 'WITH foo AS (SELECT ROW_NUMBER() OVER (PARTITION BY id_car_break) rn, * FROM car.proc3_id_key WHERE id_car_original IN 
(SELECT car 
FROM irregularidades.proc7_step14_categorizacao psc 
WHERE tipo_irregularidade != 'OSII'))
SELECT sum(area)/10000 FROM foo WHERE rn = 1')






