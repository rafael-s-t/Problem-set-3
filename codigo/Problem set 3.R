rm(list=ls())
require(pacman)
p_load(tidyverse,rio,data.table,stringr)


rutas=list.files("Problem-set-3/input/", recursive = T, full.names=T)


rutas_resto=str_subset(string=rutas, pattern="Resto-Ca")
lista_resto = import_list(file=rutas_resto)