if(!require("tidyverse")) install.packages("tidyverse")
if(!require("readr")) install.packages("readr")
if(!require("readxl")) install.packages("readxl")

library(tidyverse)
library(readr)
library(readxl)

#problema 1
setwd("./data")
files <- list.files(path = '.', pattern ="*.xlsx", full.names = FALSE)

table <- sapply(files, read_excel, simplify=FALSE) %>%
  bind_rows(.id = "DATE")

table$DATE <- gsub('.xlsx','',table$DATE)


#problema 2
#utility function for sampling
list_sample <- function(x){
  return(sample(1:30 ,size = 100, replace = TRUE))
}

#function to get the mode of a vector
mode <- function(x){
  uniqx <- unique(x)
  uniqx[which.max(tabulate(match(x,uniqx)))]
}


lista <- list(a = list_sample(), b = list_sample(), c = list_sample())
modes <- lapply(lista, mode)


#problema 3
setwd("./data")

parque_vihicular <- read_delim("INE_PARQUE_VEHICULAR_080219.txt", delim = '|')
str(parque_vihicular)

