library(raster)
library(snow)
library(doMPI)
rm(list=ls())


#Sumarizacao
resume <- function(i) {
  
  #Uma tabela de contagem
  out1 <- data.frame(
    car = getValues(car, row = bss$row[i], nrows = bss$nrows[i]),    
    desmatamento = getValues(desmatamento, row = bss$row[i], nrows = bss$nrows[i]),
    rodovias = getValues(rodovias, row = bss$row[i], nrows = bss$nrows[i]),
    ferrovias = getValues(ferrovias, row = bss$row[i], nrows = bss$nrows[i]),
    silos = getValues(silos, row = bss$row[i], nrows = bss$nrows[i]),
    frigorificos = getValues(frigorificos, row = bss$row[i], nrows = bss$nrows[i]),
    aptidao = getValues(aptidao, row = bss$row[i], nrows = bss$nrows[i])) %>%
    filter(!is.na(car)) %>%
    mutate(desmatamento = ifelse(desmatamento == 0, 0, 1)) %>%
    group_by(car, desmatamento) %>%
    summarise(
      desmatamento = sum(desmatamento, na.rm=T),
      rodovias = min(rodovias, na.rm=T),
      ferrovias = min(ferrovias, na.rm=T),
      silos = min(silos, na.rm=T),
      frigorificos = min(frigorificos, na.rm=T),
      aptidao = mean(aptidao, na.rm=T))
  
  
  
  dt <- data.frame(
    car = getValues(car, row = bss$row[i], nrows = bss$nrows[i]),    
    uso2000 = getValues(mpb2000, row = bss$row[i], nrows = bss$nrows[i]),
    uso2005 = getValues(mpb2005, row = bss$row[i], nrows = bss$nrows[i]),
    uso2010 = getValues(mpb2010, row = bss$row[i], nrows = bss$nrows[i]),
    uso2015 = getValues(mpb2015, row = bss$row[i], nrows = bss$nrows[i]),
    uso2021 = getValues(mpb2021, row = bss$row[i], nrows = bss$nrows[i]),
    value = 1) %>%
    filter(!is.na(car))
  
  
  
  out2 <- expand.grid(uso = c(1,3,4,5,49,10,11,12,32,29,50,13,14,15,18,19,39,20,40,62,41,36,46,47,48,9,21,22,23,24,30,25,26,33,31,27) ,
                     car = unique(dt$car), KEEP.OUT.ATTRS = F)[,c('car','uso')]
  
  
  uso2000 <- out2 %>% left_join(dt[,c('car', 'uso2000', 'value')], by = c('car'='car','uso'='uso2000')) %>%
    filter(!is.na(value)) %>%
    group_by(car, uso) %>%
    summarise(contagem = sum(value, na.rm = T)) %>%
    rename(uso2000 = contagem) %>%
    as_tibble()
  
  
  uso2005 <- out2 %>% left_join(dt[,c('car', 'uso2005', 'value')], by = c('car'='car','uso'='uso2005')) %>%
    filter(!is.na(value)) %>%
    group_by(car, uso) %>%
    summarise(contagem = sum(value, na.rm = T))%>%
    rename(uso2005 = contagem) %>%
    as_tibble()
  
  
  uso2010 <- out2 %>% left_join(dt[,c('car', 'uso2010', 'value')], by = c('car'='car','uso'='uso2010')) %>%
    filter(!is.na(value)) %>%
    group_by(car, uso) %>%
    summarise(contagem = sum(value, na.rm = T))%>%
    rename(uso2010 = contagem) %>%
    as_tibble()
  
  
  uso2015 <- out2 %>% left_join(dt[,c('car', 'uso2015', 'value')], by = c('car'='car','uso'='uso2015')) %>%
    filter(!is.na(value)) %>%
    group_by(car, uso) %>%
    summarise(contagem = sum(value, na.rm = T))%>%
    rename(uso2015 = contagem) %>%
    as_tibble()
  
  
  uso2021 <- out2 %>% left_join(dt[,c('car', 'uso2021', 'value')], by = c('car'='car','uso'='uso2021')) %>%
    filter(!is.na(value)) %>%
    group_by(car, uso) %>%
    summarise(contagem = sum(value, na.rm = T))%>%
    rename(uso2021 = contagem) %>%
    as_tibble()
  
  
  out2 <-  uso2000 %>% left_join(uso2005 , by = c('car','uso')) %>% 
    left_join(uso2010 , by = c('car','uso')) %>% 
    left_join(uso2015 , by = c('car','uso')) %>%
    left_join(uso2021 , by = c('car','uso')) %>%
    as_tibble() ; out2
  
  
    return(list(out1, out2))

}



run <- function() {
  
  nodes <- length(cl)
  
  #Put the functions in the nodes
  for(i in 1:nodes){
    snow::sendCall(cl[[i]], resume, i, tag = i)
  }
  
  
  #Spread the blocks over the processes
  for (i in 1:bss$n) {
    ini <- Sys.time()
    # receive results from a node
    d <- recvOneData(cl)
    # error?
    if (!d$value$success) {
      saveRDS(d, 'erro.rds')
      cat('erro no numero: ', d$value$tag, '\n'); 
      flush.console();
      stop('cluster error')
    }
    # need to send more data?
    ni <- nodes + i
    if (ni <= bss$n) {
      sendCall(cl[[d$node]], resume, ni, tag = ni)
    }
    # which block is this?
    b <- d$value$tag
    print(paste0('recebido bloco: ', b)) ; 
    flush.console()
    
    dbWriteTable(connec, 'proc1_contagem_infra', value = d$value$value[[1]], append = T, row.names =F)
    
    dbWriteTable(connec, 'proc1_contagem_uso',  d$value$value[[2]], append = T, row.names = F)
   
    #print( d$value$value[[1]] )
    rm(d)
    print(Sys.time()-ini)
    
  }

  
  
}

