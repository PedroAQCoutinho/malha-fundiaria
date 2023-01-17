library(raster)
library(snow)
library(doMPI)
rm(list=ls())


#F.D.A
fda <- function(i, t, u) {
  
    x <- data.frame(uses = getValues(use[[t]], row = bss$row[i], nrows = bss$nrows[i]),
                    dif =  getValues(dif[[t]], row = bss$row[i], nrows = bss$nrows[i]),
                    cd_uf = getValues(state, row = bss$row[i], nrows = bss$nrows[i]))
    x <- subset(x, uses == u)
    n_tot <- x %>% group_by(cd_uf)%>%summarise(n_tot=sum(uses, na.rm = T)/u)
    x <- merge(x, unit_breaks, by="dif")
    z <- x %>% dplyr::group_by(cd_uf, uses, breaks)%>%dplyr::summarise(temp = dplyr::n())
  
    return(list(z, n_tot))

}
agrega <- function(dt, z, n_tot ) {
  
  dt <- merge(dt, z, by = c("cd_uf", "uses", "breaks"), all.x = T)
  dt <- merge(dt, n_tot, by = "cd_uf", all.x = T)
  dt$count <- ifelse(is.na(dt$temp), dt$count, dt$count + dt$temp)
  dt$count_tot <-  ifelse(is.na(dt$count_tot), dt$n_tot, 
                          ifelse(is.na(dt$n_tot),dt$count_tot, dt$n_tot + dt$count_tot))
  dt <- dt[,-c(8,9)]
  
  dt <<- dt
  
}
atualiza_dt <- function(dt, t, u) {
  
  nodes <- length(cl)
  
  #Put the functions in the nodes
  for(i in 1:nodes){
    snow::sendCall(cl[[i]], fda, list(i, t, u), tag = i)
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
      sendCall(cl[[d$node]], fda, list(ni, t, u), tag = ni)
    }
    # which block is this?
    b <- d$value$tag
    print(paste0('recebido bloco: ', b)) ; 
    flush.console()
    
    #atualiza o objeto dt por conta do superassignment <<-
    agrega(dt, d$value$value[[1]], d$value$value[[2]])
    
    rm(d)
    print(Sys.time()-ini)
    
  }
  
  #Write and export
  

  
  
  
}



#Function for table management
cria_vetores <- function(i, t){
  #Get vectors
  x <- getValues(use[[t]], row = bss$row[i], nrows = bss$nrows[i])
  y <- getValues(dif[[t]], row = bss$row[i], nrows = bss$nrows[i])
  uf = getValues(state, row = bss$row[i], nrows = bss$nrows[i])
  w <- getValues(uso_out, row = bss$row[i], nrows = bss$nrows[i])
  r <- getValues(remaining, row = bss$row[i], nrows = bss$nrows[i])
  x[x[] != u ] = NA 
  x[uf[] != s ] = NA
  y[uf[] != s ] = NA
  y[y[] > thresh] = NA #masking pixels above threshold
  z <- x
  z[is.na(y[])] = NA #masking LULC pixels that are NA in prob_raster
  x[z[] == u ] = NA #Removing pixels used in this transition
  z[z[]==u] = u_fin #Changing pixels values to the new use
  w[uf[]==s] = z
  r[uf[]==s] = x
  rm(x,y,uf,z)
  return(list(w, r))
  
}




#Function for exporting results
atualiza_raster <- function(uso_out, remaining, dt){
  
  
  #cl <- raster::beginCluster()
  # set flag that cluster is available again
  #on.exit(returnCluster())
  nodes <- length(cl)
  
  #Put the functions in the nodes
  for(i in 1:nodes){
    snow::sendCall(cl[[i]], cria_vetores, list(i, t), tag = i)
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
      sendCall(cl[[d$node]], fun_ex, ni, tag = ni)
    }
    
    # which block is this?
    b <- d$value$tag
    print(paste0('recebido bloco: ', b)) ; 
    flush.console()
    
    uso_out <- writeValues(uso_out, z, bss$row[i])
    remaining <- writeValues(remaining, x, bss$row[i])
    
    rm(d)
    print(Sys.time()-ini)
  }
  
  return(NULL)
  
}



