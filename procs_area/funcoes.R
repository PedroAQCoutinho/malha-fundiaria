library(raster)
library(snow)
library(doMPI)
rm(list=ls())


#Sumarizacao
resume <- function(i) {
  
  dt <- data.frame(desmatamento = getValues(desmatamento, row = bss$row[i], nrows = bss$nrows[i]),
                   car = getValues(car, row = bss$row[i], nrows = bss$nrows[i]),
                   cat_fund = getValues(cat_fund, row = bss$row[i], nrows = bss$nrows[i])) %>%
    group_by(cat_fund, car, desmatamento) %>%
    summarise(count = n())
  
    return(list(dt))

}



atualiza_dt <- function() {
  
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
    
    #atualiza o objeto dt por conta do superassignment <<-
    output[[i]] <<-  d$value$value[[1]]
    #print( d$value$value[[1]] )
    rm(d)
    print(Sys.time()-ini)
    
  }

  
  
}

