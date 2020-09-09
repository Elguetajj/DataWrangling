dw-2020-parcial-1
================
Tepi
9/3/2020

# Examen parcial

Indicaciones generales:

  - Usted tiene el período de la clase para resolver el examen parcial.

  - La entrega del parcial, al igual que las tareas, es por medio de su
    cuenta de github, pegando el link en el portal de MiU.

  - Pueden hacer uso del material del curso e internet (stackoverflow,
    etc.). Sin embargo, si encontramos algún indicio de copia, se
    anulará el exámen para los estudiantes involucrados. Por lo tanto,
    aconsejamos no compartir las agregaciones que generen.

## Sección I: Preguntas teóricas.

  - Existen 10 preguntas directas en este Rmarkdown, de las cuales usted
    deberá responder 5. Las 5 a responder estarán determinadas por un
    muestreo aleatorio basado en su número de carné.

  - Ingrese su número de carné en `set.seed()` y corra el chunk de R
    para determinar cuáles preguntas debe responder.

<!-- end list -->

``` r
set.seed(20180396) 
v<- 1:10
preguntas <-sort(sample(v, size = 6, replace = FALSE ))

paste0("Mis preguntas a resolver son: ",paste0(preguntas,collapse = ", "))
```

    ## [1] "Mis preguntas a resolver son: 1, 3, 5, 7, 8, 10"

### Listado de preguntas teóricas

1.  Para las siguientes sentencias de `base R`, liste su contraparte de
    `dplyr`:
    
      - `str()`
      - `df[,c("a","b")]`
      - `names(df)[4] <- "new_name"` donde la posición 4 corresponde a
        la variable `old_name`
      - `df[df$variable == "valor",]`

2.  Al momento de filtrar en SQL, ¿cuál keyword cumple las mismas
    funciones que el keyword `OR` para filtrar uno o más elementos una
    misma columna?

3.  ¿Por qué en R utilizamos funciones de la familia apply
    (lapply,vapply) en lugar de utilizar ciclos?

4.  ¿Cuál es la diferencia entre utilizar `==` y `=` en R?

5.  ¿Cuál es la forma correcta de cargar un archivo de texto donde el
    delimitador es `:`?

6.  ¿Qué es un vector y en qué se diferencia en una lista en R?

7.  ¿Qué pasa si quiero agregar una nueva categoría a un factor que no
    se encuentra en los niveles existentes?

8.  Si en un dataframe, a una variable de tipo `factor` le agrego un
    nuevo elemento que *no se encuentra en los niveles existentes*,
    ¿cuál sería el resultado esperado y por qué?
    
      - El nuevo elemento
      - `NA`

9.  En SQL, ¿para qué utilizamos el keyword `HAVING`?

10. Si quiero obtener como resultado las filas de la tabla A que no se
    encuentran en la tabla B, ¿cómo debería de completar la siguiente
    sentencia de SQL?
    
      - SELECT \* FROM A \_\_\_\_\_\_\_ B ON A.KEY = B.KEY WHERE
        \_\_\_\_\_\_\_\_\_\_ = \_\_\_\_\_\_\_\_\_\_

Extra: ¿Cuántos posibles exámenes de 5 preguntas se pueden realizar
utilizando como banco las diez acá presentadas? (responder con código de
R.)

## Sección II Preguntas prácticas.

  - Conteste las siguientes preguntas utilizando sus conocimientos de R.
    Adjunte el código que utilizó para llegar a sus conclusiones en un
    chunk del markdown.

A. De los clientes que están en más de un país,¿cuál cree que es el más
rentable y por qué?

B. Estrategia de negocio ha decidido que ya no operará en aquellos
territorios cuyas pérdidas sean “considerables”. Bajo su criterio,
¿cuáles son estos territorios y por qué ya no debemos operar ahí?

### I. Preguntas teóricas

1.  Contrapartes en dplyr:
      - `str()` == `glimpse()`
      - `df[,c("a","b")]` == `select(df,a,b)`
      - `names(df)[4] <- "new_name"` donde la posición 4 corresponde a
        la variable `old_name` == `rename(df, old_name = "new_name")`
      - `df[df$variable == "valor",]` == `filter(df, variable ==
        "valor")`
2.  Utilizamos las funciones de la familia apply para aprovechar las
    funcionalidades vectoriales de r y de esta manera poder transformar,
    manipular y analizar la data de forma eficiente.
3.  `readr::read_delim("file_path", ":")`
4.  No se puede. Tiene que agregar la categoria al factor. 8,
5.  SELECT \* FROM A RIGHT JOIN B ON A.KEY = B.KEY WHERE A.key = NULL

extra:

``` r
choose(10, 5)
```

    ## [1] 252

``` r
if(!require("tidyverse")) install.packages("tidyverse")
```

    ## Loading required package: tidyverse

    ## -- Attaching packages ----------------------------------------------------------------------------------------------------------------------------------------------------- tidyverse 1.3.0 --

    ## v ggplot2 3.3.2     v purrr   0.3.4
    ## v tibble  3.0.3     v dplyr   1.0.1
    ## v tidyr   1.1.0     v stringr 1.4.0
    ## v readr   1.3.1     v forcats 0.5.0

    ## -- Conflicts -------------------------------------------------------------------------------------------------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(tidyverse)

parcial_anonimo <- readRDS("./parcial_anonimo.rds")
```

## A

``` r
###resuelva acá

x <- parcial_anonimo %>% 
  filter(Venta>0) %>% 
  group_by(Cliente,Pais) %>%
  summarise(EficienciaPromedio = mean(Venta/`Unidades plaza`, na.rm=TRUE) )
```

    ## `summarise()` regrouping output by 'Cliente' (override with `.groups` argument)

``` r
x
```

    ## # A tibble: 2,128 x 3
    ## # Groups:   Cliente [2,122]
    ##    Cliente  Pais     EficienciaPromedio
    ##    <chr>    <chr>                 <dbl>
    ##  1 0007d709 4f03bd9b              10.5 
    ##  2 005f334f 4046ee34              10.7 
    ##  3 00a3a1af 4046ee34               6.60
    ##  4 00f1f944 4f03bd9b               6.31
    ##  5 011806a5 4046ee34              14.7 
    ##  6 0198eb9e 4046ee34               6.82
    ##  7 01b8f89c 4f03bd9b               3.97
    ##  8 01cd5a7f 4f03bd9b              19.6 
    ##  9 01cfc368 4f03bd9b               4.54
    ## 10 01e81b4a 4f03bd9b               5.05
    ## # ... with 2,118 more rows

## B

Para elegir a los territorios en los que se cancelaran operaciones,
decidimos sacar el promedio de perdidas dentro de todos aquellos que
tienen perdidas, y todos los que esten arriba del promedio seran los que
consideramos como con perdidas “considerables”

``` r
###resuelva acá

y <- parcial_anonimo %>% 
  filter(Venta<0) %>% 
   arrange(desc(Venta))

media <- mean(x$Venta)
```

    ## Warning: Unknown or uninitialised column: `Venta`.

    ## Warning in mean.default(x$Venta): argument is not numeric or logical: returning
    ## NA

``` r
y %>% 
  filter(Venta<media)
```

    ##  [1] DATE            Codigo Material Descripcion     Pais           
    ##  [5] Distribuidor    Territorio      Cliente         Marca          
    ##  [9] Canal Venta     Unidades plaza  Venta          
    ## <0 rows> (or 0-length row.names)
