#
string <- "This is a string"

class(string)
length(string)
nchar(string)


#Double
number <- 234
class(number)
typeof(number)
lenght(number)

number_2 <- 1/8

typeof(number_2)


#int 

integer <- 2L

class(integer)

# logical

logical <- FALSE

class(logical)

logical*1

as.logical(1)


# Vectores 

num_vector <- c(number,number_2)



num_vector_2 <- c(1,2,3,4,"a")


vec_1 <- 1:100


vex2<- sample(x= 1:10,size=5,replace=FALSE)


vector("integer", length= 10)




class(num_vector)
class(num_vector_2)


c(num_vector, num_vector_2,5,6,7,8)

log_vec <- c(F,F,T)
class(log_vec)
log_vec*10

as.numeric(num_vector_2)


asc(abc)

utf8ToInt("Elgueta")



# factor 

factor_1 <- c("Mon","Tues","Thu","Fri","Sar","Sun","Wed","Thu")

factor_1 <- factor(factor_1)


factor_2 <- c("Mon","Tues","Thu","Fri","Sat","Sun","Wed","Thu")

factor_2 <- ordered(factor_2, levels = c("Mon","Tues","Wed","Thu","Fri","Sat","Sun"))

# Lists


vector1 <- c(1,2,3,4,5)
vector2 <- c(F,F,T)
vector3 <- letters[1:6]

list_1 <- list(vector1,vector2,vector3)

names(list_1) <- c("A","B","C")
list_1$A


# Matrix

mat <- matrix(1:10, nrow = 2, ncol=5 )
mat[1.]


c(1:6)[c(1,3:5)]


a <- c(1,2,3,4,5,4,6,4,3,4,5,7)
a[a>=4]



df <- data.frame(
  col1 = c("this","is","a","vector","of","strings"),
  col2 = 1:6,
  col3 = letters[1:6],
  stringsAsFactors = FALSE)




View(df)
str(df)


df$col2
df$col1[1:2]



names(df)
names(df) <- c("1","2","3")


df$"1"

head(df,3)

tail(df,2)


nrow(df)

ncol(df)




# Functions of base R (ufunc)


num_vector_3 <- as.numeric(num_vector_2)
is.na(num_vector_3)

num_vector_3[!is.na(num_vector_3)]


mean(num_vector_3, na.rm = TRUE)


mean(num_vector_3[!is.na(num_vector_3)])


df_copy <-  data.frame(
  col1 = c("this","is","a",NA,"of","strings"),
  col2 = c(1:5,NA),
  col3 = letters[1:6]
)


df_copy[!is.na(df_copy$col2),]

