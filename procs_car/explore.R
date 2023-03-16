rm(list=ls())
options(scipen = 999)
options(stringsAsFactors = F)
# installing packages
library(pacman)
p_load( raster, rgdal, prop,   dplyr, ggplot2,RPostgreSQL, tidyr, ggrepel, tidyverse, forcats)
install.packages('BiocManager')

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
start <- Sys.time()

dt <- dbGetQuery(connec , "SELECT tipo_irregularidade, count(*), sum(ST_area(geom::geography))/10000 area FROM 
                 irregularidades.proc7_step14_categorizacao a WHERE am_legal GROUP BY tipo_irregularidade UNION ALL SELECT 'CAR' tipo_irregularidade, 0 count, sum(ST_area(geom::geography))/10000 area  FROM car.proc2_array_agg b WHERE am_legal")

myPalette <- c('A' = "#51ffd2", 
               'B' = "#4de536", 
               'C' = '#ffff20', 
               "D" = '#ff07ff', 
               "E" = '#a812ee', 
               "F" = '#ff6f0f',
               "G" = '#e31a1c', 
               "OSII" = '#1f78b4')



###########  
###########
###########
###########
###########
# OCII vs OSII
###########
###########
###########
###########
########### 
dt2 <- dt[1:8,] %>%
  pivot_longer(cols = c('count', 'area')) %>%
  as_tibble() %>%
  mutate(tipo = ifelse(tipo_irregularidade == 'OSII','OSII','OCII'),
         value = ifelse(name == 'count',value/1000,value/1000000)) %>%
  group_by(tipo, name) %>%
  summarise(total =sum(value)) %>%
  group_by(name) %>%
  mutate(t = sum(total),
         pt = total/t)


p1 <- ggplot(data = dt2 , aes(x='', y=pt, fill=tipo)) +
  geom_bar(stat="identity", width=1, color="white") +
    geom_text(aes(label = paste0(round(total, 0), ' (', round(pt*100), '%)')),
              position = position_stack(vjust = 0.5)) +
  coord_polar("y", clip = 'off') +
  ylab('')+xlab('')+
  facet_wrap(~name, labeller = as_labeller(c('count' = 'Número (mil ocupações)', 'area'= 'Área (Mha)')))+
    scale_fill_manual('Tipo de ocupação', values = c("OCII" = 'grey', "OSII" = '#1f78b4') )+
  theme_bw() ; p1
    
  ggsave(filename = '../../imagens/oii/pizza_ocii_osii.png', plot = p1, units = 'in', dpi = 300, scale = 1.5)
  
  
  
  
  
###########  
  ###########
  ###########
  ###########
  ###########
  #APENAS OCII
  ###########
  ###########
  ###########
  ###########
###########  
  dt3 <- dt[1:8,] %>%
    filter(tipo_irregularidade != 'OSII') %>%
    pivot_longer(cols = c('count', 'area')) %>%
    as_tibble() %>%
    mutate(tipo = tipo_irregularidade,
           value = ifelse(name == 'count',value/1000,value/1000000)) %>%
    group_by(tipo, name) %>%
    summarise(total =sum(value)) %>%
    group_by(name) %>%
    mutate(t = sum(total),
           pt = total/t)

#CRIAR A COLINA POS, importante
dt3 <- dt3 %>% 
  group_by(name) %>%
    mutate(csum = rev(cumsum(rev(pt))), 
           pos = pt/2 + lead(csum, 1),
           pos = if_else(is.na(pos), pt/2, pos))


p2 <- ggplot(dt3, aes(x = "" , y = pt, fill = fct_inorder(tipo))) +
    geom_col(width = 1, color = 'white') +
    coord_polar(theta = "y") +
    scale_fill_manual('Tipo de ocupação', values = myPalette) +
    geom_label_repel(data = dt3,
                     aes(y = pos, label = paste0(round(pt*100,2), "%")),
                     size = 4.5, nudge_x = 1, show.legend = FALSE) +
    guides(fill = guide_legend(title = "Group")) +
  ylab('')+xlab('')+
    facet_wrap(~name, labeller = as_labeller(c('count' = 'Número (mil ocupações)', 'area'= 'Área (Mha)')))+
    theme_bw()
  
  ggsave(filename = '../../imagens/oii/pizza_ocii_todas.png', plot = p2, units = 'in', dpi = 300, scale = 1.5)
  
  
  