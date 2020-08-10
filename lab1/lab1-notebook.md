R Notebook
================

# Laboratorio \#1

## Problema \#1

### Escenario:

Ha sido contratado para trabajar en una consultoría a una embotelladora
nacional. La embotelladora se encarga de distribuir su producto a
distintos clientes, utilizando diferentes equipos de transporte y
pilotos. Se le ha enviado un set de archivos de las entregas del año
2018.

### Se Requiere:

  - Unificar todos los archivos en una tabla única.
  - Agregar una columna adicional que identifique al mes y año de ese
    archivo, por ejemplo: Fecha: 01-2018.
  - Exportar ese archivo en formato csv o Excel.
  - Adjuntar el link de su Git Rmarkdown de R con lo que realizó lo
    anterior.
  - Adjuntar archivo csv o Excel unificado que genera el archivo de R.

### Nota:

  - Las variables que el archivo necesita tener son: COD\_VIAJE,
    CLIENTE, UBICACIÓN, CANTIDAD, PILOTO, Q, CREDITO, UNIDAD, Fecha

### Solución:

``` r
setwd("./data")

files <- list.files(path = '.', pattern ="*.xlsx", full.names = FALSE)

table <- sapply(files, read_excel, simplify=FALSE) %>%
  bind_rows(.id = "DATE")
```

    ## New names:
    ## * `` -> ...10

``` r
table$DATE <- gsub('.xlsx','',table$DATE)
```

``` r
table
```

    ## # A tibble: 2,180 x 11
    ##    DATE  COD_VIAJE CLIENTE UBICACION CANTIDAD PILOTO     Q CREDITO UNIDAD  TIPO
    ##    <chr>     <dbl> <chr>       <dbl>    <dbl> <chr>  <dbl>   <dbl> <chr>  <dbl>
    ##  1 01-2~  10000001 EL PIN~     76002     1200 Ferna~ 300        30 Camio~    NA
    ##  2 01-2~  10000002 TAQUER~     76002     1433 Hecto~ 358.       90 Camio~    NA
    ##  3 01-2~  10000003 TIENDA~     76002     1857 Pedro~ 464.       60 Camio~    NA
    ##  4 01-2~  10000004 TAQUER~     76002      339 Angel~  84.8      30 Panel     NA
    ##  5 01-2~  10000005 CHICHA~     76001     1644 Juan ~ 411        30 Camio~    NA
    ##  6 01-2~  10000006 UBIQUO~     76001     1827 Luis ~ 457.       30 Camio~    NA
    ##  7 01-2~  10000007 CHICHA~     76002     1947 Ismae~ 487.       90 Camio~    NA
    ##  8 01-2~  10000008 TAQUER~     76001     1716 Juan ~ 429        60 Camio~    NA
    ##  9 01-2~  10000009 EL GAL~     76002     1601 Ismae~ 400.       30 Camio~    NA
    ## 10 01-2~  10000010 CHICHA~     76002     1343 Ferna~ 336.       90 Camio~    NA
    ## # ... with 2,170 more rows, and 1 more variable: ...10 <dbl>

## Problema 2

Utilizando la función lapply, encuentre la moda de cada vector de una
lista de por lo menos 3 vectores.

### Solución:

``` r
#utility function for sampling
list_sample <- function(x){
  return(sample(1:30 ,size = 100, replace = TRUE))
}

#function to get the mode of a vector
mode <- function(x){
  uniqx <- unique(x)
  uniqx[which.max(tabulate(match(x,uniqx)))]
}
```

``` r
lista <- list(a = list_sample(), b = list_sample(), c = list_sample())
modes <- lapply(lista, mode)

lista
```

    ## $a
    ##   [1] 30 11 29  3 11  7  6  3 27  5 29 27 16 22  6 18 21 21 15 15  8 25 22  2 19
    ##  [26]  7 11 12  6  6 27  9 13 23 26 25 25  5 19 27 15 23 14 28 14 10  8 24  3 21
    ##  [51] 22  3 21 14 11 23 13  7 19  9 26 22 20  2  8  8  4 11 23 13 29 11  7 30 16
    ##  [76]  5  1  5 11 13 14 22 27 28 17 19 16 15 17 15 23  5 14  9 17  2  8 10 23 23
    ## 
    ## $b
    ##   [1] 21  5 18  8  8  4 12 29 14 26 11 12 18 24 25 24 18  3 21  9 15 16 30 24 24
    ##  [26] 23 25  6  9 17 21 20 16 17 20  2 29 11 14  6 27  2  8 29 15 30 18 28 26 10
    ##  [51]  2 22 20 29  5 19 20  6 30 16 18  8 16  8  9  9 17  2 23 19  6 10  7  3  3
    ##  [76] 29  7  6 15 16 13 20 11  8  2 17 12 16 21  5 30 28 29 29 20 19  2 14 26  1
    ## 
    ## $c
    ##   [1] 17  6  5  4  9 26 17 20  9 18  2 10 28 18 18 27 30 23  9 20  3 11 14 11  7
    ##  [26] 25 21 16  9 14  2  8 30  9  6 28  2 12 10 26 29 14 24 13 14 23 29 19  1 28
    ##  [51] 27 12 23  2 16  4  7 26 20  4  7  1 22 13 30  6 30 30 27 18 16  5 30 27 26
    ##  [76]  4  9 28 13  9  2  9 19 18  2 27 16 20 29 11 29 15 27 11 30 22  3 14  8  2

``` r
modes
```

    ## $a
    ## [1] 11
    ## 
    ## $b
    ## [1] 29
    ## 
    ## $c
    ## [1] 9

## Problema 3

  - Descargue de la página web de la SAT el aechivo de Parque Vehicular
    de Enero 2019.
  - Leer el archivo en R. (Nota: usar read\_delim() del paquete readr)

### Solución:

``` r
setwd("./data")

parque_vihicular <- read_delim("INE_PARQUE_VEHICULAR_080219.txt", delim = '|')
```

    ## Warning: Missing column names filled in: 'X11' [11]

    ## Parsed with column specification:
    ## cols(
    ##   ANIO_ALZA = col_double(),
    ##   MES = col_character(),
    ##   NOMBRE_DEPARTAMENTO = col_character(),
    ##   NOMBRE_MUNICIPIO = col_character(),
    ##   MODELO_VEHICULO = col_character(),
    ##   LINEA_VEHICULO = col_character(),
    ##   TIPO_VEHICULO = col_character(),
    ##   USO_VEHICULO = col_character(),
    ##   MARCA_VEHICULO = col_character(),
    ##   CANTIDAD = col_double(),
    ##   X11 = col_character()
    ## )

    ## Warning: 2362740 parsing failures.
    ## row col   expected     actual                              file
    ##   1  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080219.txt'
    ##   2  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080219.txt'
    ##   3  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080219.txt'
    ##   4  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080219.txt'
    ##   5  -- 11 columns 10 columns 'INE_PARQUE_VEHICULAR_080219.txt'
    ## ... ... .......... .......... .................................
    ## See problems(...) for more details.

``` r
str(parque_vihicular)
```

    ## tibble [2,362,732 x 11] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
    ##  $ ANIO_ALZA          : num [1:2362732] 2007 2007 2007 2007 2007 ...
    ##  $ MES                : chr [1:2362732] "05" "05" "05" "05" ...
    ##  $ NOMBRE_DEPARTAMENTO: chr [1:2362732] "HUEHUETENANGO" "EL PROGRESO" "SAN MARCOS" "ESCUINTLA" ...
    ##  $ NOMBRE_MUNICIPIO   : chr [1:2362732] "HUEHUETENANGO" "EL JICARO" "OCOS" "SAN JOS<c9>" ...
    ##  $ MODELO_VEHICULO    : chr [1:2362732] "2007" "2007" "2007" "2006" ...
    ##  $ LINEA_VEHICULO     : chr [1:2362732] "SPORT125" "BT-50 DBL CAB 4X2 TURBO" "JL125" "JL125T-15" ...
    ##  $ TIPO_VEHICULO      : chr [1:2362732] "MOTO" "PICK UP" "MOTO" "MOTO" ...
    ##  $ USO_VEHICULO       : chr [1:2362732] "MOTOCICLETA" "PARTICULAR" "MOTOCICLETA" "MOTOCICLETA" ...
    ##  $ MARCA_VEHICULO     : chr [1:2362732] "ASIA HERO" "MAZDA" "KINLON" "JIALING" ...
    ##  $ CANTIDAD           : num [1:2362732] 1 1 1 1 1 1 1 4 11 15 ...
    ##  $ X11                : chr [1:2362732] NA NA NA NA ...
    ##  - attr(*, "problems")= tibble [2,362,740 x 5] (S3: tbl_df/tbl/data.frame)
    ##   ..$ row     : int [1:2362740] 1 2 3 4 5 6 7 8 9 10 ...
    ##   ..$ col     : chr [1:2362740] NA NA NA NA ...
    ##   ..$ expected: chr [1:2362740] "11 columns" "11 columns" "11 columns" "11 columns" ...
    ##   ..$ actual  : chr [1:2362740] "10 columns" "10 columns" "10 columns" "10 columns" ...
    ##   ..$ file    : chr [1:2362740] "'INE_PARQUE_VEHICULAR_080219.txt'" "'INE_PARQUE_VEHICULAR_080219.txt'" "'INE_PARQUE_VEHICULAR_080219.txt'" "'INE_PARQUE_VEHICULAR_080219.txt'" ...
    ##  - attr(*, "spec")=
    ##   .. cols(
    ##   ..   ANIO_ALZA = col_double(),
    ##   ..   MES = col_character(),
    ##   ..   NOMBRE_DEPARTAMENTO = col_character(),
    ##   ..   NOMBRE_MUNICIPIO = col_character(),
    ##   ..   MODELO_VEHICULO = col_character(),
    ##   ..   LINEA_VEHICULO = col_character(),
    ##   ..   TIPO_VEHICULO = col_character(),
    ##   ..   USO_VEHICULO = col_character(),
    ##   ..   MARCA_VEHICULO = col_character(),
    ##   ..   CANTIDAD = col_double(),
    ##   ..   X11 = col_character()
    ##   .. )
