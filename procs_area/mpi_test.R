library(raster)
library(snow)
library(doMPI)
rm(list=ls())

#Load rasters
r1 <- raster('/home/pedro/hd1/dados_GPP/infra/conectividade/celular_3g_v20210922_500-RECLASS.tif')
#Create an alligned output which will be overwrited
output <- raster(r1)
#Create blocks
bss <- blockSize(output)
#Function for table management
fun_ex <- function(i, j){
  #Get table
  db <- data.frame(
    ras1 = getValues(r1, row = bss$row[i], nrows = bss$nrows[i]),
    out = NA)
  
  #operations
  x <- db$ras1+10+j
  db$out <- x
  
  return(db$out)
  
}
#Function for exporting results
exporta <- function(x){
  
  out <- raster(output)
  #cl <- raster::beginCluster()
  # set flag that cluster is available again
  #on.exit(returnCluster())
  nodes <- length(cl)
  j <- 100
  #Put the functions in the nodes
  for(i in 1:nodes){
    snow::sendCall(cl[[i]], fun_ex, args = list(i, j), tag = i)
  }
  
  #Start writing
  out <- writeStart(out,
                    filename = '/home/pedro/hd1/pedro/GPP/TEEB/scripts/teste/out1.tif',
                    #datatype = 'INT2U',
                    format='raster',
                    overwrite = TRUE
                    
  )
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
    out <- writeValues(out, d$value$value, bss$row[b])
    rm(d)
    print(Sys.time()-ini)
  }
  
  #Write and export
  out <- writeStop(out)
  return(NULL)
  
  
}
r1 <- list(r1)


#F.D.A
fda <- function(i, t) {
  
  x <- getValues(r1[[t]], row = bss$row[i], nrows = bss$nrows[i])
  z <- x+10
  n_tot <- TRUE
  return(list(z, n_tot))
  
  
}

agrega <- function(dt, z, n_tot ) {
  
  if(dt & n_tot) {
    
    return('success')
    
  }
  
  
}

atualiza <- function(dt, t) {
  
  nodes <- length(cl)
  
  #Put the functions in the nodes
  for(i in 1:nodes){
    snow::sendCall(cl[[i]], fda, list(i, t), tag = i)
  }
  
  
  #Spread the blocks over the processes
  for (i in 1:bss$n) {
 i <- 1
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
      sendCall(cl[[d$node]], fda, list(ni, t), tag = ni)
    }
    # which block is this?
    b <- d$value$tag
    print(paste0('recebido bloco: ', b)) ; 
    flush.console()
    
    df <<- agrega(dt, d$value$value[[1]], d$value$value[[2]])
    
    
    print(Sys.time()-ini)
  }
  
  #Write and export
  

  
  
  
}









#Cluster start
cl <- snow::makeSOCKcluster(7)
registerDoMPI(cl)
# options(rasterClusterObject = cl)
options(rasterClusterCores = length(cl))
options(rasterCluster = TRUE)
options(rasterClusterExclude = NULL)
#Load libraries
snow::clusterEvalQ(cl, library(raster))
snow::clusterExport(cl=cl,
                    ls())

atualiza(dt, 1)

#Run
ini <- Sys.time()
output <- exporta(output)
Sys.time()-ini
system('gdal_translate -of GTiff /home/pedro/hd1/pedro/GPP/TEEB/scripts/teste/out1.grd /home/pedro/hd1/pedro/GPP/TEEB/scripts/teste/out.tif')
snow::stopCluster(cl)
























