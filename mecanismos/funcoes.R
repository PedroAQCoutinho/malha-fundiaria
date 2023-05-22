library(raster)
library(snow)
library(doMPI)
rm(list=ls())


#Sumarizacao
resume <- function(i) {
  
  dt <- data.frame(mecanismo = getValues(mecanismo, row = bss$row[i], nrows = bss$nrows[i]),
                   mun = getValues(mun, row = bss$row[i], nrows = bss$nrows[i]),
                   uso = getValues(uso, row = bss$row[i], nrows = bss$nrows[i])) %>%
    group_by(mecanismo, mun, uso) %>%
    summarise(count = n())
  
    return(list(dt))
  
}





atualiza_dt <- function() {
  
  nodes <- length(cl)
  
  #Put the functions in the nodes
  for(i in 1:nodes){
    snow::sendCall(cl[[i]], resume, i, tag = i)
  }
  
  #outwriteStart
  
  #Spread the blocks over the processes
  for (i in 1:bss$n) {

    ini <- Sys.time()
    # receive results from a node - aqui está a sua tabela da funcao resume
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
    
    
    
    #MEXE AQUI
    #atualiza o objeto dt por conta do superassignment <<-
    y <- d$value$value[[1]]
    #print( d$value$value[[1]] )
    dbWriteTable(connec, 'proc_mecanismos', y, row.names = F, append = T)
        
    
    rm(d)
    print(Sys.time()-ini)
    
  }

  
  
}

