#####################################################
# Spatial allocation of projected areas - Step 2:
# Allocating the transitions 
# Project: TEEB - Agrifood
# Pietro Gragnolati Fernandes
#####################################################


# Cleaning the environment
rm(list=ls())

# installing packages
library(pacman)
p_load(data.table, raster, rgdal, sf, fasterize, dplyr,exactextractr, doMPI, snow, raster)
source('/home/pedro/hd1/pedro/GPP/TEEB/scripts/funcoes.R')
# Reading files
setwd("D:/arquivos/GPP/TEEB_Agrifood/GIS")
use <- raster("D:/arquivos/GPP/TEEB_Agrifood/GIS/use_reclassified_collection_7.0_reextended.tif") #LULC raster of the initial year
difAP <- raster("dif_AP_masked.tif") #raster with prob differences for the transition
difAF <- raster("dif_AF_masked.tif") #raster with prob differences for the transition
difFP <- raster("dif_FP_masked.tif") #raster with prob differences for the transition
difFA <- raster("dif_FA_masked.tif") #raster with prob differences for the transition
difPF <- raster("dif_PF_masked.tif") #raster with prob differences for the transition
difPA <- raster("dif_PA_masked.tif") #raster with prob differences for the transition
dif <- stack(difFP, difFA, difAP,difAF,difPF,difPA)
state <- raster("clip_pa_br_limiteEstadual_30m_2015_ibge_reextended.tif")

#UF codes
#AM <- 13
#AC <- 12
#RO <- 11
#MT <- 51
#TO <- 17
#MA <- 21
#PARA <- 15
#AMP <- 16
#RR <- 14

ufs <- c(11,12,13,14,15,16,17,21,51)


# Creating a block with the optimum number of iterations 
bss <- blockSize(use)
bss
# Loop params
uses <- rep(seq(1,4),each = 200,9)
lim1 <- rep(seq(-10000,9900, 100),36)
lim2 <- rep(seq(-9900, 10000, 100),36)
values <- seq(-10000, 10000, 1)
breaks <- rep(seq(1,200),each = 100)
breaks[20001] <- 200
unit_breaks <- cbind(values, breaks)
colnames(unit_breaks) <- c("dif","breaks")
cd_uf <- rep(ufs,each = 800)
breaks <- data.frame(cd_uf,lim1,lim2)
breaks$breaks <- rep(seq(1,200),36)
dt <- cbind(breaks, uses)
dt$count <- 0 
dt$count_tot <- 0
dt_final <- dt
dt_final$perc <- 0
dt_final$perc_acum <- 0
dt_final$transition <- 0


#transitions
#FP - 1
#FA - 2
#AP - 3
#AF - 4
#PF - 5
#PA - 6

u_initial <- c(1,1,2,2,3,3) #(F,F,A,A,P,P)
u_final <- c(3,2,3,1,1,2) #(P,A,P,F,F,A)

#transition rates
transitions <- paste(u_initial,u_final)
t_rates <- data.frame(rep(ufs, each = 6), rep(transitions, times = 9))
colnames(t_rates) <- c("cd_uf","transition")
t_rates$rates <- c(0.060,0.001,0.072,0.005,0.028,0.014,0.021,0.000,0.755,0.001,0.059,0.001,0.006,0.000,0.376,0.01,0.078,0.0004,
                   0.016,0.000,0.277,0.004,0.026,0.010,0.031,0.001,0.116,0.024,0.076,0.015,0.005,0.000,0.039,0.013,0.031,0.007,
                   0.046,0.007,0.037,0.008,0.062,0.034,0.048,0.007,0.033,0.024,0.100,0.019,0.036,0.002,0.031,0.002,0.041,0.046)


uso_out <- use 
remaining <- use
use <- stack(use,use, use, use, use, use)

 for (t in 1:6) {
  #Extracting fda table
  u <- u_initial[t]
  u_fin <- u_final[t]
  dt <- cbind(breaks, uses)
  dt$count <- 0 
  dt$count_tot <- 0
  
  #Atualiza DT com nova fda
  atualiza_dt(dt, t, u)
  
  
  dt <- subset(dt, uses ==u)
  dt <- arrange(dt, cd_uf, breaks)
  dt$perc <- dt$count/dt$count_tot
  dt$perc_acum <- ave(dt$perc, dt$cd_uf, FUN = cumsum)
  
  dt$transition <- paste(u,u_fin)
  dt_final <- rbind(dt_final,dt)
  
  
  
 
  for (s in ufs) {
    # Setting thresholds
    dt <- subset(dt_final, cd_uf == s & transition == paste(u,u_fin))
    x <- subset(t_rates, cd_uf == s & transition == paste(u,u_fin)) #set the the transition
    x <- x[,3]
    r <- length(which(dt$perc_acum <= x)) 
    r <- ifelse(r ==0, 1, r)
    lims <- dt[c(1:(r+1)),]
    n <- nrow(lims)
    thresh <- 100*(x- lims$perc_acum[n-1])/lims$perc[n]
    thresh <- lims$lim2[n-1] + thresh
    
    use <- readStart(use)
    dif <- readStart(dif)
    uso_out <- writeStart(uso_out, filename = sprintf("D:/arquivos/GPP/TEEB_Agrifood/GIS/transition_%g_2025_%g.tif", t,s)) #set the transition name
    remaining <- writeStart(remaining, filename = sprintf("D:/arquivos/GPP/TEEB_Agrifood/GIS/remaining_%g_2025_%g.tif",t,s)) #set the use converted in the transition
    
    print(s)
    

    
    use <- readStop(use)
    dif <- readStop(dif)
    uso_out <- writeStop(uso_out)
    remaining <- writeStop(remaining)
  }
  r11 <- raster(sprintf("D:/arquivos/GPP/TEEB_Agrifood/GIS/transition_%g_2025_11.tif",t))
  r12 <- raster(sprintf("D:/arquivos/GPP/TEEB_Agrifood/GIS/transition_%g_2025_12.tif",t))
  r13 <- raster(sprintf("D:/arquivos/GPP/TEEB_Agrifood/GIS/transition_%g_2025_13.tif",t))
  r14 <- raster(sprintf("D:/arquivos/GPP/TEEB_Agrifood/GIS/transition_%g_2025_14.tif",t))
  r15 <- raster(sprintf("D:/arquivos/GPP/TEEB_Agrifood/GIS/transition_%g_2025_15.tif",t))
  r16 <- raster(sprintf("D:/arquivos/GPP/TEEB_Agrifood/GIS/transition_%g_2025_16.tif",t))
  r17 <- raster(sprintf("D:/arquivos/GPP/TEEB_Agrifood/GIS/transition_%g_2025_17.tif",t))
  r21 <- raster(sprintf("D:/arquivos/GPP/TEEB_Agrifood/GIS/transition_%g_2025_21.tif",t))
  r51 <- raster(sprintf("D:/arquivos/GPP/TEEB_Agrifood/GIS/transition_%g_2025_51.tif",t))
  remaining <- raster::mosaic(r11,r12,r13,r14,r15,r16,r17,r21,r51, fun=mean, filename = sprintf("D:/arquivos/GPP/TEEB_Agrifood/GIS/remaining_%g.tif",t))
  use <- stack(use[[1]],remaining, use[[1]], remaining, use[[1]], remaining)

 }

