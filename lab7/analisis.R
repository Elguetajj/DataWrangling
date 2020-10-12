if(!require("tidyverse")) install.packages("tidyverse")
if(!require("readr")) install.packages("readr")


#importa dataset
csv <- read_csv(file = "c1.csv")[,1:22]


#limpieza
data <- csv %>% 
  pivot_longer(cols = c(`5-30`,`30-45`,`45-75`,`75-120`,`120+`) , names_to = "rango", values_to = "equis", values_drop_na = T)

data<- data %>% 
  rename_at(names(data),
            .funs = tolower)

data <- data %>%
  mutate_all(funs(str_replace(., "Q", "")))

data <- data %>% 
  transform(lat = as.numeric(lat),
            long = as.numeric(long),
            factura = as.numeric(factura),
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
  subset(select = -c(tipo_directo, tipo_fijo, equis))


#analisis

#estado de resultados
costos <- sum(data$costo_total)
revenue <- sum(data$factura)
profit <- (revenue - costos)

#costo por unidad 
detalle <- data %>% 
  group_by(cod) %>% 
  summarize(
    count = n(),
    factura_promedio = mean(factura),
    costo_promedio = mean(costo_total),
    costo_fijo_promedio = mean(costo_fijo),
    costo_directo_promedio = mean(costo_directo),
    margen_promedio = mean(factura-costo_total),
    porcentaje_revenue = sum(factura)/revenue,
    porcentaje_profits = sum(factura-costo_total)/profit
  )

#costo por unidad simple
costo_unitario <- mean(data$costo_total)

#tarifas aceptables?

tarifas <- as.data.frame(table(data$rango))
names(tarifas)[names(tarifas) == "Var1"] <- "dias_de_credito"
tarifas$ratio <- tarifas$Freq/sum(tarifas$Freq)
tarifas <- tarifas[order(-tarifas$ratio),]




# mas centros?
centros <- data %>% 
  group_by(origen) %>% 
  summarise(n = length(unique(id)),
            profit = (sum(factura)-sum(costo_total))/revenue,
            costos = sum(costo_total),
            ventas = sum(factura)
            )

# postes
postes <- data %>% 
  group_by(id,lat,long,height) %>% 
  summarise(n = n())

postes <- postes[order(-postes$n),]














                 