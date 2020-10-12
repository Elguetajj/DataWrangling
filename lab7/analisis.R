if(!require("tidyverse")) install.packages("tidyverse")
if(!require("readr")) install.packages("readr")


data <- read_csv(file = "c1.csv")[,1:22]




data<- data %>% 
  rename_at(names(data),
            .funs = tolower)

data <- data %>%
  mutate_all(funs(str_replace(., "Q", "")))

# data <- data.frame(lapply(data, function(x) {gsub("Q", "", x)}))

data <- data %>% 
  transform(lat = as.numeric(lat),
            long = as.numeric(long),
            camion_5 = as.numeric(camion_5),
            pickup = as.numeric(pickup),
            moto = as.numeric(moto),
            directocamion_5 = as.numeric(directocamion_5),
            directopickup = as.numeric(directopickup),
            directomoto = as.numeric(directomoto),
            fijocamion_5 = as.numeric(fijocamion_5),
            fijopickup = as.numeric(fijopickup),
            fijomoto = as.numeric(fijomoto))

data <- data %>% 
  pivot_longer(c(camion_5, pickup, moto), names_to = "tipo", values_to = "costo_total", values_drop_na = T) %>% 
  pivot_longer(cols = contains("directo"), names_to = "tipo_directo" ,values_to = "costo_directo", values_drop_na = T)%>% 
  pivot_longer(cols = contains("fijo"),names_to = "tipo_fijo", values_to = "costo_fijo", values_drop_na = T)
  
data <- data %>% 
  subset(select = -c(tipo_directo,tipo_fijo))

                 