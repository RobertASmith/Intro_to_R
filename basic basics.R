


# 1. basic basics
1 + 1
12/4
4^2 

# objects basics
x = 3
y = 5
x + y
 
x = 4
x + y
  
z = x + y
z

# manipulations 
x.2 = x
x.2

x.2 = x.2 + 1 
x.2 
x

# more complex objects
height = c(1.72,1.78,1.65,1.90) # 1:4
height

weight = c(68,75,55,79)
weight

first_name = c("Alice","Bob","Harry","Jane")
first_name
first_name + 1 # error

df = data.frame(height,weight,first_name)
df

df$bmi = df$weight / df$height^2 
df


# index
x
x[1]
x[2]
x[2,2] #error
x[c(1,2)]
x[1:4]

df

df$height
df[1] # error
df[,1]
df[2,]

df$height[2]
df[2,1]

df$height[2] - df$height[1]

# evaluations
4 > 2
4 > 5
4 == 3
4 != 3
"x" == "x"

# subsetting
df
min_height = df$height >= 1.75
min_height

df.at_least_175 = df[min_height,]
df.at_least_175


smaller = df$height < 1.75
df[smaller,]
df[!min_height,]

show_men = df$first_name %in% c("Harry","Bob")
df[show_men,]

# which(df$weight > 70)
# df[which(df$weight > 70),]

# basic functions
some_numbers = c(10,12,13,13,14,18,20)
average_value = mean(some_numbers)
average_value

str(df)

round(average_value,2)
?round

?seq
seq(from = 1, to = 21, by = 2)


# attributes
df
names(df)
rownames(df) = c("row 1","row 2","row3") # error
rownames(df) = c("row 1","row 2","row3","row 4")
df

x
length(x)


str(df)
dim(df)


# classes
class(x)
class("this is a sentence")
class(df)

# matrix(1:9,ncol=3,nrow=3)

# the list
My_list = list(my_df = df,
               a_vector = x,
               another_one = y,
               some_text = c("foo","bar"))
My_list

My_list$a_vector

My_list$my_df

My_list[[1]]

My_list[[1]]$height

str(My_list)

# NA, Nan, Inf

# enviroment & wd
ls()
rm("y")
ls()
# attach(...)
rm(list=ls())
ls()


# packages


# if statements

# my function
C_F_converter = function(x,c_to_f = T){
  if(c_to_f){
    res = x * 9/5 + 32 
  } else {
    res = (x - 32) * 5/9
  }
  return(res)
}

C_F_converter(22,c_to_f = T)


# loops












