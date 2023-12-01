## Rafael Sanchez 202123676 - Maria Jose Medellin 202122960 - Juan Camilo Bejarano 202121927
## R version 4.3.1 (2023-06-16 ucrt)
## Problem Set 3 


### Configuracion inicial
## Set Up inicial
rm(list=ls())

##Cargar los paquetes y librerIas necesarias
require(pacman)
p_load(tidyverse,rio,data.table, ggplot2, tinytex)


#PUNTO 1

# 1.1
##Obtener la lista de archivos en input
rutas <- list.files("input" , recursive=T , full.names=T)

# 1.2
## Extraer las rutas
rutas_resto <- str_subset(string = rutas , pattern = "Resto - Ca")

## Cargar en lista
lista_resto <- import_list(file = rutas_resto)

## Textear la cadena de caracteres(prueba)
rutas_resto[35]
str_sub(rutas_resto[35],start = 7 , 10)

## Agregar ruta
lista_resto[[1]]$path <- rutas_resto[1]

## Aplicar loop  
for (i in 1:length(lista_resto)){
  lista_resto[[i]]$path <- rutas_resto[i]  
  lista_resto[[i]]$year <- str_sub(lista_resto[[i]]$path,start = 7 , 10)
}

# 1.3
##Eliminar el elemento numero 36 de la lista
lista_resto[[36]] <- NULL

# Combinar la lista en un solo data frame
df_resto <- rbindlist(l=lista_resto , use.names=T , fill=T)


# PUNTO 2

# Grafica 1
##Importar archivo
db=import ("input/2019/Agosto.csv/Cabecera - Características generales (Personas).csv")

##Crear grafico de dispersion con tema, titulo y nombre en los ejes
db %>%
  ggplot(aes(x = P6040, y = ESC, color = factor(P6020))) +  # Usamos color para diferenciar por género
  geom_point() +  
  labs(title = "Años cumplidos y años de educación, diferenciado por género",
       x = "Años cumplidos",
       y = "Años de educación",
       color = "Género") +  # Etiqueta para la leyenda de color
  scale_color_manual(values = c("aquamarine", "darkorchid1"), labels = c("Hombre", "Mujer")) +
  theme_minimal()

# Grafica 2
##Importar archivo
db=import ("input/2019/Agosto.csv/Cabecera - Características generales (Personas).csv")

##Crear grafico de dispersion con tema, titulo y nombre en los ejes
db %>%
  ggplot(aes(x = factor(P6020), fill = factor(P6160))) +  # Usamos fill para diferenciar por saber/no saber leer y escribir
  geom_bar(position = "dodge") +
  labs(title = "Personas que saben o no leer y escribir, diferenciado por género",
       x = "Género",
       y = "Cantidad",
       fill = "Sabe Leer y Escribir") +  
  scale_x_discrete(labels = c("Hombre", "Mujer")) +  
  scale_fill_manual(values = c("darkolivegreen1", "darkred"), labels = c("Sabe", "No Sabe")) +  
  theme_minimal()