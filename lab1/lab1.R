if(!require("tidyverse")) install.packages("tidyverse")
if(!require("readr")) install.packages("readr")
if(!require("readxl")) install.packages("readxl")

library(tidyverse)
library(readr)
library(readxl)



excel <- read_excel('./data/01-2018.xlsx')
str(excel)

excel2 <- read_excel('./data/02-2018.xlsx')
str(excel2)



files <- list.files(path = '.', pattern ="*.xlsx", full.names = FALSE)

table <- sapply(files, read_excel, simplify=FALSE) %>%
  bind_rows(.id = "id")


