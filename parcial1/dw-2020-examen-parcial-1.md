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
4.  Se tiene que agregar a los niveles con `levels(x) <- c(levels(x),
    "nueva_categoria")` 8, NA por que es un valor no disponible, los
    niveles describen todos los posibles valores del factor, si el
    elemento que queremos agrefar ahi no esta definido por los niveles
    entonces no es un valor disponible para el factor.
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
x %>% 
  head(10)
```

    ## # A tibble: 10 x 3
    ## # Groups:   Cliente [10]
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

media <- mean(y$Venta)

y %>% 
  filter(Venta<media)
```

    ##           DATE Codigo Material Descripcion     Pais Distribuidor Territorio
    ## 1   2018-05-01        aa021a0e    69a21a23 4f03bd9b     303a23b6   4ca9988b
    ## 2   2018-07-01        aa021a0e    69a21a23 4f03bd9b     303a23b6   3cae948b
    ## 3   2018-03-01        637caff5    0cf3ec3d 4046ee34     9a47575c   abfa1d4e
    ## 4   2019-01-01        637caff5    0cf3ec3d 4046ee34     9a47575c   abfa1d4e
    ## 5   2020-02-01        637caff5    0cf3ec3d 4046ee34     9a47575c   69c1b705
    ## 6   2020-02-01        637caff5    0cf3ec3d 4046ee34     9a47575c   f7dfc635
    ## 7   2020-02-01        637caff5    0cf3ec3d 4046ee34     9a47575c   77192d63
    ## 8   2020-01-01        6712bde0    eb75cfbe 4f03bd9b     303a23b6   6837187c
    ## 9   2020-01-01        6712bde0    eb75cfbe 4f03bd9b     303a23b6   80d1e625
    ## 10  2020-01-01        6712bde0    eb75cfbe 4f03bd9b     303a23b6   b77669c5
    ## 11  2018-04-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   b97335a1
    ## 12  2018-05-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   4856cd94
    ## 13  2018-08-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   0c169a3b
    ## 14  2018-08-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   2e4c5a7c
    ## 15  2018-06-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   c57e6d42
    ## 16  2019-07-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   6c8335a4
    ## 17  2019-05-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   b97335a1
    ## 18  2020-02-01        ecbbcd21    4c646efb 4f03bd9b     303a23b6   c57e6d42
    ## 19  2018-04-01        c84dfe42    f6353791 4046ee34     9a47575c   45c0376d
    ## 20  2018-05-01        c84dfe42    f6353791 4046ee34     9a47575c   f7dfc635
    ## 21  2018-03-01        c84dfe42    f6353791 4046ee34     9a47575c   2e812869
    ## 22  2018-08-01        c84dfe42    f6353791 4046ee34     9a47575c   1d407777
    ## 23  2018-05-01        c84dfe42    f6353791 4046ee34     9a47575c   1d407777
    ## 24  2018-06-01        c84dfe42    f6353791 4046ee34     9a47575c   4814799f
    ## 25  2020-02-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   5a464f3f
    ## 26  2018-11-01        6712bde0    eb75cfbe 4046ee34     9a47575c   f7dfc635
    ## 27  2018-11-01        6712bde0    eb75cfbe 4046ee34     9a47575c   77192d63
    ## 28  2019-02-01        6712bde0    eb75cfbe 4046ee34     9a47575c   77192d63
    ## 29  2019-04-01        6712bde0    eb75cfbe 4046ee34     9a47575c   1d407777
    ## 30  2019-12-01        6712bde0    eb75cfbe 4046ee34     9a47575c   a9e783db
    ## 31  2019-07-01        f5136def    1fdb2332 4f03bd9b     303a23b6   8f79b7f8
    ## 32  2019-09-01        f5136def    1fdb2332 4f03bd9b     303a23b6   c57e6d42
    ## 33  2018-10-01        c84dfe42    f6353791 4046ee34     9a47575c   f7dfc635
    ## 34  2018-09-01        c84dfe42    f6353791 4046ee34     9a47575c   f7dfc635
    ## 35  2019-09-01        c84dfe42    f6353791 4046ee34     9a47575c   69c1b705
    ## 36  2019-02-01        c84dfe42    f6353791 4046ee34     9a47575c   45c0376d
    ## 37  2019-03-01        c84dfe42    f6353791 4046ee34     9a47575c   f7dfc635
    ## 38  2019-08-01        c84dfe42    f6353791 4046ee34     9a47575c   f7dfc635
    ## 39  2019-06-01        c84dfe42    f6353791 4046ee34     9a47575c   f7dfc635
    ## 40  2019-07-01        c84dfe42    f6353791 4046ee34     9a47575c   67e9cc18
    ## 41  2019-03-01        c84dfe42    f6353791 4046ee34     9a47575c   77192d63
    ## 42  2019-11-01        c84dfe42    f6353791 4046ee34     9a47575c   77192d63
    ## 43  2019-04-01        c84dfe42    f6353791 4046ee34     9a47575c   abfa1d4e
    ## 44  2019-01-01        c84dfe42    f6353791 4046ee34     5d7fff27   f7dfc635
    ## 45  2019-07-01        2e61839e    5945cfbb 4f03bd9b     303a23b6   6837187c
    ## 46  2019-02-01        2e61839e    5945cfbb 4f03bd9b     303a23b6   28559553
    ## 47  2018-12-01        84d54ea3    6df8322f 4046ee34     9a47575c   69c1b705
    ## 48  2018-10-01        84d54ea3    6df8322f 4046ee34     9a47575c   69c1b705
    ## 49  2018-11-01        84d54ea3    6df8322f 4046ee34     9a47575c   45c0376d
    ## 50  2018-12-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 51  2018-11-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 52  2018-10-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 53  2018-10-01        84d54ea3    6df8322f 4046ee34     9a47575c   2e812869
    ## 54  2018-11-01        84d54ea3    6df8322f 4046ee34     9a47575c   2e812869
    ## 55  2018-12-01        84d54ea3    6df8322f 4046ee34     9a47575c   77192d63
    ## 56  2018-10-01        84d54ea3    6df8322f 4046ee34     9a47575c   77192d63
    ## 57  2018-12-01        84d54ea3    6df8322f 4046ee34     9a47575c   77192d63
    ## 58  2018-12-01        84d54ea3    6df8322f 4046ee34     9a47575c   b50e91fb
    ## 59  2018-10-01        84d54ea3    6df8322f 4046ee34     9a47575c   1d407777
    ## 60  2018-11-01        84d54ea3    6df8322f 4046ee34     9a47575c   a9e783db
    ## 61  2018-11-01        84d54ea3    6df8322f 4046ee34     9a47575c   a9e783db
    ## 62  2018-11-01        84d54ea3    6df8322f 4046ee34     9a47575c   a9e783db
    ## 63  2019-01-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 64  2019-01-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 65  2019-01-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 66  2019-01-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 67  2019-12-01        84d54ea3    6df8322f 4046ee34     9a47575c   77192d63
    ## 68  2019-10-01        84d54ea3    6df8322f 4046ee34     9a47575c   9fdcc550
    ## 69  2019-07-01        84d54ea3    6df8322f 4046ee34     9a47575c   4814799f
    ## 70  2019-08-01        84d54ea3    6df8322f 4046ee34     9a47575c   a9e783db
    ## 71  2020-02-01        c84dfe42    f6353791 4046ee34     9a47575c   67e9cc18
    ## 72  2018-03-01        4cad15c2    fade7200 4046ee34     9a47575c   f7dfc635
    ## 73  2018-09-01        4cad15c2    fade7200 4046ee34     9a47575c   f7dfc635
    ## 74  2018-02-01        4cad15c2    fade7200 4046ee34     9a47575c   f7dfc635
    ## 75  2018-05-01        4cad15c2    fade7200 4046ee34     9a47575c   bc8e06ed
    ## 76  2018-03-01        4cad15c2    fade7200 4046ee34     9a47575c   2e812869
    ## 77  2018-01-01        4cad15c2    fade7200 4046ee34     9a47575c   67e9cc18
    ## 78  2018-01-01        4cad15c2    fade7200 4046ee34     9a47575c   67e9cc18
    ## 79  2018-05-01        4cad15c2    fade7200 4046ee34     9a47575c   67e9cc18
    ## 80  2018-02-01        4cad15c2    fade7200 4046ee34     9a47575c   77192d63
    ## 81  2018-10-01        4cad15c2    fade7200 4046ee34     9a47575c   77192d63
    ## 82  2018-07-01        4cad15c2    fade7200 4046ee34     9a47575c   b50e91fb
    ## 83  2018-05-01        4cad15c2    fade7200 4046ee34     9a47575c   1d407777
    ## 84  2018-01-01        4cad15c2    fade7200 4046ee34     9a47575c   1d407777
    ## 85  2018-01-01        4cad15c2    fade7200 4046ee34     9a47575c   1d407777
    ## 86  2018-05-01        4cad15c2    fade7200 4046ee34     9a47575c   abfa1d4e
    ## 87  2018-03-01        4cad15c2    fade7200 4046ee34     9a47575c   9fdcc550
    ## 88  2019-01-01        4cad15c2    fade7200 4046ee34     9a47575c   f7dfc635
    ## 89  2019-02-01        4cad15c2    fade7200 4046ee34     9a47575c   f7dfc635
    ## 90  2019-03-01        4cad15c2    fade7200 4046ee34     9a47575c   2e812869
    ## 91  2019-02-01        4cad15c2    fade7200 4046ee34     9a47575c   67e9cc18
    ## 92  2019-03-01        4cad15c2    fade7200 4046ee34     9a47575c   77192d63
    ## 93  2019-02-01        4cad15c2    fade7200 4046ee34     9a47575c   77192d63
    ## 94  2019-01-01        4cad15c2    fade7200 4046ee34     9a47575c   77192d63
    ## 95  2019-08-01        4cad15c2    fade7200 4046ee34     9a47575c   abfa1d4e
    ## 96  2020-02-01        4cad15c2    fade7200 4046ee34     9a47575c   2e812869
    ## 97  2020-02-01        4cad15c2    fade7200 4046ee34     9a47575c   1d407777
    ## 98  2018-03-01        e5422a31    5b38b381 4f03bd9b     303a23b6   a0d39798
    ## 99  2018-05-01        e5422a31    5b38b381 4f03bd9b     303a23b6   4856cd94
    ## 100 2018-03-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   4ca9988b
    ## 101 2018-07-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   4ca9988b
    ## 102 2018-05-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   0c169a3b
    ## 103 2018-05-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   0c169a3b
    ## 104 2018-08-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   c57e6d42
    ## 105 2018-08-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 106 2018-05-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 107 2018-06-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 108 2018-08-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 109 2018-06-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 110 2018-01-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 111 2018-06-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 112 2018-01-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 113 2018-06-01        38cf993d    9e26bae4 4046ee34     9a47575c   bc8e06ed
    ## 114 2018-02-01        38cf993d    9e26bae4 4046ee34     9a47575c   bc8e06ed
    ## 115 2018-06-01        38cf993d    9e26bae4 4046ee34     9a47575c   bc8e06ed
    ## 116 2018-04-01        38cf993d    9e26bae4 4046ee34     9a47575c   2e812869
    ## 117 2018-08-01        38cf993d    9e26bae4 4046ee34     9a47575c   2e812869
    ## 118 2018-01-01        38cf993d    9e26bae4 4046ee34     9a47575c   2e812869
    ## 119 2018-01-01        38cf993d    9e26bae4 4046ee34     9a47575c   77192d63
    ## 120 2018-02-01        38cf993d    9e26bae4 4046ee34     9a47575c   77192d63
    ## 121 2018-03-01        38cf993d    9e26bae4 4046ee34     9a47575c   b50e91fb
    ## 122 2018-02-01        38cf993d    9e26bae4 4046ee34     9a47575c   1d407777
    ## 123 2018-02-01        38cf993d    9e26bae4 4046ee34     9a47575c   a9e783db
    ## 124 2018-10-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   c31adb2f
    ## 125 2018-10-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   72520ba2
    ## 126 2018-10-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   75298f79
    ## 127 2018-10-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   23e9d55d
    ## 128 2018-10-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   0c169a3b
    ## 129 2019-06-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   72520ba2
    ## 130 2019-05-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   b97335a1
    ## 131 2019-10-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   75298f79
    ## 132 2019-04-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   28559553
    ## 133 2019-04-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   7a861731
    ## 134 2019-01-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   67a61c29
    ## 135 2019-06-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   91e7e31b
    ## 136 2018-09-01        38cf993d    9e26bae4 4046ee34     9a47575c   69c1b705
    ## 137 2018-10-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 138 2018-09-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 139 2018-09-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 140 2018-11-01        38cf993d    9e26bae4 4046ee34     9a47575c   2e812869
    ## 141 2019-09-01        38cf993d    9e26bae4 4046ee34     9a47575c   69c1b705
    ## 142 2019-05-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 143 2019-06-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 144 2019-06-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 145 2019-07-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 146 2019-01-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 147 2019-09-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 148 2019-03-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 149 2019-06-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 150 2019-06-01        38cf993d    9e26bae4 4046ee34     9a47575c   bc8e06ed
    ## 151 2019-06-01        38cf993d    9e26bae4 4046ee34     9a47575c   bc8e06ed
    ## 152 2019-06-01        38cf993d    9e26bae4 4046ee34     9a47575c   bc8e06ed
    ## 153 2019-07-01        38cf993d    9e26bae4 4046ee34     9a47575c   2e812869
    ## 154 2019-05-01        38cf993d    9e26bae4 4046ee34     9a47575c   2e812869
    ## 155 2019-02-01        38cf993d    9e26bae4 4046ee34     9a47575c   77192d63
    ## 156 2020-02-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 157 2020-02-01        38cf993d    9e26bae4 4046ee34     9a47575c   bc8e06ed
    ## 158 2018-06-01        4733b1ff    ecd8a904 4046ee34     9a47575c   0dd30fcd
    ## 159 2020-01-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   a7291d87
    ## 160 2019-06-01        e5422a31    5b38b381 4f03bd9b     303a23b6   72520ba2
    ## 161 2019-05-01        e5422a31    5b38b381 4f03bd9b     303a23b6   23e9d55d
    ## 162 2019-09-01        e5422a31    5b38b381 4f03bd9b     303a23b6   0c169a3b
    ## 163 2018-10-01        ef757e78    b8996578 4046ee34     9a47575c   69c1b705
    ## 164 2018-01-01        ef757e78    b8996578 4046ee34     9a47575c   f7dfc635
    ## 165 2018-06-01        ef757e78    b8996578 4046ee34     9a47575c   f7dfc635
    ## 166 2018-07-01        ef757e78    b8996578 4046ee34     9a47575c   f7dfc635
    ## 167 2018-06-01        ef757e78    b8996578 4046ee34     9a47575c   bc8e06ed
    ## 168 2018-12-01        ef757e78    b8996578 4046ee34     9a47575c   bc8e06ed
    ## 169 2018-05-01        ef757e78    b8996578 4046ee34     9a47575c   67e9cc18
    ## 170 2018-05-01        ef757e78    b8996578 4046ee34     9a47575c   77192d63
    ## 171 2019-07-01        ef757e78    b8996578 4046ee34     9a47575c   69c1b705
    ## 172 2019-08-01        ef757e78    b8996578 4046ee34     9a47575c   69c1b705
    ## 173 2019-11-01        ef757e78    b8996578 4046ee34     9a47575c   69c1b705
    ## 174 2019-04-01        ef757e78    b8996578 4046ee34     9a47575c   f7dfc635
    ## 175 2019-07-01        ef757e78    b8996578 4046ee34     9a47575c   2e812869
    ## 176 2019-10-01        ef757e78    b8996578 4046ee34     9a47575c   b50e91fb
    ## 177 2019-09-01        ef757e78    b8996578 4046ee34     9a47575c   1d407777
    ## 178 2019-07-01        ef757e78    b8996578 4046ee34     9a47575c   9fdcc550
    ## 179 2020-01-01        ef757e78    b8996578 4046ee34     9a47575c   f7dfc635
    ## 180 2019-05-01        e5422a31    5b38b381 4046ee34     9a47575c   a9e783db
    ## 181 2019-11-01        ef757e78    b8996578 4f03bd9b     303a23b6   fed6647d
    ## 182 2019-07-01        ef757e78    b8996578 4f03bd9b     303a23b6   680cec1c
    ## 183 2020-01-01        ef757e78    b8996578 4f03bd9b     303a23b6   f97a3f33
    ## 184 2018-02-01        f5136def    1fdb2332 4046ee34     9a47575c   69c1b705
    ## 185 2018-06-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   4ca9988b
    ## 186 2018-08-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   002da6aa
    ## 187 2018-05-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   8f79b7f8
    ## 188 2018-04-01        96498cde    87403f6f 4046ee34     9a47575c   69c1b705
    ## 189 2018-03-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 190 2018-05-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 191 2018-06-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 192 2018-08-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 193 2018-06-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 194 2018-08-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 195 2018-07-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 196 2018-06-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 197 2018-05-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 198 2018-05-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 199 2018-08-01        96498cde    87403f6f 4046ee34     9a47575c   bc8e06ed
    ## 200 2018-08-01        96498cde    87403f6f 4046ee34     9a47575c   bc8e06ed
    ## 201 2018-07-01        96498cde    87403f6f 4046ee34     9a47575c   2e812869
    ## 202 2018-03-01        96498cde    87403f6f 4046ee34     9a47575c   2e812869
    ## 203 2018-08-01        96498cde    87403f6f 4046ee34     9a47575c   2e812869
    ## 204 2018-05-01        96498cde    87403f6f 4046ee34     9a47575c   67e9cc18
    ## 205 2018-06-01        96498cde    87403f6f 4046ee34     9a47575c   67e9cc18
    ## 206 2018-04-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 207 2018-07-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 208 2018-04-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 209 2018-04-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 210 2018-07-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 211 2018-06-01        96498cde    87403f6f 4046ee34     9a47575c   b50e91fb
    ## 212 2018-05-01        96498cde    87403f6f 4046ee34     9a47575c   1d407777
    ## 213 2018-02-01        96498cde    87403f6f 4046ee34     9a47575c   1d407777
    ## 214 2018-05-01        96498cde    87403f6f 4046ee34     9a47575c   1d407777
    ## 215 2018-06-01        96498cde    87403f6f 4046ee34     9a47575c   a9e783db
    ## 216 2018-06-01        96498cde    87403f6f 4046ee34     9a47575c   a9e783db
    ## 217 2020-01-01        e5422a31    5b38b381 4046ee34     9a47575c   f7dfc635
    ## 218 2019-10-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   c31adb2f
    ## 219 2019-10-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   72520ba2
    ## 220 2019-09-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   72520ba2
    ## 221 2019-06-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   72520ba2
    ## 222 2019-11-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   fed6647d
    ## 223 2019-05-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   4ca9988b
    ## 224 2019-07-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   4ca9988b
    ## 225 2019-05-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   a0d39798
    ## 226 2019-06-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   0ef0ce97
    ## 227 2019-02-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   67696f68
    ## 228 2019-06-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   680cec1c
    ## 229 2020-02-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   72520ba2
    ## 230 2020-01-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   8f79b7f8
    ## 231 2020-02-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   8f79b7f8
    ## 232 2020-01-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   b77669c5
    ## 233 2018-10-01        4733b1ff    ecd8a904 4046ee34     9a47575c   f7dfc635
    ## 234 2019-10-01        4733b1ff    ecd8a904 4046ee34     5d7fff27   77192d63
    ## 235 2018-09-01        96498cde    87403f6f 4046ee34     9a47575c   69c1b705
    ## 236 2018-11-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 237 2018-09-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 238 2018-09-01        96498cde    87403f6f 4046ee34     9a47575c   bc8e06ed
    ## 239 2018-10-01        96498cde    87403f6f 4046ee34     9a47575c   2e812869
    ## 240 2018-10-01        96498cde    87403f6f 4046ee34     9a47575c   2e812869
    ## 241 2018-11-01        96498cde    87403f6f 4046ee34     9a47575c   2e812869
    ## 242 2018-12-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 243 2018-11-01        96498cde    87403f6f 4046ee34     9a47575c   b50e91fb
    ## 244 2018-11-01        96498cde    87403f6f 4046ee34     9a47575c   b50e91fb
    ## 245 2018-11-01        96498cde    87403f6f 4046ee34     9a47575c   b50e91fb
    ## 246 2018-11-01        96498cde    87403f6f 4046ee34     9a47575c   1d407777
    ## 247 2018-06-01        c84dfe42    f6353791 4f03bd9b     303a23b6   72520ba2
    ## 248 2018-05-01        c84dfe42    f6353791 4f03bd9b     303a23b6   72520ba2
    ## 249 2018-06-01        c84dfe42    f6353791 4f03bd9b     303a23b6   b97335a1
    ## 250 2018-07-01        c84dfe42    f6353791 4f03bd9b     303a23b6   75298f79
    ## 251 2018-05-01        c84dfe42    f6353791 4f03bd9b     303a23b6   4ca9988b
    ## 252 2018-04-01        c84dfe42    f6353791 4f03bd9b     303a23b6   e49916a2
    ## 253 2018-05-01        c84dfe42    f6353791 4f03bd9b     303a23b6   dfd48934
    ## 254 2018-03-01        c84dfe42    f6353791 4f03bd9b     303a23b6   a7291d87
    ## 255 2019-12-01        96498cde    87403f6f 4046ee34     9a47575c   69c1b705
    ## 256 2019-04-01        96498cde    87403f6f 4046ee34     9a47575c   69c1b705
    ## 257 2019-07-01        96498cde    87403f6f 4046ee34     9a47575c   69c1b705
    ## 258 2019-09-01        96498cde    87403f6f 4046ee34     9a47575c   45c0376d
    ## 259 2019-09-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 260 2019-09-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 261 2019-05-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 262 2019-07-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 263 2019-10-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 264 2019-11-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 265 2019-07-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 266 2019-02-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 267 2019-08-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 268 2019-12-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 269 2019-03-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 270 2019-05-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 271 2019-05-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 272 2019-04-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 273 2019-04-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 274 2019-12-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 275 2019-04-01        96498cde    87403f6f 4046ee34     9a47575c   0dd30fcd
    ## 276 2019-03-01        96498cde    87403f6f 4046ee34     9a47575c   2e812869
    ## 277 2019-11-01        96498cde    87403f6f 4046ee34     9a47575c   2e812869
    ## 278 2019-05-01        96498cde    87403f6f 4046ee34     9a47575c   67e9cc18
    ## 279 2019-02-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 280 2019-10-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 281 2019-03-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 282 2019-02-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 283 2019-12-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 284 2019-02-01        96498cde    87403f6f 4046ee34     9a47575c   b50e91fb
    ## 285 2019-08-01        96498cde    87403f6f 4046ee34     9a47575c   1d407777
    ## 286 2019-02-01        96498cde    87403f6f 4046ee34     9a47575c   1d407777
    ## 287 2019-10-01        96498cde    87403f6f 4046ee34     9a47575c   a9e783db
    ## 288 2019-09-01        96498cde    87403f6f 4046ee34     9a47575c   a9e783db
    ## 289 2019-06-01        96498cde    87403f6f 4046ee34     5d7fff27   0dd30fcd
    ## 290 2019-07-01        96498cde    87403f6f 4046ee34     5d7fff27   77192d63
    ## 291 2018-01-01        4d1f394c    e6cb0090 4f03bd9b     303a23b6   d7254672
    ## 292 2018-01-01        4d1f394c    e6cb0090 4f03bd9b     303a23b6   9d9f2da6
    ## 293 2020-02-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 294 2020-02-01        96498cde    87403f6f 4046ee34     9a47575c   0dd30fcd
    ## 295 2020-02-01        96498cde    87403f6f 4046ee34     9a47575c   2e812869
    ## 296 2020-02-01        96498cde    87403f6f 4046ee34     9a47575c   2e812869
    ## 297 2020-01-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 298 2020-01-01        96498cde    87403f6f 4046ee34     9a47575c   1d407777
    ## 299 2019-12-01        c84dfe42    f6353791 4f03bd9b     303a23b6   72520ba2
    ## 300 2019-06-01        c84dfe42    f6353791 4f03bd9b     303a23b6   b97335a1
    ## 301 2019-11-01        c84dfe42    f6353791 4f03bd9b     303a23b6   fed6647d
    ## 302 2019-11-01        c84dfe42    f6353791 4f03bd9b     303a23b6   fed6647d
    ## 303 2019-07-01        c84dfe42    f6353791 4f03bd9b     303a23b6   e49916a2
    ## 304 2019-07-01        c84dfe42    f6353791 4f03bd9b     303a23b6   23e9d55d
    ## 305 2019-10-01        c84dfe42    f6353791 4f03bd9b     303a23b6   4856cd94
    ## 306 2019-09-01        c84dfe42    f6353791 4f03bd9b     303a23b6   3cae948b
    ## 307 2019-06-01        f5136def    1fdb2332 4046ee34     9a47575c   77192d63
    ## 308 2018-12-01        8fd33e8f    4510826f 4f03bd9b     303a23b6   680cec1c
    ## 309 2019-05-01        8fd33e8f    4510826f 4f03bd9b     303a23b6   b77669c5
    ## 310 2020-01-01        c84dfe42    f6353791 4f03bd9b     303a23b6   a7ee3287
    ## 311 2018-07-01        a986ce60    d2cc3f9c 4f03bd9b     303a23b6   4ca9988b
    ## 312 2018-08-01        a986ce60    d2cc3f9c 4f03bd9b     303a23b6   7a861731
    ## 313 2019-10-01        ecbbcd21    4c646efb 4046ee34     5d7fff27   f7dfc635
    ## 314 2018-08-01        98724eee    9242a5f2 4046ee34     9a47575c   bc8e06ed
    ## 315 2018-02-01        98724eee    9242a5f2 4046ee34     9a47575c   2e812869
    ## 316 2018-04-01        98724eee    9242a5f2 4046ee34     9a47575c   4814799f
    ## 317 2019-11-01        98724eee    9242a5f2 4046ee34     9a47575c   69c1b705
    ## 318 2019-10-01        98724eee    9242a5f2 4046ee34     9a47575c   f7dfc635
    ## 319 2019-06-01        98724eee    9242a5f2 4046ee34     9a47575c   4814799f
    ## 320 2020-01-01        98724eee    9242a5f2 4046ee34     9a47575c   bc8e06ed
    ## 321 2020-02-01        98724eee    9242a5f2 4046ee34     9a47575c   b50e91fb
    ## 322 2020-01-01        8fd33e8f    4510826f 4f03bd9b     303a23b6   6899442b
    ## 323 2018-05-01        6712bde0    eb75cfbe 4f03bd9b     303a23b6   4856cd94
    ## 324 2019-11-01        637caff5    0cf3ec3d 4f03bd9b     303a23b6   fed6647d
    ## 325 2018-05-01        2e61839e    5945cfbb 4f03bd9b     303a23b6   72520ba2
    ## 326 2020-02-01        ecbbcd21    4c646efb 4046ee34     9a47575c   4814799f
    ## 327 2019-11-01        a986ce60    d2cc3f9c 4f03bd9b     303a23b6   fed6647d
    ## 328 2019-02-01        a986ce60    d2cc3f9c 4f03bd9b     303a23b6   0320288f
    ## 329 2019-11-01        98724eee    9242a5f2 4f03bd9b     303a23b6   fed6647d
    ## 330 2019-10-01        5144aff8    269521bb 4046ee34     9a47575c   f7dfc635
    ## 331 2018-11-01        df07e07a    832abf99 4046ee34     9a47575c   69c1b705
    ## 332 2018-10-01        df07e07a    832abf99 4046ee34     9a47575c   f7dfc635
    ## 333 2018-08-01        df07e07a    832abf99 4046ee34     9a47575c   0dd30fcd
    ## 334 2019-06-01        df07e07a    832abf99 4046ee34     9a47575c   f7dfc635
    ## 335 2019-03-01        df07e07a    832abf99 4046ee34     9a47575c   f7dfc635
    ## 336 2019-06-01        df07e07a    832abf99 4046ee34     9a47575c   f7dfc635
    ## 337 2019-08-01        df07e07a    832abf99 4046ee34     9a47575c   bc8e06ed
    ## 338 2019-05-01        df07e07a    832abf99 4046ee34     9a47575c   b50e91fb
    ## 339 2019-04-01        df07e07a    832abf99 4046ee34     9a47575c   1d407777
    ## 340 2019-08-01        df07e07a    832abf99 4f03bd9b     303a23b6   0ef0ce97
    ## 341 2019-04-01        df07e07a    832abf99 4f03bd9b     303a23b6   91e7e31b
    ## 342 2020-02-01        df07e07a    832abf99 4046ee34     9a47575c   f7dfc635
    ## 343 2020-02-01        df07e07a    832abf99 4046ee34     9a47575c   f7dfc635
    ## 344 2020-01-01        df07e07a    832abf99 4046ee34     9a47575c   a9e783db
    ## 345 2020-02-01        df07e07a    832abf99 4f03bd9b     303a23b6   fce0345f
    ## 346 2020-02-01        df07e07a    832abf99 4f03bd9b     303a23b6   a0d39798
    ## 347 2020-01-01        df07e07a    832abf99 4f03bd9b     303a23b6   23e9d55d
    ## 348 2019-05-01        f5136def    1fdb2332 4f03bd9b     303a23b6   680cec1c
    ## 349 2019-05-01        6712bde0    eb75cfbe 4f03bd9b     303a23b6   a0d39798
    ## 350 2018-05-01        ecbbcd21    4c646efb 4f03bd9b     303a23b6   c57e6d42
    ## 351 2020-02-01        f5136def    1fdb2332 4f03bd9b     303a23b6   75298f79
    ## 352 2018-04-01        96498cde    87403f6f 4f03bd9b     303a23b6   c31adb2f
    ## 353 2018-05-01        96498cde    87403f6f 4f03bd9b     303a23b6   72520ba2
    ## 354 2018-06-01        96498cde    87403f6f 4f03bd9b     303a23b6   72520ba2
    ## 355 2018-06-01        96498cde    87403f6f 4f03bd9b     303a23b6   3350838e
    ## 356 2018-03-01        96498cde    87403f6f 4f03bd9b     303a23b6   c072f75a
    ## 357 2018-04-01        96498cde    87403f6f 4f03bd9b     303a23b6   4ca9988b
    ## 358 2018-07-01        96498cde    87403f6f 4f03bd9b     303a23b6   4ca9988b
    ## 359 2018-06-01        96498cde    87403f6f 4f03bd9b     303a23b6   4ca9988b
    ## 360 2018-06-01        96498cde    87403f6f 4f03bd9b     303a23b6   4ca9988b
    ## 361 2018-05-01        96498cde    87403f6f 4f03bd9b     303a23b6   a7ee3287
    ## 362 2018-08-01        96498cde    87403f6f 4f03bd9b     303a23b6   7a861731
    ## 363 2018-04-01        96498cde    87403f6f 4f03bd9b     303a23b6   54969a29
    ## 364 2018-05-01        96498cde    87403f6f 4f03bd9b     303a23b6   e49916a2
    ## 365 2018-05-01        96498cde    87403f6f 4f03bd9b     303a23b6   f9c36cff
    ## 366 2018-05-01        96498cde    87403f6f 4f03bd9b     303a23b6   0c169a3b
    ## 367 2018-03-01        96498cde    87403f6f 4f03bd9b     303a23b6   0c169a3b
    ## 368 2018-08-01        4cad15c2    fade7200 4f03bd9b     303a23b6   7a861731
    ## 369 2020-01-01        6712bde0    eb75cfbe 4f03bd9b     303a23b6   c57e6d42
    ## 370 2019-03-01        aa021a0e    69a21a23 4f03bd9b     303a23b6   3cae948b
    ## 371 2019-05-01        6712bde0    eb75cfbe 4046ee34     9a47575c   f7dfc635
    ## 372 2018-12-01        96498cde    87403f6f 4f03bd9b     303a23b6   72520ba2
    ## 373 2018-10-01        96498cde    87403f6f 4f03bd9b     303a23b6   72520ba2
    ## 374 2018-10-01        96498cde    87403f6f 4f03bd9b     303a23b6   72520ba2
    ## 375 2018-10-01        96498cde    87403f6f 4f03bd9b     303a23b6   b97335a1
    ## 376 2019-03-01        96498cde    87403f6f 4f03bd9b     303a23b6   72520ba2
    ## 377 2019-10-01        96498cde    87403f6f 4f03bd9b     303a23b6   6837187c
    ## 378 2019-11-01        96498cde    87403f6f 4f03bd9b     303a23b6   fed6647d
    ## 379 2019-11-01        96498cde    87403f6f 4f03bd9b     303a23b6   fed6647d
    ## 380 2019-11-01        96498cde    87403f6f 4f03bd9b     303a23b6   fed6647d
    ## 381 2019-11-01        96498cde    87403f6f 4f03bd9b     303a23b6   fed6647d
    ## 382 2019-11-01        96498cde    87403f6f 4f03bd9b     303a23b6   fed6647d
    ## 383 2019-11-01        96498cde    87403f6f 4f03bd9b     303a23b6   fed6647d
    ## 384 2019-11-01        96498cde    87403f6f 4f03bd9b     303a23b6   fed6647d
    ## 385 2019-06-01        96498cde    87403f6f 4f03bd9b     303a23b6   a7ee3287
    ## 386 2019-12-01        96498cde    87403f6f 4f03bd9b     303a23b6   a7ee3287
    ## 387 2019-02-01        96498cde    87403f6f 4f03bd9b     303a23b6   7a861731
    ## 388 2019-05-01        96498cde    87403f6f 4f03bd9b     303a23b6   8f79b7f8
    ## 389 2019-05-01        96498cde    87403f6f 4f03bd9b     303a23b6   8f79b7f8
    ## 390 2019-02-01        96498cde    87403f6f 4f03bd9b     303a23b6   23e9d55d
    ## 391 2019-06-01        96498cde    87403f6f 4f03bd9b     303a23b6   3153c73e
    ## 392 2019-03-01        96498cde    87403f6f 4f03bd9b     303a23b6   b77669c5
    ## 393 2019-10-01        96498cde    87403f6f 4f03bd9b     303a23b6   0c169a3b
    ## 394 2019-04-01        96498cde    87403f6f 4f03bd9b     303a23b6   0c169a3b
    ## 395 2019-04-01        96498cde    87403f6f 4f03bd9b     303a23b6   c57e6d42
    ## 396 2019-04-01        96498cde    87403f6f 4f03bd9b     303a23b6   c57e6d42
    ## 397 2018-04-01        f4bfba2c    f0e3e1a0 4046ee34     9a47575c   f7dfc635
    ## 398 2018-05-01        f4bfba2c    f0e3e1a0 4046ee34     9a47575c   2e812869
    ## 399 2018-04-01        f4bfba2c    f0e3e1a0 4046ee34     9a47575c   77192d63
    ## 400 2019-04-01        f4bfba2c    f0e3e1a0 4046ee34     9a47575c   f7dfc635
    ## 401 2019-05-01        f4bfba2c    f0e3e1a0 4046ee34     9a47575c   77192d63
    ## 402 2019-12-01        f4bfba2c    f0e3e1a0 4046ee34     9a47575c   a9e783db
    ## 403 2020-01-01        96498cde    87403f6f 4f03bd9b     303a23b6   72520ba2
    ## 404 2020-01-01        96498cde    87403f6f 4f03bd9b     303a23b6   72520ba2
    ## 405 2020-02-01        96498cde    87403f6f 4f03bd9b     303a23b6   8f79b7f8
    ## 406 2020-02-01        96498cde    87403f6f 4f03bd9b     303a23b6   8f79b7f8
    ## 407 2020-01-01        96498cde    87403f6f 4f03bd9b     303a23b6   a7291d87
    ## 408 2019-09-01        ef757e78    b8996578 4f03bd9b     303a23b6   23e9d55d
    ## 409 2019-09-01        f5136def    1fdb2332 4046ee34     9a47575c   77192d63
    ## 410 2018-03-01        199d17cf    788df831 4046ee34     9a47575c   f7dfc635
    ## 411 2018-08-01        199d17cf    788df831 4046ee34     9a47575c   f7dfc635
    ## 412 2018-02-01        199d17cf    788df831 4046ee34     9a47575c   bc8e06ed
    ## 413 2018-08-01        199d17cf    788df831 4046ee34     9a47575c   9fdcc550
    ## 414 2018-06-01        5a3ab3b2    d6eccd15 4046ee34     9a47575c   bc8e06ed
    ## 415 2019-12-01        5a3ab3b2    d6eccd15 4046ee34     9a47575c   69c1b705
    ## 416 2019-03-01        5a3ab3b2    d6eccd15 4046ee34     9a47575c   69c1b705
    ## 417 2019-06-01        5a3ab3b2    d6eccd15 4046ee34     9a47575c   77192d63
    ## 418 2019-09-01        5a3ab3b2    d6eccd15 4046ee34     9a47575c   abfa1d4e
    ## 419 2019-01-01        5a3ab3b2    d6eccd15 4046ee34     5d7fff27   67e9cc18
    ## 420 2020-02-01        5a3ab3b2    d6eccd15 4046ee34     9a47575c   67e9cc18
    ## 421 2020-02-01        5a3ab3b2    d6eccd15 4046ee34     9a47575c   1d407777
    ## 422 2018-06-01        637caff5    0cf3ec3d 4046ee34     9a47575c   0dd30fcd
    ## 423 2018-03-01        637caff5    0cf3ec3d 4046ee34     9a47575c   77192d63
    ## 424 2019-09-01        e5422a31    5b38b381 4f03bd9b     303a23b6   4856cd94
    ## 425 2019-08-01        199d17cf    788df831 4046ee34     9a47575c   f7dfc635
    ## 426 2019-02-01        199d17cf    788df831 4046ee34     9a47575c   bc8e06ed
    ## 427 2019-03-01        199d17cf    788df831 4046ee34     9a47575c   bc8e06ed
    ## 428 2019-08-01        199d17cf    788df831 4046ee34     9a47575c   2e812869
    ## 429 2018-04-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   80d1e625
    ## 430 2018-05-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   bcdf2ef9
    ## 431 2018-11-01        ef757e78    b8996578 4046ee34     9a47575c   f7dfc635
    ## 432 2018-09-01        ef757e78    b8996578 4046ee34     9a47575c   bc8e06ed
    ## 433 2018-10-01        ef757e78    b8996578 4046ee34     9a47575c   2e812869
    ## 434 2018-02-01        ef757e78    b8996578 4046ee34     9a47575c   77192d63
    ## 435 2019-06-01        ef757e78    b8996578 4046ee34     9a47575c   69c1b705
    ## 436 2019-10-01        ef757e78    b8996578 4046ee34     9a47575c   67e9cc18
    ## 437 2020-02-01        ef757e78    b8996578 4046ee34     9a47575c   f7dfc635
    ## 438 2019-02-01        8fd33e8f    4510826f 4046ee34     9a47575c   bc8e06ed
    ## 439 2018-05-01        98724eee    9242a5f2 4f03bd9b     303a23b6   c57e6d42
    ## 440 2018-01-01        199d17cf    788df831 4f03bd9b     303a23b6   23e9d55d
    ## 441 2019-05-01        f5136def    1fdb2332 4f03bd9b     303a23b6   a7ee3287
    ## 442 2019-07-01        f5136def    1fdb2332 4f03bd9b     303a23b6   0c169a3b
    ## 443 2020-01-01        199d17cf    788df831 4f03bd9b     303a23b6   680cec1c
    ## 444 2018-07-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 445 2018-11-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 446 2018-12-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 447 2018-11-01        84d54ea3    6df8322f 4046ee34     9a47575c   2e812869
    ## 448 2018-12-01        84d54ea3    6df8322f 4046ee34     9a47575c   67e9cc18
    ## 449 2018-11-01        84d54ea3    6df8322f 4046ee34     9a47575c   77192d63
    ## 450 2018-11-01        84d54ea3    6df8322f 4046ee34     9a47575c   b50e91fb
    ## 451 2018-12-01        84d54ea3    6df8322f 4046ee34     9a47575c   1d407777
    ## 452 2018-05-01        84d54ea3    6df8322f 4046ee34     9a47575c   1d407777
    ## 453 2019-02-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 454 2019-02-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 455 2019-02-01        84d54ea3    6df8322f 4046ee34     9a47575c   2e812869
    ## 456 2019-01-01        84d54ea3    6df8322f 4046ee34     9a47575c   67e9cc18
    ## 457 2019-03-01        84d54ea3    6df8322f 4046ee34     9a47575c   77192d63
    ## 458 2019-01-01        84d54ea3    6df8322f 4046ee34     9a47575c   b50e91fb
    ## 459 2019-12-01        84d54ea3    6df8322f 4046ee34     9a47575c   1d407777
    ## 460 2018-02-01        4cad15c2    fade7200 4046ee34     9a47575c   f7dfc635
    ## 461 2018-03-01        4cad15c2    fade7200 4046ee34     9a47575c   bc8e06ed
    ## 462 2018-02-01        4cad15c2    fade7200 4046ee34     9a47575c   77192d63
    ## 463 2018-12-01        4cad15c2    fade7200 4046ee34     9a47575c   77192d63
    ## 464 2018-01-01        4cad15c2    fade7200 4046ee34     9a47575c   4814799f
    ## 465 2019-01-01        4cad15c2    fade7200 4046ee34     9a47575c   f7dfc635
    ## 466 2019-02-01        4cad15c2    fade7200 4046ee34     9a47575c   f7dfc635
    ## 467 2019-01-01        4cad15c2    fade7200 4046ee34     9a47575c   bc8e06ed
    ## 468 2019-05-01        6712bde0    eb75cfbe 4f03bd9b     303a23b6   1c81fb6c
    ## 469 2018-07-01        98724eee    9242a5f2 4046ee34     9a47575c   f7dfc635
    ## 470 2019-11-01        98724eee    9242a5f2 4046ee34     9a47575c   a9e783db
    ## 471 2018-01-01        df07e07a    832abf99 4046ee34     9a47575c   f7dfc635
    ## 472 2018-10-01        df07e07a    832abf99 4f03bd9b     303a23b6   67696f68
    ## 473 2019-12-01        df07e07a    832abf99 4046ee34     9a47575c   f7dfc635
    ## 474 2020-02-01        df07e07a    832abf99 4046ee34     9a47575c   f7dfc635
    ## 475 2019-04-01        aa021a0e    69a21a23 4f03bd9b     303a23b6   4856cd94
    ## 476 2018-05-01        4d1f394c    e6cb0090 4f03bd9b     303a23b6   bcdf2ef9
    ## 477 2018-04-01        4d1f394c    e6cb0090 4f03bd9b     303a23b6   0bbe6418
    ## 478 2018-10-01        ef757e78    b8996578 4f03bd9b     303a23b6   8682908b
    ## 479 2018-08-01        26439f6e    44010ac1 4046ee34     9a47575c   bc8e06ed
    ## 480 2018-01-01        8fd33e8f    4510826f 4f03bd9b     303a23b6   4856cd94
    ## 481 2019-12-01        26439f6e    44010ac1 4046ee34     9a47575c   f7dfc635
    ## 482 2019-01-01        26439f6e    44010ac1 4046ee34     9a47575c   1d407777
    ## 483 2018-02-01        e5422a31    5b38b381 4046ee34     9a47575c   69c1b705
    ## 484 2018-06-01        26439f6e    44010ac1 4f03bd9b     303a23b6   72520ba2
    ## 485 2018-04-01        26439f6e    44010ac1 4f03bd9b     303a23b6   cc471eed
    ## 486 2018-12-01        8fd33e8f    4510826f 4f03bd9b     303a23b6   680cec1c
    ## 487 2018-07-01        672c6b72    72b45765 4046ee34     9a47575c   f7dfc635
    ## 488 2018-01-01        672c6b72    72b45765 4046ee34     9a47575c   f7dfc635
    ## 489 2018-04-01        672c6b72    72b45765 4046ee34     9a47575c   bc8e06ed
    ## 490 2018-02-01        672c6b72    72b45765 4046ee34     9a47575c   2e812869
    ## 491 2018-06-01        672c6b72    72b45765 4046ee34     9a47575c   2e812869
    ## 492 2018-06-01        672c6b72    72b45765 4046ee34     9a47575c   a9e783db
    ## 493 2018-07-01        a986ce60    d2cc3f9c 4f03bd9b     303a23b6   7a861731
    ## 494 2018-06-01        a986ce60    d2cc3f9c 4f03bd9b     303a23b6   b20448cf
    ## 495 2019-11-01        ecbbcd21    4c646efb 4046ee34     9a47575c   bc8e06ed
    ## 496 2018-12-01        26439f6e    44010ac1 4f03bd9b     303a23b6   23e9d55d
    ## 497 2019-05-01        e5422a31    5b38b381 4f03bd9b     303a23b6   72520ba2
    ## 498 2019-05-01        e5422a31    5b38b381 4f03bd9b     303a23b6   8682908b
    ## 499 2019-12-01        672c6b72    72b45765 4046ee34     9a47575c   f7dfc635
    ## 500 2019-12-01        672c6b72    72b45765 4046ee34     9a47575c   f7dfc635
    ## 501 2019-03-01        672c6b72    72b45765 4046ee34     9a47575c   f7dfc635
    ## 502 2019-11-01        672c6b72    72b45765 4046ee34     9a47575c   b50e91fb
    ## 503 2018-04-01        5144aff8    269521bb 4046ee34     9a47575c   77192d63
    ## 504 2018-03-01        ef757e78    b8996578 4046ee34     9a47575c   69c1b705
    ## 505 2018-10-01        ef757e78    b8996578 4046ee34     9a47575c   9fdcc550
    ## 506 2019-08-01        ef757e78    b8996578 4046ee34     9a47575c   69c1b705
    ## 507 2019-09-01        4d1f394c    e6cb0090 4f03bd9b     303a23b6   0c169a3b
    ## 508 2019-10-01        a986ce60    d2cc3f9c 4f03bd9b     303a23b6   67696f68
    ## 509 2019-04-01        a986ce60    d2cc3f9c 4f03bd9b     303a23b6   c57e6d42
    ## 510 2018-05-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   69c1b705
    ## 511 2018-06-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   77192d63
    ## 512 2019-02-01        98724eee    9242a5f2 4f03bd9b     303a23b6   e49916a2
    ## 513 2020-02-01        e5422a31    5b38b381 4f03bd9b     303a23b6   c57e6d42
    ## 514 2018-12-01        5144aff8    269521bb 4046ee34     9a47575c   2e812869
    ## 515 2018-10-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   45c0376d
    ## 516 2019-09-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   69c1b705
    ## 517 2019-10-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   69c1b705
    ## 518 2019-09-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   f7dfc635
    ## 519 2019-05-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   f7dfc635
    ## 520 2019-12-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   f7dfc635
    ## 521 2019-08-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   77192d63
    ## 522 2019-05-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   1d407777
    ## 523 2019-02-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   1d407777
    ## 524 2019-08-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   1d407777
    ## 525 2019-01-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   abfa1d4e
    ## 526 2019-11-01        95f5d00b    48bb2dcb 4046ee34     5d7fff27   0dd30fcd
    ## 527 2018-07-01        672c6b72    72b45765 4f03bd9b     303a23b6   23e9d55d
    ## 528 2018-05-01        672c6b72    72b45765 4f03bd9b     303a23b6   2e4c5a7c
    ## 529 2019-06-01        5a3ab3b2    d6eccd15 4046ee34     9a47575c   9fdcc550
    ## 530 2019-05-01        6712bde0    eb75cfbe 4f03bd9b     303a23b6   72520ba2
    ## 531 2020-02-01        5a3ab3b2    d6eccd15 4046ee34     9a47575c   f7dfc635
    ## 532 2018-05-01        6712bde0    eb75cfbe 4046ee34     9a47575c   f7dfc635
    ## 533 2020-02-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   0dd30fcd
    ## 534 2020-01-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   abfa1d4e
    ## 535 2020-01-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   a9e783db
    ## 536 2018-10-01        672c6b72    72b45765 4f03bd9b     303a23b6   72520ba2
    ## 537 2018-12-01        672c6b72    72b45765 4f03bd9b     303a23b6   91e7e31b
    ## 538 2019-05-01        672c6b72    72b45765 4f03bd9b     303a23b6   7a861731
    ## 539 2020-01-01        672c6b72    72b45765 4f03bd9b     303a23b6   8f79b7f8
    ## 540 2020-02-01        672c6b72    72b45765 4f03bd9b     303a23b6   0c169a3b
    ## 541 2019-06-01        ecbbcd21    4c646efb 4f03bd9b     303a23b6   7a861731
    ## 542 2018-03-01        d14961dd    d1402308 4046ee34     9a47575c   69c1b705
    ## 543 2018-11-01        d14961dd    d1402308 4046ee34     9a47575c   f7dfc635
    ## 544 2018-10-01        d14961dd    d1402308 4046ee34     9a47575c   f7dfc635
    ## 545 2018-11-01        d14961dd    d1402308 4046ee34     9a47575c   f7dfc635
    ## 546 2018-11-01        d14961dd    d1402308 4046ee34     9a47575c   f7dfc635
    ## 547 2018-04-01        d14961dd    d1402308 4046ee34     9a47575c   f7dfc635
    ## 548 2018-09-01        d14961dd    d1402308 4046ee34     9a47575c   f7dfc635
    ## 549 2018-08-01        d14961dd    d1402308 4046ee34     9a47575c   bc8e06ed
    ## 550 2018-10-01        d14961dd    d1402308 4046ee34     9a47575c   2e812869
    ## 551 2018-08-01        d14961dd    d1402308 4046ee34     9a47575c   67e9cc18
    ## 552 2018-10-01        d14961dd    d1402308 4046ee34     9a47575c   67e9cc18
    ## 553 2018-11-01        d14961dd    d1402308 4046ee34     9a47575c   77192d63
    ## 554 2018-06-01        d14961dd    d1402308 4046ee34     9a47575c   77192d63
    ## 555 2018-03-01        d14961dd    d1402308 4046ee34     9a47575c   b50e91fb
    ## 556 2019-11-01        d14961dd    d1402308 4046ee34     9a47575c   f7dfc635
    ## 557 2019-10-01        d14961dd    d1402308 4046ee34     9a47575c   bc8e06ed
    ## 558 2019-10-01        d14961dd    d1402308 4046ee34     9a47575c   2e812869
    ## 559 2019-09-01        d14961dd    d1402308 4046ee34     9a47575c   2e812869
    ## 560 2019-11-01        d14961dd    d1402308 4046ee34     9a47575c   67e9cc18
    ## 561 2019-09-01        d14961dd    d1402308 4046ee34     9a47575c   77192d63
    ## 562 2019-05-01        d14961dd    d1402308 4046ee34     9a47575c   77192d63
    ## 563 2019-02-01        d14961dd    d1402308 4046ee34     9a47575c   77192d63
    ## 564 2019-10-01        d14961dd    d1402308 4046ee34     9a47575c   b50e91fb
    ## 565 2019-08-01        d14961dd    d1402308 4046ee34     9a47575c   1d407777
    ## 566 2019-10-01        d14961dd    d1402308 4046ee34     9a47575c   1d407777
    ## 567 2019-12-01        d14961dd    d1402308 4046ee34     9a47575c   abfa1d4e
    ## 568 2019-11-01        d14961dd    d1402308 4046ee34     9a47575c   a9e783db
    ## 569 2019-05-01        d14961dd    d1402308 4046ee34     5d7fff27   77192d63
    ## 570 2020-01-01        d14961dd    d1402308 4046ee34     9a47575c   f7dfc635
    ## 571 2020-01-01        d14961dd    d1402308 4046ee34     9a47575c   67e9cc18
    ## 572 2018-04-01        c84dfe42    f6353791 4046ee34     9a47575c   f7dfc635
    ## 573 2018-04-01        c84dfe42    f6353791 4046ee34     9a47575c   1d407777
    ## 574 2019-01-01        c84dfe42    f6353791 4046ee34     9a47575c   f7dfc635
    ## 575 2019-11-01        c84dfe42    f6353791 4046ee34     9a47575c   f7dfc635
    ## 576 2019-12-01        c84dfe42    f6353791 4046ee34     9a47575c   bc8e06ed
    ## 577 2019-09-01        c84dfe42    f6353791 4046ee34     9a47575c   67e9cc18
    ## 578 2018-08-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 579 2018-10-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 580 2018-09-01        84d54ea3    6df8322f 4046ee34     9a47575c   f7dfc635
    ## 581 2018-09-01        84d54ea3    6df8322f 4046ee34     9a47575c   bc8e06ed
    ## 582 2019-04-01        f4bfba2c    f0e3e1a0 4046ee34     9a47575c   2e812869
    ## 583 2018-01-01        4cad15c2    fade7200 4046ee34     9a47575c   f7dfc635
    ## 584 2018-09-01        4cad15c2    fade7200 4046ee34     9a47575c   f7dfc635
    ## 585 2018-06-01        4cad15c2    fade7200 4046ee34     9a47575c   abfa1d4e
    ## 586 2018-01-01        4cad15c2    fade7200 4046ee34     9a47575c   9fdcc550
    ## 587 2018-12-01        df07e07a    832abf99 4046ee34     9a47575c   69c1b705
    ## 588 2019-03-01        4cad15c2    fade7200 4046ee34     9a47575c   f7dfc635
    ## 589 2019-01-01        4cad15c2    fade7200 4046ee34     9a47575c   77192d63
    ## 590 2019-11-01        df07e07a    832abf99 4046ee34     9a47575c   f7dfc635
    ## 591 2019-12-01        df07e07a    832abf99 4046ee34     9a47575c   bc8e06ed
    ## 592 2019-03-01        df07e07a    832abf99 4046ee34     9a47575c   2e812869
    ## 593 2019-08-01        df07e07a    832abf99 4f03bd9b     303a23b6   9043b930
    ## 594 2018-08-01        e5422a31    5b38b381 4f03bd9b     303a23b6   8f79b7f8
    ## 595 2018-08-01        e5422a31    5b38b381 4f03bd9b     303a23b6   0c169a3b
    ## 596 2018-01-01        e5422a31    5b38b381 4f03bd9b     303a23b6   bf1e94e9
    ## 597 2018-08-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   7a861731
    ## 598 2018-05-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   bcdf2ef9
    ## 599 2018-07-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 600 2018-03-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 601 2018-01-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 602 2018-08-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 603 2018-03-01        38cf993d    9e26bae4 4046ee34     9a47575c   77192d63
    ## 604 2018-04-01        38cf993d    9e26bae4 4046ee34     9a47575c   77192d63
    ## 605 2018-03-01        38cf993d    9e26bae4 4046ee34     9a47575c   77192d63
    ## 606 2018-02-01        199d17cf    788df831 4046ee34     9a47575c   f7dfc635
    ## 607 2018-03-01        199d17cf    788df831 4046ee34     9a47575c   f7dfc635
    ## 608 2018-10-01        5144aff8    269521bb 4f03bd9b     303a23b6   f97a3f33
    ## 609 2019-03-01        5144aff8    269521bb 4f03bd9b     303a23b6   3cae948b
    ## 610 2019-04-01        5144aff8    269521bb 4f03bd9b     303a23b6   8682908b
    ## 611 2019-03-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   b97335a1
    ## 612 2019-10-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   54969a29
    ## 613 2019-07-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   3153c73e
    ## 614 2019-06-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   3153c73e
    ## 615 2019-04-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   0c169a3b
    ## 616 2018-12-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 617 2019-09-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 618 2019-02-01        38cf993d    9e26bae4 4046ee34     9a47575c   2e812869
    ## 619 2019-07-01        38cf993d    9e26bae4 4046ee34     9a47575c   67e9cc18
    ## 620 2019-11-01        38cf993d    9e26bae4 4046ee34     9a47575c   77192d63
    ## 621 2020-02-01        38cf993d    9e26bae4 4046ee34     9a47575c   bc8e06ed
    ## 622 2020-02-01        38cf993d    9e26bae4 4046ee34     9a47575c   77192d63
    ## 623 2020-01-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   b97335a1
    ## 624 2020-01-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   7b674f31
    ## 625 2018-10-01        199d17cf    788df831 4046ee34     9a47575c   f7dfc635
    ## 626 2019-07-01        199d17cf    788df831 4046ee34     9a47575c   69c1b705
    ## 627 2019-12-01        199d17cf    788df831 4046ee34     9a47575c   f7dfc635
    ## 628 2019-05-01        199d17cf    788df831 4046ee34     9a47575c   b50e91fb
    ## 629 2020-01-01        199d17cf    788df831 4046ee34     9a47575c   f7dfc635
    ## 630 2018-02-01        ef757e78    b8996578 4046ee34     9a47575c   69c1b705
    ## 631 2018-05-01        ef757e78    b8996578 4046ee34     9a47575c   bc8e06ed
    ## 632 2019-02-01        ef757e78    b8996578 4046ee34     9a47575c   f7dfc635
    ## 633 2019-11-01        ef757e78    b8996578 4046ee34     9a47575c   f7dfc635
    ## 634 2019-02-01        e5422a31    5b38b381 4046ee34     9a47575c   f7dfc635
    ## 635 2018-12-01        ef757e78    b8996578 4f03bd9b     303a23b6   75298f79
    ## 636 2019-01-01        ef757e78    b8996578 4f03bd9b     303a23b6   a0d39798
    ## 637 2018-07-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   4ca9988b
    ## 638 2018-07-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   8f79b7f8
    ## 639 2018-06-01        96498cde    87403f6f 4046ee34     9a47575c   69c1b705
    ## 640 2018-08-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 641 2018-03-01        96498cde    87403f6f 4046ee34     9a47575c   67e9cc18
    ## 642 2018-07-01        96498cde    87403f6f 4046ee34     9a47575c   67e9cc18
    ## 643 2018-02-01        e404386c    55a163a6 4046ee34     9a47575c   69c1b705
    ## 644 2018-03-01        e404386c    55a163a6 4046ee34     9a47575c   69c1b705
    ## 645 2018-02-01        e404386c    55a163a6 4046ee34     9a47575c   f7dfc635
    ## 646 2018-04-01        e404386c    55a163a6 4046ee34     9a47575c   f7dfc635
    ## 647 2018-02-01        e404386c    55a163a6 4046ee34     9a47575c   f7dfc635
    ## 648 2018-01-01        e404386c    55a163a6 4046ee34     9a47575c   f7dfc635
    ## 649 2018-04-01        e404386c    55a163a6 4046ee34     9a47575c   f7dfc635
    ## 650 2018-02-01        e404386c    55a163a6 4046ee34     9a47575c   f7dfc635
    ## 651 2018-03-01        e404386c    55a163a6 4046ee34     9a47575c   2e812869
    ## 652 2018-03-01        e404386c    55a163a6 4046ee34     9a47575c   67e9cc18
    ## 653 2018-03-01        e404386c    55a163a6 4046ee34     9a47575c   67e9cc18
    ## 654 2018-03-01        e404386c    55a163a6 4046ee34     9a47575c   77192d63
    ## 655 2018-04-01        e404386c    55a163a6 4046ee34     9a47575c   77192d63
    ## 656 2018-04-01        e404386c    55a163a6 4046ee34     9a47575c   b50e91fb
    ## 657 2018-03-01        e404386c    55a163a6 4046ee34     9a47575c   1d407777
    ## 658 2018-01-01        e404386c    55a163a6 4046ee34     9a47575c   1d407777
    ## 659 2018-04-01        e404386c    55a163a6 4046ee34     9a47575c   abfa1d4e
    ## 660 2018-03-01        e404386c    55a163a6 4046ee34     9a47575c   4814799f
    ## 661 2018-02-01        e404386c    55a163a6 4046ee34     9a47575c   a9e783db
    ## 662 2018-10-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   8f79b7f8
    ## 663 2019-09-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   72520ba2
    ## 664 2019-11-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   fed6647d
    ## 665 2019-10-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   e49916a2
    ## 666 2019-06-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   e49916a2
    ## 667 2020-02-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   c57e6d42
    ## 668 2019-03-01        f5136def    1fdb2332 4f03bd9b     303a23b6   72520ba2
    ## 669 2019-09-01        f5136def    1fdb2332 4f03bd9b     303a23b6   c57e6d42
    ## 670 2019-07-01        199d17cf    788df831 4f03bd9b     303a23b6   72520ba2
    ## 671 2019-01-01        199d17cf    788df831 4f03bd9b     303a23b6   d7254672
    ## 672 2019-01-01        199d17cf    788df831 4f03bd9b     303a23b6   9d9f2da6
    ## 673 2018-12-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 674 2018-09-01        96498cde    87403f6f 4046ee34     9a47575c   1d407777
    ## 675 2019-12-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 676 2019-02-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 677 2019-05-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 678 2019-03-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 679 2019-12-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 680 2019-03-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 681 2019-11-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 682 2019-02-01        96498cde    87403f6f 4046ee34     9a47575c   bc8e06ed
    ## 683 2019-05-01        96498cde    87403f6f 4046ee34     9a47575c   67e9cc18
    ## 684 2019-06-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 685 2019-08-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 686 2019-07-01        96498cde    87403f6f 4046ee34     9a47575c   1d407777
    ## 687 2020-02-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 688 2020-02-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 689 2020-02-01        96498cde    87403f6f 4046ee34     9a47575c   1d407777
    ## 690 2020-01-01        96498cde    87403f6f 4046ee34     9a47575c   abfa1d4e
    ## 691 2019-05-01        6712bde0    eb75cfbe 4046ee34     9a47575c   77192d63
    ## 692 2019-06-01        c84dfe42    f6353791 4f03bd9b     303a23b6   72520ba2
    ## 693 2019-05-01        c84dfe42    f6353791 4f03bd9b     303a23b6   72520ba2
    ## 694 2019-11-01        c84dfe42    f6353791 4f03bd9b     303a23b6   fed6647d
    ## 695 2019-11-01        c84dfe42    f6353791 4f03bd9b     303a23b6   fed6647d
    ## 696 2019-09-01        c84dfe42    f6353791 4f03bd9b     303a23b6   0c169a3b
    ## 697 2019-05-01        8fd33e8f    4510826f 4f03bd9b     303a23b6   8f79b7f8
    ## 698 2020-01-01        5a3ab3b2    d6eccd15 4046ee34     9a47575c   f7dfc635
    ## 699 2018-07-01        a986ce60    d2cc3f9c 4f03bd9b     303a23b6   a0d39798
    ## 700 2018-05-01        98724eee    9242a5f2 4046ee34     9a47575c   77192d63
    ## 701 2018-03-01        5144aff8    269521bb 4046ee34     9a47575c   2e812869
    ## 702 2018-06-01        2e61839e    5945cfbb 4f03bd9b     303a23b6   72520ba2
    ## 703 2019-03-01        a986ce60    d2cc3f9c 4f03bd9b     303a23b6   c57e6d42
    ## 704 2019-04-01        5144aff8    269521bb 4046ee34     9a47575c   bc8e06ed
    ## 705 2019-07-01        5144aff8    269521bb 4046ee34     9a47575c   77192d63
    ## 706 2019-04-01        df07e07a    832abf99 4046ee34     9a47575c   f7dfc635
    ## 707 2019-08-01        df07e07a    832abf99 4046ee34     9a47575c   77192d63
    ## 708 2019-08-01        df07e07a    832abf99 4046ee34     9a47575c   9fdcc550
    ## 709 2018-04-01        26439f6e    44010ac1 4046ee34     9a47575c   0dd30fcd
    ## 710 2018-10-01        6712bde0    eb75cfbe 4f03bd9b     303a23b6   a0d39798
    ## 711 2018-05-01        ef757e78    b8996578 4046ee34     9a47575c   67e9cc18
    ## 712 2018-12-01        ef757e78    b8996578 4046ee34     9a47575c   77192d63
    ## 713 2020-02-01        ef757e78    b8996578 4046ee34     9a47575c   1d407777
    ## 714 2019-05-01        26439f6e    44010ac1 4046ee34     9a47575c   69c1b705
    ## 715 2019-07-01        26439f6e    44010ac1 4046ee34     5d7fff27   67e9cc18
    ## 716 2018-05-01        96498cde    87403f6f 4f03bd9b     303a23b6   bcdf2ef9
    ## 717 2018-04-01        96498cde    87403f6f 4f03bd9b     303a23b6   e49916a2
    ## 718 2018-06-01        96498cde    87403f6f 4f03bd9b     303a23b6   1c81fb6c
    ## 719 2018-02-01        4cad15c2    fade7200 4046ee34     9a47575c   bc8e06ed
    ## 720 2019-04-01        4cad15c2    fade7200 4046ee34     9a47575c   2e812869
    ## 721 2020-01-01        6712bde0    eb75cfbe 4f03bd9b     303a23b6   7a27b27e
    ## 722 2018-07-01        26439f6e    44010ac1 4f03bd9b     303a23b6   e49916a2
    ## 723 2018-03-01        672c6b72    72b45765 4046ee34     9a47575c   f7dfc635
    ## 724 2018-10-01        26439f6e    44010ac1 4f03bd9b     303a23b6   f97a3f33
    ## 725 2019-08-01        26439f6e    44010ac1 4f03bd9b     303a23b6   e49916a2
    ## 726 2019-04-01        26439f6e    44010ac1 4f03bd9b     303a23b6   8682908b
    ## 727 2018-10-01        96498cde    87403f6f 4f03bd9b     303a23b6   c31adb2f
    ## 728 2018-12-01        96498cde    87403f6f 4f03bd9b     303a23b6   8f79b7f8
    ## 729 2019-03-01        96498cde    87403f6f 4f03bd9b     303a23b6   b97335a1
    ## 730 2019-12-01        96498cde    87403f6f 4f03bd9b     303a23b6   75298f79
    ## 731 2019-11-01        96498cde    87403f6f 4f03bd9b     303a23b6   fed6647d
    ## 732 2019-12-01        96498cde    87403f6f 4f03bd9b     303a23b6   4ca9988b
    ## 733 2019-02-01        96498cde    87403f6f 4f03bd9b     303a23b6   a0d39798
    ## 734 2019-07-01        672c6b72    72b45765 4046ee34     9a47575c   67e9cc18
    ## 735 2019-03-01        672c6b72    72b45765 4046ee34     9a47575c   77192d63
    ## 736 2019-01-01        f4bfba2c    f0e3e1a0 4046ee34     9a47575c   f7dfc635
    ## 737 2020-01-01        96498cde    87403f6f 4f03bd9b     303a23b6   a0d39798
    ## 738 2020-01-01        96498cde    87403f6f 4f03bd9b     303a23b6   8f79b7f8
    ## 739 2020-01-01        96498cde    87403f6f 4f03bd9b     303a23b6   1c81fb6c
    ## 740 2018-02-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   bc8e06ed
    ## 741 2018-12-01        ef757e78    b8996578 4f03bd9b     303a23b6   3cae948b
    ## 742 2019-07-01        ef757e78    b8996578 4f03bd9b     303a23b6   72520ba2
    ## 743 2018-10-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   77192d63
    ## 744 2019-11-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   77192d63
    ## 745 2019-05-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   77192d63
    ## 746 2019-10-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   77192d63
    ## 747 2019-11-01        95f5d00b    48bb2dcb 4046ee34     5d7fff27   bc8e06ed
    ## 748 2019-03-01        672c6b72    72b45765 4f03bd9b     303a23b6   67696f68
    ## 749 2018-08-01        df07e07a    832abf99 4f03bd9b     303a23b6   75298f79
    ## 750 2020-02-01        df07e07a    832abf99 4046ee34     9a47575c   77192d63
    ## 751 2019-09-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   7a861731
    ## 752 2018-02-01        c84dfe42    f6353791 4046ee34     9a47575c   67e9cc18
    ## 753 2019-02-01        199d17cf    788df831 4f03bd9b     303a23b6   4ca9988b
    ## 754 2019-09-01        84d54ea3    6df8322f 4046ee34     9a47575c   4814799f
    ## 755 2019-01-01        4cad15c2    fade7200 4046ee34     9a47575c   f7dfc635
    ## 756 2019-03-01        4cad15c2    fade7200 4046ee34     9a47575c   77192d63
    ## 757 2018-08-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 758 2018-03-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 759 2018-06-01        38cf993d    9e26bae4 4046ee34     9a47575c   2e812869
    ## 760 2018-10-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   b97335a1
    ## 761 2018-09-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 762 2019-11-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 763 2019-02-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 764 2019-07-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 765 2019-12-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 766 2019-02-01        38cf993d    9e26bae4 4046ee34     9a47575c   b50e91fb
    ## 767 2019-02-01        4d1f394c    e6cb0090 4f03bd9b     303a23b6   e49916a2
    ## 768 2018-05-01        96498cde    87403f6f 4046ee34     9a47575c   69c1b705
    ## 769 2018-05-01        96498cde    87403f6f 4046ee34     9a47575c   bc8e06ed
    ## 770 2018-09-01        26439f6e    44010ac1 4046ee34     9a47575c   f7dfc635
    ## 771 2019-01-01        26439f6e    44010ac1 4046ee34     9a47575c   b50e91fb
    ## 772 2018-11-01        96498cde    87403f6f 4046ee34     9a47575c   bc8e06ed
    ## 773 2018-11-01        96498cde    87403f6f 4046ee34     9a47575c   1d407777
    ## 774 2019-02-01        96498cde    87403f6f 4046ee34     9a47575c   69c1b705
    ## 775 2019-08-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 776 2019-02-01        96498cde    87403f6f 4046ee34     9a47575c   bc8e06ed
    ## 777 2019-10-01        96498cde    87403f6f 4046ee34     9a47575c   bc8e06ed
    ## 778 2019-03-01        96498cde    87403f6f 4046ee34     9a47575c   77192d63
    ## 779 2019-05-01        c84dfe42    f6353791 4f03bd9b     303a23b6   b97335a1
    ## 780 2019-11-01        c84dfe42    f6353791 4f03bd9b     303a23b6   fed6647d
    ## 781 2019-06-01        c84dfe42    f6353791 4f03bd9b     303a23b6   a0d39798
    ## 782 2018-03-01        199d17cf    788df831 4046ee34     9a47575c   f7dfc635
    ## 783 2020-01-01        c84dfe42    f6353791 4f03bd9b     303a23b6   b97335a1
    ## 784 2019-11-01        5144aff8    269521bb 4f03bd9b     303a23b6   fed6647d
    ## 785 2018-01-01        98724eee    9242a5f2 4046ee34     9a47575c   f7dfc635
    ## 786 2018-04-01        98724eee    9242a5f2 4f03bd9b     303a23b6   0bbe6418
    ## 787 2019-02-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   1d407777
    ## 788 2020-02-01        5a3ab3b2    d6eccd15 4046ee34     9a47575c   4814799f
    ## 789 2019-12-01        d14961dd    d1402308 4046ee34     9a47575c   f7dfc635
    ## 790 2019-09-01        d14961dd    d1402308 4046ee34     9a47575c   1d407777
    ## 791 2018-05-01        96498cde    87403f6f 4f03bd9b     303a23b6   b97335a1
    ## 792 2020-01-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   72520ba2
    ## 793 2019-03-01        c84dfe42    f6353791 4046ee34     9a47575c   1d407777
    ## 794 2019-03-01        96498cde    87403f6f 4f03bd9b     303a23b6   72520ba2
    ## 795 2020-01-01        96498cde    87403f6f 4f03bd9b     303a23b6   72520ba2
    ## 796 2020-02-01        96498cde    87403f6f 4f03bd9b     303a23b6   c57e6d42
    ## 797 2018-03-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 798 2018-11-01        26439f6e    44010ac1 4046ee34     9a47575c   45c0376d
    ## 799 2018-12-01        26439f6e    44010ac1 4046ee34     9a47575c   f7dfc635
    ## 800 2019-04-01        5144aff8    269521bb 4f03bd9b     303a23b6   7b674f31
    ## 801 2019-12-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 802 2018-03-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 803 2018-02-01        e404386c    55a163a6 4046ee34     9a47575c   77192d63
    ## 804 2018-11-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 805 2018-10-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 806 2018-07-01        95f5d00b    48bb2dcb 4046ee34     9a47575c   a9e783db
    ## 807 2019-02-01        4d1f394c    e6cb0090 4f03bd9b     303a23b6   d43e8f6a
    ## 808 2018-05-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   75298f79
    ## 809 2019-01-01        96498cde    87403f6f 4f03bd9b     303a23b6   72520ba2
    ## 810 2019-11-01        96498cde    87403f6f 4f03bd9b     303a23b6   fed6647d
    ## 811 2019-01-01        96498cde    87403f6f 4f03bd9b     303a23b6   0ef0ce97
    ## 812 2019-02-01        96498cde    87403f6f 4f03bd9b     303a23b6   8f79b7f8
    ## 813 2019-09-01        5144aff8    269521bb 4046ee34     9a47575c   9fdcc550
    ## 814 2018-06-01        96498cde    87403f6f 4046ee34     9a47575c   f7dfc635
    ## 815 2019-04-01        672c6b72    72b45765 4f03bd9b     303a23b6   8f79b7f8
    ## 816 2018-10-01        d14961dd    d1402308 4046ee34     9a47575c   1d407777
    ## 817 2019-03-01        d14961dd    d1402308 4046ee34     9a47575c   f7dfc635
    ## 818 2019-03-01        d14961dd    d1402308 4046ee34     9a47575c   f7dfc635
    ## 819 2019-12-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   6eff1266
    ## 820 2018-12-01        98724eee    9242a5f2 4f03bd9b     303a23b6   75298f79
    ## 821 2018-04-01        5144aff8    269521bb 4046ee34     9a47575c   1d407777
    ## 822 2018-07-01        38cf993d    9e26bae4 4046ee34     9a47575c   f7dfc635
    ## 823 2018-12-01        95f5d00b    48bb2dcb 4f03bd9b     303a23b6   3cae948b
    ## 824 2019-09-01        df07e07a    832abf99 4f03bd9b     303a23b6   c57e6d42
    ## 825 2019-01-01        ecbbcd21    4c646efb 4f03bd9b     303a23b6   72520ba2
    ## 826 2018-01-01        e404386c    55a163a6 4046ee34     9a47575c   f7dfc635
    ## 827 2019-12-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   72520ba2
    ## 828 2018-01-01        f4bfba2c    f0e3e1a0 4046ee34     9a47575c   f7dfc635
    ## 829 2020-01-01        6712bde0    eb75cfbe 4f03bd9b     303a23b6   4856cd94
    ## 830 2019-08-01        98724eee    9242a5f2 4046ee34     9a47575c   69c1b705
    ## 831 2018-10-01        8c6f625a    1d8c3c4f 4f03bd9b     303a23b6   68de9759
    ## 832 2019-04-01        26439f6e    44010ac1 4046ee34     9a47575c   f7dfc635
    ## 833 2020-01-01        6712bde0    eb75cfbe 4f03bd9b     303a23b6   a0d39798
    ## 834 2020-01-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   a0d39798
    ## 835 2019-10-01        ef757e78    b8996578 4f03bd9b     303a23b6   a0d39798
    ## 836 2018-10-01        96498cde    87403f6f 4f03bd9b     303a23b6   72520ba2
    ## 837 2018-04-01        e404386c    55a163a6 4046ee34     9a47575c   69c1b705
    ## 838 2019-05-01        d14961dd    d1402308 4046ee34     9a47575c   67e9cc18
    ## 839 2019-09-01        38cf993d    9e26bae4 4f03bd9b     303a23b6   a0d39798
    ## 840 2018-06-01        c84dfe42    f6353791 4f03bd9b     303a23b6   75298f79
    ## 841 2019-01-01        5a3ab3b2    d6eccd15 4f03bd9b     303a23b6   75298f79
    ## 842 2018-07-01        2e61839e    5945cfbb 4f03bd9b     303a23b6   8f79b7f8
    ## 843 2019-12-01        df07e07a    832abf99 4f03bd9b     303a23b6   72520ba2
    ##      Cliente    Marca Canal Venta Unidades plaza   Venta
    ## 1   a2fcd814 290f7be8    7b48292e             -3  -26.40
    ## 2   b8ac96ba 290f7be8    7b48292e             -3  -26.40
    ## 3   ed5760e9 61d7fbfc    7b48292e             -2  -26.50
    ## 4   90bfe7cd 61d7fbfc    7b48292e             -2  -26.50
    ## 5   ba287dd0 61d7fbfc    7b48292e             -2  -26.50
    ## 6   b1ab3946 61d7fbfc    7b48292e             -2  -26.50
    ## 7   1ce75ec8 61d7fbfc    7b48292e             -2  -26.50
    ## 8   f3f0db29 ae586f97    7b48292e             -3  -26.55
    ## 9   658aceb3 ae586f97    7b48292e             -3  -26.55
    ## 10  2ac0d6f7 ae586f97    7b48292e             -3  -26.55
    ## 11  cb9f662a 9d4f7970    7b48292e             -2  -26.56
    ## 12  53ac2d5a 9d4f7970    7b48292e             -2  -26.56
    ## 13  93faea3b 9d4f7970    7b48292e             -2  -26.56
    ## 14  1c3687a0 9d4f7970    7b48292e             -2  -26.56
    ## 15  286f3d5f 9d4f7970    7b48292e             -2  -26.56
    ## 16  720b2678 9d4f7970    7b48292e             -2  -26.56
    ## 17  cb9f662a 9d4f7970    7b48292e             -2  -26.56
    ## 18  519e6880 9d4f7970    b105050f             -3  -26.82
    ## 19  23bd6aa2 7248f8f4    7b48292e             -1  -27.18
    ## 20  9754f8ad 7248f8f4    7b48292e             -1  -27.18
    ## 21  ffe1e6a7 7248f8f4    7b48292e             -1  -27.18
    ## 22  5b71aed9 7248f8f4    7b48292e             -1  -27.18
    ## 23  92bc602a 7248f8f4    7b48292e             -1  -27.18
    ## 24  95c47eda 7248f8f4    7b48292e             -1  -27.18
    ## 25  2eb39d9c 9d4f7970    7b48292e             -2  -27.22
    ## 26  3999cac6 ae586f97    7b48292e             -3  -27.45
    ## 27  e7192721 ae586f97    7b48292e             -3  -27.45
    ## 28  e7192721 ae586f97    7b48292e             -3  -27.45
    ## 29  ac473003 ae586f97    7b48292e             -3  -27.45
    ## 30  d0f1eea9 ae586f97    7b48292e             -3  -27.45
    ## 31  a0c04be3 ae586f97    7b48292e             -4  -27.64
    ## 32  519e6880 ae586f97    b105050f             -4  -27.64
    ## 33  8b7482ce 7248f8f4    7b48292e             -1  -27.73
    ## 34  9dc4be40 7248f8f4    7b48292e             -1  -27.73
    ## 35  a188633f 7248f8f4    7b48292e             -1  -27.73
    ## 36  071e53fc 7248f8f4    7b48292e             -1  -27.73
    ## 37  5cf2e47e 7248f8f4    7b48292e             -1  -27.73
    ## 38  65c44129 7248f8f4    7b48292e             -1  -27.73
    ## 39  fbb61763 7248f8f4    7b48292e             -1  -27.73
    ## 40  40bb25df 7248f8f4    7b48292e             -1  -27.73
    ## 41  5a4369ed 7248f8f4    7b48292e             -1  -27.73
    ## 42  9aca8977 7248f8f4    7b48292e             -1  -27.73
    ## 43  c4159da0 7248f8f4    7b48292e             -1  -27.73
    ## 44  93211a16 7248f8f4    7b48292e             -1  -27.73
    ## 45  7865283c 1b29f7b5    7b48292e             -5  -27.80
    ## 46  962692ff 1b29f7b5    7b48292e             -5  -27.80
    ## 47  9d6e1d65 a1939cf8    7b48292e             -2  -27.88
    ## 48  80f7acb7 a1939cf8    7b48292e             -2  -27.88
    ## 49  071e53fc a1939cf8    7b48292e             -2  -27.88
    ## 50  ff122c3f a1939cf8    7b48292e             -2  -27.88
    ## 51  cbf338e5 a1939cf8    7b48292e             -2  -27.88
    ## 52  b1ab3946 a1939cf8    7b48292e             -2  -27.88
    ## 53  638b073f a1939cf8    7b48292e             -2  -27.88
    ## 54  f965f7f4 a1939cf8    7b48292e             -2  -27.88
    ## 55  5a4369ed a1939cf8    7b48292e             -2  -27.88
    ## 56  a7b07104 a1939cf8    7b48292e             -2  -27.88
    ## 57  c7e5af02 a1939cf8    7b48292e             -2  -27.88
    ## 58  31953405 a1939cf8    7b48292e             -2  -27.88
    ## 59  7381d447 a1939cf8    7b48292e             -2  -27.88
    ## 60  fbe9839a a1939cf8    7b48292e             -2  -27.88
    ## 61  6fe2c368 a1939cf8    7b48292e             -2  -27.88
    ## 62  9928ab1a a1939cf8    7b48292e             -2  -27.88
    ## 63  ff122c3f a1939cf8    7b48292e             -2  -27.88
    ## 64  cb245c63 a1939cf8    7b48292e             -2  -27.88
    ## 65  186d240d a1939cf8    7b48292e             -2  -27.88
    ## 66  3f4c9f0e a1939cf8    7b48292e             -2  -27.88
    ## 67  5a4369ed a1939cf8    7b48292e             -2  -27.88
    ## 68  e4160a51 a1939cf8    7b48292e             -2  -27.88
    ## 69  98bd39be a1939cf8    7b48292e             -2  -27.88
    ## 70  d823a435 a1939cf8    7b48292e             -2  -27.88
    ## 71  3a5bb9cf 7248f8f4    7b48292e             -1  -28.15
    ## 72  d3491a94 7f5f1a17    7b48292e             -2  -28.30
    ## 73  29bb8e1e 7f5f1a17    7b48292e             -2  -28.30
    ## 74  0eb8732b 7f5f1a17    7b48292e             -2  -28.30
    ## 75  1cba9413 7f5f1a17    7b48292e             -2  -28.30
    ## 76  3f23cf9d 7f5f1a17    7b48292e             -2  -28.30
    ## 77  1a84eaac 7f5f1a17    7b48292e             -2  -28.30
    ## 78  606b693b 7f5f1a17    7b48292e             -2  -28.30
    ## 79  1ede8859 7f5f1a17    7b48292e             -2  -28.30
    ## 80  a17a7558 7f5f1a17    7b48292e             -2  -28.30
    ## 81  ad6db95b 7f5f1a17    7b48292e             -2  -28.30
    ## 82  7565c08c 7f5f1a17    7b48292e             -2  -28.30
    ## 83  bd4e56e4 7f5f1a17    7b48292e             -2  -28.30
    ## 84  f5417faf 7f5f1a17    7b48292e             -2  -28.30
    ## 85  ac473003 7f5f1a17    7b48292e             -2  -28.30
    ## 86  d3f88e19 7f5f1a17    7b48292e             -2  -28.30
    ## 87  69db5224 7f5f1a17    7b48292e             -2  -28.30
    ## 88  011806a5 7f5f1a17    7b48292e             -2  -28.30
    ## 89  2c925ef8 7f5f1a17    7b48292e             -2  -28.30
    ## 90  b8bc2e9b 7f5f1a17    7b48292e             -2  -28.30
    ## 91  606b693b 7f5f1a17    7b48292e             -2  -28.30
    ## 92  e7192721 7f5f1a17    7b48292e             -2  -28.30
    ## 93  d4dbbcc4 7f5f1a17    7b48292e             -2  -28.30
    ## 94  ec7bae8e 7f5f1a17    7b48292e             -2  -28.30
    ## 95  c4159da0 7f5f1a17    7b48292e             -2  -28.30
    ## 96  253fa060 7f5f1a17    7b48292e             -2  -28.30
    ## 97  2e61b7da 7f5f1a17    7b48292e             -2  -28.30
    ## 98  963a6b1c ae586f97    7b48292e             -3  -28.35
    ## 99  53ac2d5a ae586f97    7b48292e             -3  -28.35
    ## 100 a2fcd814 c1a7fe7f    7b48292e             -1  -28.52
    ## 101 7320e5ea c1a7fe7f    7b48292e             -1  -28.52
    ## 102 11605b87 c1a7fe7f    7b48292e             -1  -28.52
    ## 103 6b6f3697 c1a7fe7f    7b48292e             -1  -28.52
    ## 104 6a06394f c1a7fe7f    7b48292e             -1  -28.52
    ## 105 e5a04228 f1a48f8b    7b48292e             -1  -28.91
    ## 106 9e46df10 f1a48f8b    7b48292e             -1  -28.91
    ## 107 70f31c7b f1a48f8b    7b48292e             -1  -28.91
    ## 108 433d296a f1a48f8b    7b48292e             -1  -28.91
    ## 109 ce5bf212 f1a48f8b    7b48292e             -1  -28.91
    ## 110 8b7482ce f1a48f8b    7b48292e             -1  -28.91
    ## 111 b8cd29f7 f1a48f8b    7b48292e             -1  -28.91
    ## 112 c40e2889 f1a48f8b    7b48292e             -1  -28.91
    ## 113 36d491a3 f1a48f8b    7b48292e             -1  -28.91
    ## 114 d4ec2589 f1a48f8b    7b48292e             -1  -28.91
    ## 115 03ca20cd f1a48f8b    7b48292e             -1  -28.91
    ## 116 5f0feb85 f1a48f8b    7b48292e             -1  -28.91
    ## 117 c5aa15df f1a48f8b    7b48292e             -1  -28.91
    ## 118 c5aa15df f1a48f8b    7b48292e             -1  -28.91
    ## 119 a17a7558 f1a48f8b    7b48292e             -1  -28.91
    ## 120 97d124d2 f1a48f8b    7b48292e             -1  -28.91
    ## 121 31953405 f1a48f8b    7b48292e             -1  -28.91
    ## 122 7381d447 f1a48f8b    7b48292e             -1  -28.91
    ## 123 d0f1eea9 f1a48f8b    7b48292e             -1  -28.91
    ## 124 26712b6e c1a7fe7f    7b48292e             -1  -29.40
    ## 125 53104973 c1a7fe7f    7b48292e             -1  -29.40
    ## 126 f8a59a6b c1a7fe7f    7b48292e             -1  -29.40
    ## 127 926caaf6 c1a7fe7f    7b48292e             -1  -29.40
    ## 128 e1d1f5f7 c1a7fe7f    7b48292e             -1  -29.40
    ## 129 e2b0b9fe c1a7fe7f    7b48292e             -1  -29.40
    ## 130 aa7f4ee3 c1a7fe7f    7b48292e             -1  -29.40
    ## 131 f6e6ba91 c1a7fe7f    7b48292e             -1  -29.40
    ## 132 6614bc38 c1a7fe7f    7b48292e             -1  -29.40
    ## 133 7fa6ecae c1a7fe7f    7b48292e             -1  -29.40
    ## 134 61e50b27 c1a7fe7f    7b48292e             -1  -29.40
    ## 135 745ed546 c1a7fe7f    7b48292e             -1  -29.40
    ## 136 b8e4aab8 f1a48f8b    7b48292e             -1  -29.50
    ## 137 d3491a94 f1a48f8b    7b48292e             -1  -29.50
    ## 138 fbb61763 f1a48f8b    7b48292e             -1  -29.50
    ## 139 39ded95b f1a48f8b    7b48292e             -1  -29.50
    ## 140 f965f7f4 f1a48f8b    7b48292e             -1  -29.50
    ## 141 b8e4aab8 f1a48f8b    7b48292e             -1  -29.50
    ## 142 ff122c3f f1a48f8b    7b48292e             -1  -29.50
    ## 143 afd256c5 f1a48f8b    7b48292e             -1  -29.50
    ## 144 d3491a94 f1a48f8b    7b48292e             -1  -29.50
    ## 145 9e5be0f3 f1a48f8b    7b48292e             -1  -29.50
    ## 146 186d240d f1a48f8b    7b48292e             -1  -29.50
    ## 147 fbb61763 f1a48f8b    7b48292e             -1  -29.50
    ## 148 39ded95b f1a48f8b    7b48292e             -1  -29.50
    ## 149 6761cabf f1a48f8b    7b48292e             -1  -29.50
    ## 150 36d491a3 f1a48f8b    7b48292e             -1  -29.50
    ## 151 f8ecb55c f1a48f8b    7b48292e             -1  -29.50
    ## 152 f6a860c8 f1a48f8b    7b48292e             -1  -29.50
    ## 153 f965f7f4 f1a48f8b    7b48292e             -1  -29.50
    ## 154 c5aa15df f1a48f8b    7b48292e             -1  -29.50
    ## 155 e7192721 f1a48f8b    7b48292e             -1  -29.50
    ## 156 b3164e9e f1a48f8b    7b48292e             -1  -29.50
    ## 157 ebd791b3 f1a48f8b    7b48292e             -1  -29.50
    ## 158 b927b1c8 ae586f97    7b48292e             -6  -29.76
    ## 159 5544cef3 c1a7fe7f    7b48292e             -1  -29.84
    ## 160 8a11d40d ae586f97    7b48292e             -3  -29.85
    ## 161 9612f7fb ae586f97    7b48292e             -3  -29.85
    ## 162 6b6f3697 ae586f97    7b48292e             -3  -29.85
    ## 163 72e3da56 7f5f1a17    7b48292e             -3  -29.91
    ## 164 39ded95b 7f5f1a17    7b48292e             -3  -29.91
    ## 165 a2e93d26 7f5f1a17    7b48292e             -3  -29.91
    ## 166 1b32bce4 7f5f1a17    7b48292e             -3  -29.91
    ## 167 36d491a3 7f5f1a17    7b48292e             -3  -29.91
    ## 168 24f16ade 7f5f1a17    7b48292e             -3  -29.91
    ## 169 a1bdbfc6 7f5f1a17    7b48292e             -3  -29.91
    ## 170 87384e75 7f5f1a17    7b48292e             -3  -29.91
    ## 171 9d6e1d65 7f5f1a17    7b48292e             -3  -29.91
    ## 172 02437006 7f5f1a17    7b48292e             -3  -29.91
    ## 173 b8e4aab8 7f5f1a17    7b48292e             -3  -29.91
    ## 174 c2b80747 7f5f1a17    7b48292e             -3  -29.91
    ## 175 3f23cf9d 7f5f1a17    7b48292e             -3  -29.91
    ## 176 b3eb4aab 7f5f1a17    7b48292e             -3  -29.91
    ## 177 ec87fff1 7f5f1a17    7b48292e             -3  -29.91
    ## 178 8d617f7d 7f5f1a17    7b48292e             -3  -29.91
    ## 179 cd2eecfd 7f5f1a17    7b48292e             -3  -29.91
    ## 180 19bc520d ae586f97    7b48292e             -3  -30.24
    ## 181 7fc68163 7f5f1a17    7b48292e             -4  -30.32
    ## 182 4734bd78 7f5f1a17    7b48292e             -4  -30.32
    ## 183 e664c3e9 7f5f1a17    7b48292e             -4  -30.32
    ## 184 ba287dd0 ae586f97    7b48292e             -5  -30.50
    ## 185 edcad2e9 f1a48f8b    7b48292e             -1  -30.55
    ## 186 6e1ad398 f1a48f8b    7b48292e             -1  -30.55
    ## 187 a0c04be3 f1a48f8b    7b48292e             -1  -30.55
    ## 188 80f7acb7 c1a7fe7f    7b48292e             -1  -30.82
    ## 189 69b30902 c1a7fe7f    7b48292e             -1  -30.82
    ## 190 b304f89a c1a7fe7f    7b48292e             -1  -30.82
    ## 191 5cf2e47e c1a7fe7f    7b48292e             -1  -30.82
    ## 192 2bacb133 c1a7fe7f    7b48292e             -1  -30.82
    ## 193 31feb883 c1a7fe7f    7b48292e             -1  -30.82
    ## 194 ce5bf212 c1a7fe7f    7b48292e             -1  -30.82
    ## 195 fbb61763 c1a7fe7f    7b48292e             -1  -30.82
    ## 196 03042773 c1a7fe7f    7b48292e             -1  -30.82
    ## 197 6b35d3b0 c1a7fe7f    7b48292e             -1  -30.82
    ## 198 1b32bce4 c1a7fe7f    7b48292e             -1  -30.82
    ## 199 7746499e c1a7fe7f    7b48292e             -1  -30.82
    ## 200 9aca8977 c1a7fe7f    7b48292e             -1  -30.82
    ## 201 1685d326 c1a7fe7f    7b48292e             -1  -30.82
    ## 202 f965f7f4 c1a7fe7f    7b48292e             -1  -30.82
    ## 203 802aa60e c1a7fe7f    7b48292e             -1  -30.82
    ## 204 1ede8859 c1a7fe7f    7b48292e             -1  -30.82
    ## 205 23408f12 c1a7fe7f    7b48292e             -1  -30.82
    ## 206 1ce75ec8 c1a7fe7f    7b48292e             -1  -30.82
    ## 207 707d9b49 c1a7fe7f    7b48292e             -1  -30.82
    ## 208 e7192721 c1a7fe7f    7b48292e             -1  -30.82
    ## 209 c2de5aa0 c1a7fe7f    7b48292e             -1  -30.82
    ## 210 ad6db95b c1a7fe7f    7b48292e             -1  -30.82
    ## 211 59d18b96 c1a7fe7f    7b48292e             -1  -30.82
    ## 212 b122872e c1a7fe7f    7b48292e             -1  -30.82
    ## 213 eea42cd0 c1a7fe7f    7b48292e             -1  -30.82
    ## 214 92bc602a c1a7fe7f    7b48292e             -1  -30.82
    ## 215 d0f1eea9 c1a7fe7f    7b48292e             -1  -30.82
    ## 216 1e86e903 c1a7fe7f    7b48292e             -1  -30.82
    ## 217 b304f89a ae586f97    7b48292e             -3  -30.84
    ## 218 f6e6ba91 f1a48f8b    7b48292e             -1  -30.85
    ## 219 f6e6ba91 f1a48f8b    7b48292e             -1  -30.85
    ## 220 4a32ff3b f1a48f8b    7b48292e             -1  -30.85
    ## 221 8a11d40d f1a48f8b    7b48292e             -1  -30.85
    ## 222 f0f3dbf1 f1a48f8b    7b48292e             -1  -30.85
    ## 223 edcad2e9 f1a48f8b    7b48292e             -1  -30.85
    ## 224 e3495cbc f1a48f8b    7b48292e             -1  -30.85
    ## 225 af267306 f1a48f8b    7b48292e             -1  -30.85
    ## 226 072f410b f1a48f8b    7b48292e             -1  -30.85
    ## 227 09c918d8 f1a48f8b    7b48292e             -1  -30.85
    ## 228 4734bd78 f1a48f8b    7b48292e             -1  -30.85
    ## 229 8a11d40d f1a48f8b    7b48292e             -1  -30.85
    ## 230 4e6d5d8c f1a48f8b    7b48292e             -1  -30.85
    ## 231 a0c04be3 f1a48f8b    7b48292e             -1  -30.85
    ## 232 1ce28b36 f1a48f8b    7b48292e             -1  -30.85
    ## 233 186d240d ae586f97    7b48292e             -6  -31.32
    ## 234 59ffbfee ae586f97    7b48292e             -6  -31.32
    ## 235 b8e4aab8 c1a7fe7f    7b48292e             -1  -31.44
    ## 236 eab6d5e4 c1a7fe7f    7b48292e             -1  -31.44
    ## 237 0ce1d18a c1a7fe7f    7b48292e             -1  -31.44
    ## 238 36d491a3 c1a7fe7f    7b48292e             -1  -31.44
    ## 239 1685d326 c1a7fe7f    7b48292e             -1  -31.44
    ## 240 c5aa15df c1a7fe7f    7b48292e             -1  -31.44
    ## 241 4328477f c1a7fe7f    7b48292e             -1  -31.44
    ## 242 c7e5af02 c1a7fe7f    7b48292e             -1  -31.44
    ## 243 31953405 c1a7fe7f    7b48292e             -1  -31.44
    ## 244 f5e41919 c1a7fe7f    7b48292e             -1  -31.44
    ## 245 3c31e312 c1a7fe7f    7b48292e             -1  -31.44
    ## 246 c07d228c c1a7fe7f    7b48292e             -1  -31.44
    ## 247 5c36d69b 7248f8f4    7b48292e             -1  -31.44
    ## 248 4faa5e2a 7248f8f4    7b48292e             -1  -31.44
    ## 249 aa7f4ee3 7248f8f4    7b48292e             -1  -31.44
    ## 250 6f306b92 7248f8f4    7b48292e             -1  -31.44
    ## 251 a2fcd814 7248f8f4    7b48292e             -1  -31.44
    ## 252 e75e5d78 7248f8f4    7b48292e             -1  -31.44
    ## 253 fd4d673a 7248f8f4    7b48292e             -1  -31.44
    ## 254 dd0d7f4d 7248f8f4    7b48292e             -1  -31.44
    ## 255 ba287dd0 c1a7fe7f    7b48292e             -1  -31.44
    ## 256 8bd6fe44 c1a7fe7f    7b48292e             -1  -31.44
    ## 257 0f50d35d c1a7fe7f    7b48292e             -1  -31.44
    ## 258 071e53fc c1a7fe7f    7b48292e             -1  -31.44
    ## 259 fc126ed6 c1a7fe7f    7b48292e             -1  -31.44
    ## 260 b304f89a c1a7fe7f    7b48292e             -1  -31.44
    ## 261 0f80ec52 c1a7fe7f    7b48292e             -1  -31.44
    ## 262 2bacb133 c1a7fe7f    7b48292e             -1  -31.44
    ## 263 9e46df10 c1a7fe7f    7b48292e             -1  -31.44
    ## 264 65c44129 c1a7fe7f    7b48292e             -1  -31.44
    ## 265 65c44129 c1a7fe7f    7b48292e             -1  -31.44
    ## 266 be9b5f9e c1a7fe7f    7b48292e             -1  -31.44
    ## 267 b3164e9e c1a7fe7f    7b48292e             -1  -31.44
    ## 268 c2b80747 c1a7fe7f    7b48292e             -1  -31.44
    ## 269 011806a5 c1a7fe7f    7b48292e             -1  -31.44
    ## 270 b1ab3946 c1a7fe7f    7b48292e             -1  -31.44
    ## 271 6761cabf c1a7fe7f    7b48292e             -1  -31.44
    ## 272 c5eb23a9 c1a7fe7f    7b48292e             -1  -31.44
    ## 273 493495cc c1a7fe7f    7b48292e             -1  -31.44
    ## 274 3b0600f4 c1a7fe7f    7b48292e             -1  -31.44
    ## 275 f55f3c6d c1a7fe7f    7b48292e             -1  -31.44
    ## 276 f8686386 c1a7fe7f    7b48292e             -1  -31.44
    ## 277 253fa060 c1a7fe7f    7b48292e             -1  -31.44
    ## 278 23408f12 c1a7fe7f    7b48292e             -1  -31.44
    ## 279 87384e75 c1a7fe7f    7b48292e             -1  -31.44
    ## 280 73754c63 c1a7fe7f    7b48292e             -1  -31.44
    ## 281 73754c63 c1a7fe7f    7b48292e             -1  -31.44
    ## 282 d4dbbcc4 c1a7fe7f    7b48292e             -1  -31.44
    ## 283 f18903f1 c1a7fe7f    7b48292e             -1  -31.44
    ## 284 3c31e312 c1a7fe7f    7b48292e             -1  -31.44
    ## 285 2e61b7da c1a7fe7f    7b48292e             -1  -31.44
    ## 286 7381d447 c1a7fe7f    7b48292e             -1  -31.44
    ## 287 19bc520d c1a7fe7f    7b48292e             -1  -31.44
    ## 288 6fe2c368 c1a7fe7f    7b48292e             -1  -31.44
    ## 289 3bc8cdb9 c1a7fe7f    7b48292e             -1  -31.44
    ## 290 2166d929 c1a7fe7f    7b48292e             -1  -31.44
    ## 291 6a4ea037 1b29f7b5    7b48292e             -7  -31.78
    ## 292 6a4ea037 1b29f7b5    7b48292e             -7  -31.78
    ## 293 31feb883 c1a7fe7f    7b48292e             -1  -31.91
    ## 294 f55f3c6d c1a7fe7f    7b48292e             -1  -31.91
    ## 295 4d4967dd c1a7fe7f    7b48292e             -1  -31.91
    ## 296 9295897e c1a7fe7f    7b48292e             -1  -31.91
    ## 297 8c68f1c1 c1a7fe7f    7b48292e             -1  -31.91
    ## 298 2e61b7da c1a7fe7f    7b48292e             -1  -31.91
    ## 299 1bcba4a2 7248f8f4    7b48292e             -1  -32.07
    ## 300 d54f3800 7248f8f4    7b48292e             -1  -32.07
    ## 301 9dd09adb 7248f8f4    7b48292e             -1  -32.07
    ## 302 926caaf6 7248f8f4    7b48292e             -1  -32.07
    ## 303 e75e5d78 7248f8f4    7b48292e             -1  -32.07
    ## 304 54d1d5a9 7248f8f4    7b48292e             -1  -32.07
    ## 305 f6e6ba91 7248f8f4    7b48292e             -1  -32.07
    ## 306 aa02e742 7248f8f4    7b48292e             -1  -32.07
    ## 307 f018a706 ae586f97    7b48292e             -5  -32.10
    ## 308 8db5da41 ae586f97    7b48292e             -4  -32.28
    ## 309 1ce28b36 ae586f97    7b48292e             -4  -32.28
    ## 310 cfd6c82f 7248f8f4    7b48292e             -1  -32.55
    ## 311 a2fcd814 290f7be8    7b48292e             -2  -32.56
    ## 312 7fa6ecae 290f7be8    7b48292e             -2  -32.56
    ## 313 3154091e 9d4f7970    7b48292e             -4  -32.56
    ## 314 f6a860c8 7f5f1a17    7b48292e             -3  -32.82
    ## 315 253fa060 7f5f1a17    7b48292e             -3  -32.82
    ## 316 c9f18aa2 7f5f1a17    7b48292e             -3  -32.82
    ## 317 b8e4aab8 7f5f1a17    7b48292e             -3  -32.82
    ## 318 186e9004 7f5f1a17    7b48292e             -3  -32.82
    ## 319 98bd39be 7f5f1a17    7b48292e             -3  -32.82
    ## 320 36d491a3 7f5f1a17    7b48292e             -3  -32.82
    ## 321 af8f2652 7f5f1a17    7b48292e             -3  -32.82
    ## 322 4e01178f ae586f97    7b48292e             -4  -32.92
    ## 323 53ac2d5a ae586f97    7b48292e             -4  -33.00
    ## 324 4e6d5d8c 61d7fbfc    7b48292e             -3  -33.24
    ## 325 fdb015cc 1b29f7b5    7b48292e             -6  -33.36
    ## 326 9c9f1bf3 9d4f7970    7b48292e             -4  -33.36
    ## 327 37c64d32 290f7be8    7b48292e             -2  -33.56
    ## 328 e7fb7e09 290f7be8    7b48292e             -2  -33.56
    ## 329 0dc28aa5 7f5f1a17    7b48292e             -4  -33.76
    ## 330 011806a5 7248f8f4    7b48292e             -2  -33.90
    ## 331 ba287dd0 9d4f7970    7b48292e             -3  -33.96
    ## 332 9e5be0f3 9d4f7970    7b48292e             -3  -33.96
    ## 333 f55f3c6d 9d4f7970    7b48292e             -3  -33.96
    ## 334 28367441 9d4f7970    7b48292e             -3  -33.96
    ## 335 fbb61763 9d4f7970    7b48292e             -3  -33.96
    ## 336 39ded95b 9d4f7970    7b48292e             -3  -33.96
    ## 337 7746499e 9d4f7970    7b48292e             -3  -33.96
    ## 338 59d18b96 9d4f7970    7b48292e             -3  -33.96
    ## 339 4022c901 9d4f7970    7b48292e             -3  -33.96
    ## 340 072f410b 9d4f7970    7b48292e             -3  -33.96
    ## 341 27363c44 9d4f7970    7b48292e             -3  -33.96
    ## 342 8933a1a9 9d4f7970    7b48292e             -3  -33.96
    ## 343 c40e2889 9d4f7970    7b48292e             -3  -33.96
    ## 344 d048e01b 9d4f7970    7b48292e             -3  -33.96
    ## 345 19c9e075 9d4f7970    7b48292e             -3  -33.96
    ## 346 963a6b1c 9d4f7970    7b48292e             -3  -33.96
    ## 347 54d1d5a9 9d4f7970    7b48292e             -3  -33.96
    ## 348 4734bd78 ae586f97    7b48292e             -5  -34.55
    ## 349 af267306 ae586f97    7b48292e             -4  -34.72
    ## 350 5ee9bf94 9d4f7970    7b48292e             -4  -34.88
    ## 351 f8a59a6b ae586f97    7b48292e             -5  -35.25
    ## 352 26712b6e c1a7fe7f    7b48292e             -1  -35.32
    ## 353 53104973 c1a7fe7f    7b48292e             -1  -35.32
    ## 354 8a11d40d c1a7fe7f    7b48292e             -1  -35.32
    ## 355 d5b13e70 c1a7fe7f    7b48292e             -1  -35.32
    ## 356 bc1496b4 c1a7fe7f    7b48292e             -1  -35.32
    ## 357 d35b418c c1a7fe7f    7b48292e             -1  -35.32
    ## 358 a17a7558 c1a7fe7f    7b48292e             -1  -35.32
    ## 359 a17a7558 c1a7fe7f    7b48292e             -1  -35.32
    ## 360 7320e5ea c1a7fe7f    7b48292e             -1  -35.32
    ## 361 9d64ea34 c1a7fe7f    7b48292e             -1  -35.32
    ## 362 bdd850e4 c1a7fe7f    7b48292e             -1  -35.32
    ## 363 8c2d0441 c1a7fe7f    7b48292e             -1  -35.32
    ## 364 eb9f6514 c1a7fe7f    7b48292e             -1  -35.32
    ## 365 3fa89d7e c1a7fe7f    7b48292e             -1  -35.32
    ## 366 11605b87 c1a7fe7f    7b48292e             -1  -35.32
    ## 367 11605b87 c1a7fe7f    7b48292e             -1  -35.32
    ## 368 b50f409a 7f5f1a17    7b48292e             -3  -35.40
    ## 369 7cef9c82 ae586f97    7b48292e             -4  -35.40
    ## 370 6f4cabe3 290f7be8    7b48292e             -4  -36.28
    ## 371 ff122c3f ae586f97    7b48292e             -4  -36.60
    ## 372 5c36d69b c1a7fe7f    7b48292e             -1  -37.18
    ## 373 fdb015cc c1a7fe7f    7b48292e             -1  -37.18
    ## 374 1a407421 c1a7fe7f    7b48292e             -1  -37.18
    ## 375 1353f878 c1a7fe7f    7b48292e             -1  -37.18
    ## 376 93730e73 c1a7fe7f    7b48292e             -1  -37.18
    ## 377 f6e6ba91 c1a7fe7f    7b48292e             -1  -37.18
    ## 378 58c41f38 c1a7fe7f    7b48292e             -1  -37.18
    ## 379 4734bd78 c1a7fe7f    7b48292e             -1  -37.18
    ## 380 a17a7558 c1a7fe7f    7b48292e             -1  -37.18
    ## 381 d4af4086 c1a7fe7f    7b48292e             -1  -37.18
    ## 382 af267306 c1a7fe7f    7b48292e             -1  -37.18
    ## 383 95156ab1 c1a7fe7f    7b48292e             -1  -37.18
    ## 384 658aceb3 c1a7fe7f    7b48292e             -1  -37.18
    ## 385 603e4c2b c1a7fe7f    7b48292e             -1  -37.18
    ## 386 a20f03e0 c1a7fe7f    7b48292e             -1  -37.18
    ## 387 81318a55 c1a7fe7f    7b48292e             -1  -37.18
    ## 388 4e6d5d8c c1a7fe7f    7b48292e             -1  -37.18
    ## 389 a0c04be3 c1a7fe7f    7b48292e             -1  -37.18
    ## 390 09c918d8 c1a7fe7f    7b48292e             -1  -37.18
    ## 391 1227bdb1 c1a7fe7f    b105050f             -1  -37.18
    ## 392 1ce28b36 c1a7fe7f    7b48292e             -1  -37.18
    ## 393 f6e6ba91 c1a7fe7f    7b48292e             -1  -37.18
    ## 394 11605b87 c1a7fe7f    7b48292e             -1  -37.18
    ## 395 30690360 c1a7fe7f    7b48292e             -1  -37.18
    ## 396 5afb35f4 c1a7fe7f    7b48292e             -1  -37.18
    ## 397 ce5bf212 a1939cf8    7b48292e             -2  -37.72
    ## 398 b25c4f7e a1939cf8    7b48292e             -2  -37.72
    ## 399 87384e75 a1939cf8    7b48292e             -2  -37.72
    ## 400 eab6d5e4 a1939cf8    7b48292e             -2  -37.72
    ## 401 d4dbbcc4 a1939cf8    7b48292e             -2  -37.72
    ## 402 4d5e8599 a1939cf8    7b48292e             -2  -37.72
    ## 403 5c36d69b c1a7fe7f    7b48292e             -1  -37.74
    ## 404 8a11d40d c1a7fe7f    7b48292e             -1  -37.74
    ## 405 d4af4086 c1a7fe7f    7b48292e             -1  -37.74
    ## 406 a0c04be3 c1a7fe7f    7b48292e             -1  -37.74
    ## 407 dd0d7f4d c1a7fe7f    7b48292e             -1  -37.74
    ## 408 f88739aa 7f5f1a17    7b48292e             -5  -37.90
    ## 409 9bee0ab5 ae586f97    7b48292e             -6  -38.52
    ## 410 b304f89a f1a48f8b    7b48292e             -2  -39.02
    ## 411 e5a04228 f1a48f8b    7b48292e             -2  -39.02
    ## 412 24f16ade f1a48f8b    7b48292e             -2  -39.02
    ## 413 69db5224 f1a48f8b    7b48292e             -2  -39.02
    ## 414 c4e44b70 9d4f7970    7b48292e             -3  -39.06
    ## 415 55dc3af8 9d4f7970    7b48292e             -3  -39.06
    ## 416 02437006 9d4f7970    7b48292e             -3  -39.06
    ## 417 869b6b18 9d4f7970    7b48292e             -3  -39.06
    ## 418 d3f88e19 9d4f7970    7b48292e             -3  -39.06
    ## 419 b7c7d05b 9d4f7970    7b48292e             -3  -39.06
    ## 420 12b6d81a 9d4f7970    7b48292e             -3  -39.06
    ## 421 92bc602a 9d4f7970    7b48292e             -3  -39.06
    ## 422 b927b1c8 61d7fbfc    7b48292e             -3  -39.75
    ## 423 d589ccf9 61d7fbfc    7b48292e             -3  -39.75
    ## 424 53ac2d5a ae586f97    7b48292e             -4  -39.80
    ## 425 39ded95b f1a48f8b    7b48292e             -2  -39.82
    ## 426 1cba9413 f1a48f8b    7b48292e             -2  -39.82
    ## 427 c0444612 f1a48f8b    7b48292e             -2  -39.82
    ## 428 ffe1e6a7 f1a48f8b    7b48292e             -2  -39.82
    ## 429 463527fd 9d4f7970    7b48292e             -3  -39.84
    ## 430 852405e9 9d4f7970    7b48292e             -3  -39.84
    ## 431 b304f89a 7f5f1a17    7b48292e             -4  -39.88
    ## 432 f8ecb55c 7f5f1a17    7b48292e             -4  -39.88
    ## 433 c5aa15df 7f5f1a17    7b48292e             -4  -39.88
    ## 434 a17a7558 7f5f1a17    7b48292e             -4  -39.88
    ## 435 315578e7 7f5f1a17    7b48292e             -4  -39.88
    ## 436 1ede8859 7f5f1a17    7b48292e             -4  -39.88
    ## 437 be9b5f9e 7f5f1a17    7b48292e             -4  -39.88
    ## 438 d4ec2589 ae586f97    7b48292e             -5  -40.85
    ## 439 a5beb78c 7f5f1a17    7b48292e             -5  -41.15
    ## 440 f88739aa f1a48f8b    7b48292e             -2  -41.34
    ## 441 603e4c2b ae586f97    7b48292e             -6  -41.46
    ## 442 e1d1f5f7 ae586f97    7b48292e             -6  -41.46
    ## 443 4734bd78 f1a48f8b    7b48292e             -2  -41.74
    ## 444 68ebb73f a1939cf8    7b48292e             -3  -41.82
    ## 445 9754f8ad a1939cf8    7b48292e             -3  -41.82
    ## 446 2c925ef8 a1939cf8    7b48292e             -3  -41.82
    ## 447 3c8252c1 a1939cf8    7b48292e             -3  -41.82
    ## 448 27cf6695 a1939cf8    7b48292e             -3  -41.82
    ## 449 f018a706 a1939cf8    7b48292e             -3  -41.82
    ## 450 af8f2652 a1939cf8    7b48292e             -3  -41.82
    ## 451 73a0cf73 a1939cf8    7b48292e             -3  -41.82
    ## 452 ac473003 a1939cf8    7b48292e             -3  -41.82
    ## 453 433d296a a1939cf8    7b48292e             -3  -41.82
    ## 454 493495cc a1939cf8    7b48292e             -3  -41.82
    ## 455 b654df79 a1939cf8    7b48292e             -3  -41.82
    ## 456 e5274642 a1939cf8    7b48292e             -3  -41.82
    ## 457 e7192721 a1939cf8    7b48292e             -3  -41.82
    ## 458 15a5ce0b a1939cf8    7b48292e             -3  -41.82
    ## 459 4022c901 a1939cf8    7b48292e             -3  -41.82
    ## 460 148eba2b 7f5f1a17    7b48292e             -3  -42.45
    ## 461 c0444612 7f5f1a17    7b48292e             -3  -42.45
    ## 462 87384e75 7f5f1a17    7b48292e             -3  -42.45
    ## 463 e7192721 7f5f1a17    7b48292e             -3  -42.45
    ## 464 c9f18aa2 7f5f1a17    7b48292e             -3  -42.45
    ## 465 cb245c63 7f5f1a17    7b48292e             -3  -42.45
    ## 466 40dcd7c2 7f5f1a17    7b48292e             -3  -42.45
    ## 467 c0444612 7f5f1a17    7b48292e             -3  -42.45
    ## 468 aef3888e ae586f97    7b48292e             -5  -43.40
    ## 469 39ded95b 7f5f1a17    7b48292e             -4  -43.76
    ## 470 19bc520d 7f5f1a17    7b48292e             -4  -43.76
    ## 471 2529cc9d 9d4f7970    7b48292e             -4  -45.28
    ## 472 044118d4 9d4f7970    7b48292e             -4  -45.28
    ## 473 2bacb133 9d4f7970    7b48292e             -4  -45.28
    ## 474 39ded95b 9d4f7970    7b48292e             -4  -45.28
    ## 475 53ac2d5a 290f7be8    7b48292e             -5  -45.35
    ## 476 852405e9 1b29f7b5    7b48292e            -10  -45.40
    ## 477 d337a280 1b29f7b5    7b48292e            -10  -45.40
    ## 478 9f0cf752 7f5f1a17    7b48292e             -6  -45.48
    ## 479 03ca20cd 7248f8f4    7b48292e             -2  -45.68
    ## 480 53ac2d5a ae586f97    7b48292e             -6  -46.02
    ## 481 c2b80747 7248f8f4    7b48292e             -2  -46.62
    ## 482 53980269 7248f8f4    7b48292e             -2  -46.62
    ## 483 9e949f82 ae586f97    7b48292e             -5  -47.90
    ## 484 debfde55 7248f8f4    7b48292e             -2  -48.02
    ## 485 df9eb2d8 7248f8f4    7b48292e             -2  -48.02
    ## 486 4734bd78 ae586f97    7b48292e             -6  -48.42
    ## 487 ff122c3f f1a48f8b    7b48292e             -2  -48.82
    ## 488 b69b8683 f1a48f8b    7b48292e             -2  -48.82
    ## 489 ebd791b3 f1a48f8b    7b48292e             -2  -48.82
    ## 490 f965f7f4 f1a48f8b    7b48292e             -2  -48.82
    ## 491 c5aa15df f1a48f8b    7b48292e             -2  -48.82
    ## 492 19bc520d f1a48f8b    7b48292e             -2  -48.82
    ## 493 7fa6ecae 290f7be8    7b48292e             -3  -48.84
    ## 494 2e2cb897 290f7be8    7b48292e             -3  -48.84
    ## 495 0748c5ee 9d4f7970    7b48292e             -6  -48.84
    ## 496 44e3c548 7248f8f4    7b48292e             -2  -49.00
    ## 497 93730e73 ae586f97    7b48292e             -5  -49.75
    ## 498 9f0cf752 ae586f97    7b48292e             -5  -49.75
    ## 499 ff122c3f f1a48f8b    7b48292e             -2  -49.82
    ## 500 8b7482ce f1a48f8b    7b48292e             -2  -49.82
    ## 501 c40e2889 f1a48f8b    7b48292e             -2  -49.82
    ## 502 15ae9778 f1a48f8b    7b48292e             -2  -49.82
    ## 503 92fb290f 7248f8f4    7b48292e             -3  -49.83
    ## 504 9d6e1d65 7f5f1a17    7b48292e             -5  -49.85
    ## 505 69db5224 7f5f1a17    7b48292e             -5  -49.85
    ## 506 ba287dd0 7f5f1a17    7b48292e             -5  -49.85
    ## 507 36769217 1b29f7b5    b105050f            -11  -49.94
    ## 508 f6e6ba91 290f7be8    7b48292e             -3  -50.34
    ## 509 519e6880 290f7be8    b105050f             -3  -50.34
    ## 510 72e3da56 c1a7fe7f    7b48292e             -2  -50.36
    ## 511 a7b07104 c1a7fe7f    7b48292e             -2  -50.36
    ## 512 e7fb7e09 7f5f1a17    7b48292e             -6  -50.64
    ## 513 30690360 ae586f97    7b48292e             -5  -50.75
    ## 514 253fa060 7248f8f4    7b48292e             -3  -50.85
    ## 515 23bd6aa2 c1a7fe7f    7b48292e             -2  -51.38
    ## 516 0b7a3837 c1a7fe7f    7b48292e             -2  -51.38
    ## 517 6a1ff1fd c1a7fe7f    7b48292e             -2  -51.38
    ## 518 69b30902 c1a7fe7f    7b48292e             -2  -51.38
    ## 519 b1ab3946 c1a7fe7f    7b48292e             -2  -51.38
    ## 520 0ce1d18a c1a7fe7f    7b48292e             -2  -51.38
    ## 521 ad6db95b c1a7fe7f    7b48292e             -2  -51.38
    ## 522 36205e94 c1a7fe7f    7b48292e             -2  -51.38
    ## 523 bd4e56e4 c1a7fe7f    7b48292e             -2  -51.38
    ## 524 4ef484c9 c1a7fe7f    7b48292e             -2  -51.38
    ## 525 0fea7b4c c1a7fe7f    7b48292e             -2  -51.38
    ## 526 828e9645 c1a7fe7f    7b48292e             -2  -51.38
    ## 527 f88739aa f1a48f8b    7b48292e             -2  -51.66
    ## 528 4a985a53 f1a48f8b    7b48292e             -2  -51.66
    ## 529 d9996d49 9d4f7970    7b48292e             -4  -52.08
    ## 530 8a11d40d ae586f97    7b48292e             -6  -52.08
    ## 531 39ded95b 9d4f7970    7b48292e             -4  -52.08
    ## 532 cbf338e5 ae586f97    7b48292e             -6  -52.14
    ## 533 8cbcdb74 c1a7fe7f    7b48292e             -2  -52.16
    ## 534 457b5289 c1a7fe7f    7b48292e             -2  -52.16
    ## 535 19bc520d c1a7fe7f    7b48292e             -2  -52.16
    ## 536 fc086e6b f1a48f8b    7b48292e             -2  -52.18
    ## 537 2c23c992 f1a48f8b    7b48292e             -2  -52.18
    ## 538 bdd850e4 f1a48f8b    7b48292e             -2  -52.18
    ## 539 4e6d5d8c f1a48f8b    7b48292e             -2  -52.18
    ## 540 69570338 f1a48f8b    7b48292e             -2  -52.18
    ## 541 7fa6ecae 9d4f7970    7b48292e             -6  -52.32
    ## 542 b8e4aab8 a1939cf8    7b48292e             -1  -52.44
    ## 543 ff122c3f a1939cf8    7b48292e             -1  -52.44
    ## 544 fc126ed6 a1939cf8    7b48292e             -1  -52.44
    ## 545 b304f89a a1939cf8    7b48292e             -1  -52.44
    ## 546 fbb61763 a1939cf8    7b48292e             -1  -52.44
    ## 547 03042773 a1939cf8    7b48292e             -1  -52.44
    ## 548 194b2a34 a1939cf8    7b48292e             -1  -52.44
    ## 549 33b28700 a1939cf8    7b48292e             -1  -52.44
    ## 550 c5aa15df a1939cf8    7b48292e             -1  -52.44
    ## 551 0c6a5d27 a1939cf8    7b48292e             -1  -52.44
    ## 552 e5274642 a1939cf8    7b48292e             -1  -52.44
    ## 553 9bee0ab5 a1939cf8    7b48292e             -1  -52.44
    ## 554 ec7bae8e a1939cf8    7b48292e             -1  -52.44
    ## 555 f5e41919 a1939cf8    7b48292e             -1  -52.44
    ## 556 3f4c9f0e a1939cf8    7b48292e             -1  -52.44
    ## 557 36d491a3 a1939cf8    7b48292e             -1  -52.44
    ## 558 ffe1e6a7 a1939cf8    7b48292e             -1  -52.44
    ## 559 b25c4f7e a1939cf8    7b48292e             -1  -52.44
    ## 560 0d81674a a1939cf8    7b48292e             -1  -52.44
    ## 561 87384e75 a1939cf8    7b48292e             -1  -52.44
    ## 562 d4dbbcc4 a1939cf8    7b48292e             -1  -52.44
    ## 563 d4dbbcc4 a1939cf8    7b48292e             -1  -52.44
    ## 564 59d18b96 a1939cf8    7b48292e             -1  -52.44
    ## 565 418b1590 a1939cf8    7b48292e             -1  -52.44
    ## 566 c07d228c a1939cf8    7b48292e             -1  -52.44
    ## 567 90bfe7cd a1939cf8    7b48292e             -1  -52.44
    ## 568 d0f1eea9 a1939cf8    7b48292e             -1  -52.44
    ## 569 1666c4e6 a1939cf8    7b48292e             -1  -52.44
    ## 570 4dc5cf09 a1939cf8    7b48292e             -1  -52.44
    ## 571 23408f12 a1939cf8    7b48292e             -1  -52.44
    ## 572 be9b5f9e 7248f8f4    7b48292e             -2  -54.36
    ## 573 ac473003 7248f8f4    7b48292e             -2  -54.36
    ## 574 aaf56660 7248f8f4    7b48292e             -2  -55.46
    ## 575 3999cac6 7248f8f4    7b48292e             -2  -55.46
    ## 576 1cba9413 7248f8f4    7b48292e             -2  -55.46
    ## 577 c52fe58b 7248f8f4    7b48292e             -2  -55.46
    ## 578 9e5be0f3 a1939cf8    7b48292e             -4  -55.76
    ## 579 39ded95b a1939cf8    7b48292e             -4  -55.76
    ## 580 39ded95b a1939cf8    7b48292e             -4  -55.76
    ## 581 eba15e09 a1939cf8    7b48292e             -4  -55.76
    ## 582 c5aa15df a1939cf8    7b48292e             -3  -56.58
    ## 583 2529cc9d 7f5f1a17    7b48292e             -4  -56.60
    ## 584 a7c30fc2 7f5f1a17    7b48292e             -4  -56.60
    ## 585 c4159da0 7f5f1a17    7b48292e             -4  -56.60
    ## 586 e4160a51 7f5f1a17    7b48292e             -4  -56.60
    ## 587 a71419e1 9d4f7970    7b48292e             -5  -56.60
    ## 588 abb76f29 7f5f1a17    7b48292e             -4  -56.60
    ## 589 a17a7558 7f5f1a17    7b48292e             -4  -56.60
    ## 590 cb245c63 9d4f7970    7b48292e             -5  -56.60
    ## 591 33b28700 9d4f7970    7b48292e             -5  -56.60
    ## 592 5f0feb85 9d4f7970    7b48292e             -5  -56.60
    ## 593 7fc68163 9d4f7970    7b48292e             -5  -56.60
    ## 594 d4af4086 ae586f97    7b48292e             -6  -56.70
    ## 595 e1d1f5f7 ae586f97    7b48292e             -6  -56.70
    ## 596 7ee646af ae586f97    7b48292e             -6  -56.70
    ## 597 bdd850e4 c1a7fe7f    7b48292e             -2  -57.04
    ## 598 852405e9 c1a7fe7f    7b48292e             -2  -57.04
    ## 599 ff122c3f f1a48f8b    7b48292e             -2  -57.82
    ## 600 b304f89a f1a48f8b    7b48292e             -2  -57.82
    ## 601 b69b8683 f1a48f8b    7b48292e             -2  -57.82
    ## 602 c40e2889 f1a48f8b    7b48292e             -2  -57.82
    ## 603 5a4369ed f1a48f8b    7b48292e             -2  -57.82
    ## 604 e7192721 f1a48f8b    7b48292e             -2  -57.82
    ## 605 869b6b18 f1a48f8b    7b48292e             -2  -57.82
    ## 606 ff122c3f f1a48f8b    7b48292e             -3  -58.53
    ## 607 3999cac6 f1a48f8b    7b48292e             -3  -58.53
    ## 608 e664c3e9 7248f8f4    7b48292e             -3  -58.80
    ## 609 f676043b 7248f8f4    7b48292e             -3  -58.80
    ## 610 9f0cf752 7248f8f4    7b48292e             -3  -58.80
    ## 611 a57a2a45 c1a7fe7f    7b48292e             -2  -58.80
    ## 612 f6e6ba91 c1a7fe7f    7b48292e             -2  -58.80
    ## 613 1227bdb1 c1a7fe7f    b105050f             -2  -58.80
    ## 614 1227bdb1 c1a7fe7f    b105050f             -2  -58.80
    ## 615 11605b87 c1a7fe7f    7b48292e             -2  -58.80
    ## 616 3eaabefc f1a48f8b    7b48292e             -2  -59.00
    ## 617 ab9644a0 f1a48f8b    7b48292e             -2  -59.00
    ## 618 b654df79 f1a48f8b    7b48292e             -2  -59.00
    ## 619 b69b8683 f1a48f8b    7b48292e             -2  -59.00
    ## 620 9bee0ab5 f1a48f8b    7b48292e             -2  -59.00
    ## 621 f6a860c8 f1a48f8b    7b48292e             -2  -59.00
    ## 622 e7192721 f1a48f8b    7b48292e             -2  -59.00
    ## 623 fb6d24a2 c1a7fe7f    7b48292e             -2  -59.68
    ## 624 9dd09adb c1a7fe7f    7b48292e             -2  -59.68
    ## 625 8781f2f2 f1a48f8b    7b48292e             -3  -59.73
    ## 626 70f31c7b f1a48f8b    7b48292e             -3  -59.73
    ## 627 ff122c3f f1a48f8b    7b48292e             -3  -59.73
    ## 628 31953405 f1a48f8b    7b48292e             -3  -59.73
    ## 629 8781f2f2 f1a48f8b    7b48292e             -3  -59.73
    ## 630 9e949f82 7f5f1a17    7b48292e             -6  -59.82
    ## 631 9aca8977 7f5f1a17    7b48292e             -6  -59.82
    ## 632 b304f89a 7f5f1a17    7b48292e             -6  -59.82
    ## 633 8781f2f2 7f5f1a17    7b48292e             -6  -59.82
    ## 634 9e5be0f3 ae586f97    7b48292e             -6  -60.48
    ## 635 f8a59a6b 7f5f1a17    7b48292e             -8  -60.64
    ## 636 af267306 7f5f1a17    7b48292e             -8  -60.64
    ## 637 2db040a6 f1a48f8b    7b48292e             -2  -61.10
    ## 638 4e6d5d8c f1a48f8b    7b48292e             -2  -61.10
    ## 639 0b7a3837 c1a7fe7f    7b48292e             -2  -61.64
    ## 640 837f3152 c1a7fe7f    7b48292e             -2  -61.64
    ## 641 b0f572e4 c1a7fe7f    7b48292e             -2  -61.64
    ## 642 795cf5dc c1a7fe7f    7b48292e             -2  -61.64
    ## 643 ba287dd0 a1939cf8    7b48292e             -1  -61.69
    ## 644 6a1ff1fd a1939cf8    7b48292e             -1  -61.69
    ## 645 c6734095 a1939cf8    7b48292e             -1  -61.69
    ## 646 ff122c3f a1939cf8    7b48292e             -1  -61.69
    ## 647 cbf338e5 a1939cf8    7b48292e             -1  -61.69
    ## 648 cb245c63 a1939cf8    7b48292e             -1  -61.69
    ## 649 8781f2f2 a1939cf8    7b48292e             -1  -61.69
    ## 650 837f3152 a1939cf8    7b48292e             -1  -61.69
    ## 651 c5aa15df a1939cf8    7b48292e             -1  -61.69
    ## 652 5c494c44 a1939cf8    7b48292e             -1  -61.69
    ## 653 b0f572e4 a1939cf8    7b48292e             -1  -61.69
    ## 654 5a4369ed a1939cf8    7b48292e             -1  -61.69
    ## 655 a17a7558 a1939cf8    7b48292e             -1  -61.69
    ## 656 03b2b36e a1939cf8    7b48292e             -1  -61.69
    ## 657 95f4d4b0 a1939cf8    7b48292e             -1  -61.69
    ## 658 ac473003 a1939cf8    7b48292e             -1  -61.69
    ## 659 d3f88e19 a1939cf8    7b48292e             -1  -61.69
    ## 660 98bd39be a1939cf8    7b48292e             -1  -61.69
    ## 661 d0f1eea9 a1939cf8    7b48292e             -1  -61.69
    ## 662 4e6d5d8c f1a48f8b    7b48292e             -2  -61.70
    ## 663 8a11d40d f1a48f8b    7b48292e             -2  -61.70
    ## 664 4e6d5d8c f1a48f8b    7b48292e             -2  -61.70
    ## 665 f6e6ba91 f1a48f8b    7b48292e             -2  -61.70
    ## 666 b29cba70 f1a48f8b    7b48292e             -2  -61.70
    ## 667 30690360 f1a48f8b    7b48292e             -2  -61.70
    ## 668 51f7bf20 ae586f97    7b48292e             -9  -62.19
    ## 669 5ee9bf94 ae586f97    7b48292e             -9  -62.19
    ## 670 93730e73 f1a48f8b    7b48292e             -3  -62.61
    ## 671 eb2b012a f1a48f8b    7b48292e             -3  -62.61
    ## 672 eb2b012a f1a48f8b    7b48292e             -3  -62.61
    ## 673 8933a1a9 c1a7fe7f    7b48292e             -2  -62.88
    ## 674 7bd1b69e c1a7fe7f    7b48292e             -2  -62.88
    ## 675 69b30902 c1a7fe7f    7b48292e             -2  -62.88
    ## 676 efcbbe7e c1a7fe7f    7b48292e             -2  -62.88
    ## 677 9e600ac4 c1a7fe7f    7b48292e             -2  -62.88
    ## 678 194b2a34 c1a7fe7f    7b48292e             -2  -62.88
    ## 679 9754f8ad c1a7fe7f    7b48292e             -2  -62.88
    ## 680 cd2eecfd c1a7fe7f    7b48292e             -2  -62.88
    ## 681 3999cac6 c1a7fe7f    7b48292e             -2  -62.88
    ## 682 9aca8977 c1a7fe7f    7b48292e             -2  -62.88
    ## 683 cc7483f1 c1a7fe7f    7b48292e             -2  -62.88
    ## 684 707d9b49 c1a7fe7f    7b48292e             -2  -62.88
    ## 685 ad6db95b c1a7fe7f    7b48292e             -2  -62.88
    ## 686 b122872e c1a7fe7f    7b48292e             -2  -62.88
    ## 687 59da869d c1a7fe7f    7b48292e             -2  -63.82
    ## 688 39ded95b c1a7fe7f    7b48292e             -2  -63.82
    ## 689 69830668 c1a7fe7f    7b48292e             -2  -63.82
    ## 690 457b5289 c1a7fe7f    7b48292e             -2  -63.82
    ## 691 9bee0ab5 ae586f97    7b48292e             -7  -64.05
    ## 692 5c36d69b 7248f8f4    7b48292e             -2  -64.14
    ## 693 73351abd 7248f8f4    7b48292e             -2  -64.14
    ## 694 d56fdb2c 7248f8f4    7b48292e             -2  -64.14
    ## 695 a0c04be3 7248f8f4    7b48292e             -2  -64.14
    ## 696 428e7005 7248f8f4    7b48292e             -2  -64.14
    ## 697 a0c04be3 ae586f97    7b48292e             -8  -64.56
    ## 698 b304f89a 9d4f7970    7b48292e             -5  -65.10
    ## 699 f119653b 290f7be8    7b48292e             -4  -65.12
    ## 700 e7192721 7f5f1a17    7b48292e             -6  -65.64
    ## 701 ffe1e6a7 7248f8f4    7b48292e             -4  -66.44
    ## 702 53104973 1b29f7b5    7b48292e            -12  -66.72
    ## 703 dbeae6ad 290f7be8    7b48292e             -4  -67.12
    ## 704 75732d79 7248f8f4    7b48292e             -4  -67.80
    ## 705 a7b07104 7248f8f4    7b48292e             -4  -67.80
    ## 706 cb245c63 9d4f7970    7b48292e             -6  -67.92
    ## 707 f018a706 9d4f7970    7b48292e             -6  -67.92
    ## 708 e4160a51 9d4f7970    7b48292e             -6  -67.92
    ## 709 daf546cc 7248f8f4    7b48292e             -3  -68.52
    ## 710 af267306 ae586f97    7b48292e             -8  -69.44
    ## 711 606b693b 7f5f1a17    7b48292e             -7  -69.79
    ## 712 5a4369ed 7f5f1a17    7b48292e             -7  -69.79
    ## 713 2e61b7da 7f5f1a17    7b48292e             -7  -69.79
    ## 714 0f50d35d 7248f8f4    7b48292e             -3  -69.93
    ## 715 d67e78e2 7248f8f4    7b48292e             -3  -69.93
    ## 716 852405e9 c1a7fe7f    7b48292e             -2  -70.64
    ## 717 b6ef9eb7 c1a7fe7f    7b48292e             -2  -70.64
    ## 718 bb6290d1 c1a7fe7f    7b48292e             -2  -70.64
    ## 719 eba15e09 7f5f1a17    7b48292e             -5  -70.75
    ## 720 c5aa15df 7f5f1a17    7b48292e             -5  -70.75
    ## 721 0a9c6bfa ae586f97    7b48292e             -8  -70.80
    ## 722 e75e5d78 7248f8f4    7b48292e             -3  -72.03
    ## 723 b304f89a f1a48f8b    7b48292e             -3  -73.23
    ## 724 e664c3e9 7248f8f4    7b48292e             -3  -73.50
    ## 725 912ecc64 7248f8f4    7b48292e             -3  -73.50
    ## 726 9f0cf752 7248f8f4    7b48292e             -3  -73.50
    ## 727 26712b6e c1a7fe7f    7b48292e             -2  -74.36
    ## 728 0dc28aa5 c1a7fe7f    7b48292e             -2  -74.36
    ## 729 fb6d24a2 c1a7fe7f    7b48292e             -2  -74.36
    ## 730 d4e8282a c1a7fe7f    7b48292e             -2  -74.36
    ## 731 a57a2a45 c1a7fe7f    7b48292e             -2  -74.36
    ## 732 7320e5ea c1a7fe7f    7b48292e             -2  -74.36
    ## 733 962692ff c1a7fe7f    7b48292e             -2  -74.36
    ## 734 b69b8683 f1a48f8b    7b48292e             -3  -74.73
    ## 735 e7192721 f1a48f8b    7b48292e             -3  -74.73
    ## 736 aaf56660 a1939cf8    7b48292e             -4  -75.44
    ## 737 af267306 c1a7fe7f    7b48292e             -2  -75.48
    ## 738 4e6d5d8c c1a7fe7f    7b48292e             -2  -75.48
    ## 739 bb6290d1 c1a7fe7f    7b48292e             -2  -75.48
    ## 740 7746499e c1a7fe7f    7b48292e             -3  -75.54
    ## 741 b8ac96ba 7f5f1a17    7b48292e            -10  -75.80
    ## 742 51f7bf20 7f5f1a17    7b48292e            -10  -75.80
    ## 743 73754c63 c1a7fe7f    7b48292e             -3  -77.07
    ## 744 9bee0ab5 c1a7fe7f    7b48292e             -3  -77.07
    ## 745 9bee0ab5 c1a7fe7f    7b48292e             -3  -77.07
    ## 746 f018a706 c1a7fe7f    7b48292e             -3  -77.07
    ## 747 ae9b0293 c1a7fe7f    7b48292e             -3  -77.07
    ## 748 8e3ae804 f1a48f8b    7b48292e             -3  -78.27
    ## 749 d4e8282a 9d4f7970    7b48292e             -7  -79.24
    ## 750 5a4369ed 9d4f7970    7b48292e             -7  -79.24
    ## 751 aab717fb 9d4f7970    7b48292e             -6  -79.68
    ## 752 40bb25df 7248f8f4    7b48292e             -3  -81.54
    ## 753 e7fb7e09 f1a48f8b    7b48292e             -4  -83.48
    ## 754 9c9f1bf3 a1939cf8    7b48292e             -6  -83.64
    ## 755 8781f2f2 7f5f1a17    7b48292e             -6  -84.90
    ## 756 5a4369ed 7f5f1a17    7b48292e             -6  -84.90
    ## 757 186d240d f1a48f8b    7b48292e             -3  -86.73
    ## 758 0eb8732b f1a48f8b    7b48292e             -3  -86.73
    ## 759 c5aa15df f1a48f8b    7b48292e             -3  -86.73
    ## 760 1353f878 c1a7fe7f    7b48292e             -3  -88.20
    ## 761 efcbbe7e f1a48f8b    7b48292e             -3  -88.50
    ## 762 8781f2f2 f1a48f8b    7b48292e             -3  -88.50
    ## 763 3f4c9f0e f1a48f8b    7b48292e             -3  -88.50
    ## 764 3999cac6 f1a48f8b    7b48292e             -3  -88.50
    ## 765 f3593faa f1a48f8b    7b48292e             -3  -88.50
    ## 766 31953405 f1a48f8b    7b48292e             -3  -88.50
    ## 767 09c918d8 1b29f7b5    7b48292e            -20  -90.80
    ## 768 6f6eadfd c1a7fe7f    7b48292e             -3  -92.46
    ## 769 1cba9413 c1a7fe7f    7b48292e             -3  -92.46
    ## 770 9dc4be40 7248f8f4    7b48292e             -4  -93.24
    ## 771 15a5ce0b 7248f8f4    7b48292e             -4  -93.24
    ## 772 eba15e09 c1a7fe7f    7b48292e             -3  -94.32
    ## 773 73a0cf73 c1a7fe7f    7b48292e             -3  -94.32
    ## 774 ba287dd0 c1a7fe7f    7b48292e             -3  -94.32
    ## 775 3517d03b c1a7fe7f    7b48292e             -3  -94.32
    ## 776 1cba9413 c1a7fe7f    7b48292e             -3  -94.32
    ## 777 24f16ade c1a7fe7f    7b48292e             -3  -94.32
    ## 778 bea14582 c1a7fe7f    7b48292e             -3  -94.32
    ## 779 600bc7f2 7248f8f4    7b48292e             -3  -96.21
    ## 780 37c64d32 7248f8f4    7b48292e             -3  -96.21
    ## 781 963a6b1c 7248f8f4    7b48292e             -3  -96.21
    ## 782 0eb8732b f1a48f8b    7b48292e             -5  -97.55
    ## 783 600bc7f2 7248f8f4    7b48292e             -3  -97.65
    ## 784 c8667ee6 7248f8f4    7b48292e             -5  -98.00
    ## 785 39ded95b 7f5f1a17    7b48292e             -9  -98.46
    ## 786 d337a280 7f5f1a17    7b48292e            -12  -98.76
    ## 787 2e61b7da c1a7fe7f    7b48292e             -4 -102.76
    ## 788 9c9f1bf3 9d4f7970    7b48292e             -8 -104.16
    ## 789 cbf338e5 a1939cf8    7b48292e             -2 -104.88
    ## 790 ac473003 a1939cf8    7b48292e             -2 -104.88
    ## 791 a57a2a45 c1a7fe7f    7b48292e             -3 -105.96
    ## 792 51f7bf20 9d4f7970    7b48292e             -8 -108.88
    ## 793 0fa7fbe7 7248f8f4    7b48292e             -4 -110.92
    ## 794 8a11d40d c1a7fe7f    7b48292e             -3 -111.54
    ## 795 93730e73 c1a7fe7f    7b48292e             -3 -113.22
    ## 796 30690360 c1a7fe7f    7b48292e             -3 -113.22
    ## 797 3f4c9f0e f1a48f8b    7b48292e             -4 -115.64
    ## 798 071e53fc 7248f8f4    7b48292e             -5 -116.55
    ## 799 3ccea12d 7248f8f4    7b48292e             -5 -116.55
    ## 800 08ff1731 7248f8f4    7b48292e             -6 -117.60
    ## 801 79092314 f1a48f8b    7b48292e             -4 -118.00
    ## 802 9e5be0f3 c1a7fe7f    7b48292e             -4 -123.28
    ## 803 e7192721 a1939cf8    7b48292e             -2 -123.38
    ## 804 03042773 c1a7fe7f    7b48292e             -4 -125.76
    ## 805 3e080ef9 c1a7fe7f    7b48292e             -4 -125.76
    ## 806 652fbd27 c1a7fe7f    7b48292e             -5 -125.90
    ## 807 81318a55 1b29f7b5    7b48292e            -30 -136.20
    ## 808 f8a59a6b c1a7fe7f    7b48292e             -5 -142.60
    ## 809 8a11d40d c1a7fe7f    7b48292e             -4 -148.72
    ## 810 93730e73 c1a7fe7f    7b48292e             -4 -148.72
    ## 811 06533536 c1a7fe7f    7b48292e             -4 -148.72
    ## 812 81318a55 c1a7fe7f    7b48292e             -4 -148.72
    ## 813 8d617f7d 7248f8f4    7b48292e             -9 -152.55
    ## 814 40dcd7c2 c1a7fe7f    7b48292e             -5 -154.10
    ## 815 a0c04be3 f1a48f8b    7b48292e             -6 -156.54
    ## 816 73a0cf73 a1939cf8    7b48292e             -3 -157.32
    ## 817 f3593faa a1939cf8    7b48292e             -3 -157.32
    ## 818 cc8df6f3 a1939cf8    7b48292e             -3 -157.32
    ## 819 311f234b 9d4f7970    7b48292e            -12 -159.36
    ## 820 f8a59a6b 7f5f1a17    7b48292e            -19 -160.36
    ## 821 ac473003 7248f8f4    7b48292e            -10 -166.10
    ## 822 39ded95b f1a48f8b    7b48292e             -6 -173.46
    ## 823 6f4cabe3 c1a7fe7f    7b48292e             -6 -176.40
    ## 824 5afb35f4 9d4f7970    7b48292e            -16 -181.12
    ## 825 fdb015cc 9d4f7970    7b48292e            -21 -183.12
    ## 826 39ded95b a1939cf8    7b48292e             -3 -185.07
    ## 827 a38e168d 9d4f7970    7b48292e            -14 -185.92
    ## 828 cb245c63 a1939cf8    7b48292e            -10 -188.60
    ## 829 53ac2d5a ae586f97    7b48292e            -24 -212.40
    ## 830 6519818d 7f5f1a17    7b48292e            -20 -218.80
    ## 831 3ed92a74 ae586f97    7b48292e            -54 -225.72
    ## 832 e1617d17 7248f8f4    7b48292e            -10 -233.10
    ## 833 af267306 ae586f97    7b48292e            -29 -256.65
    ## 834 af267306 f1a48f8b    7b48292e             -9 -277.65
    ## 835 f6e6ba91 7f5f1a17    7b48292e            -37 -280.46
    ## 836 93730e73 c1a7fe7f    7b48292e             -8 -297.44
    ## 837 a71419e1 a1939cf8    7b48292e             -5 -308.45
    ## 838 23408f12 a1939cf8    7b48292e             -6 -314.64
    ## 839 af267306 f1a48f8b    7b48292e            -11 -339.35
    ## 840 d4e8282a 7248f8f4    7b48292e            -11 -345.84
    ## 841 d4e8282a 9d4f7970    7b48292e            -32 -424.96
    ## 842 a0c04be3 1b29f7b5    7b48292e           -100 -556.00
    ## 843 fc086e6b 9d4f7970    7b48292e            -55 -622.60
