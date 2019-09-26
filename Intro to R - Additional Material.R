## Understanding R. #SARAH

### What is an R Script
Show what an R Script is.

### Basic functions
Functions can be applied to make data manipulation easier. Many functions are included in baseR. For example mean. Mean returns the arithmetic mean of a vector of numbers. We can find out more about mean by entering ?mean.

```{r,echo=TRUE}
# find out more about mean
#?mean

# create a vector of numbers
some_numbers = c(10,12,13,13,14,18,20)

# find the arithmetic mean of the numbers
average_value = mean(some_numbers)

#return the numbers
average_value
```

Other functions are more complex, requiring multiple inputs. For example **round** requires two inputs:
  x)   a value or multiple values
digits)   the number of digits to round to. 

```{r,echo=TRUE}
# find more information about round
#?round

# Rounding 5.7 to 0 digits gives 6.
round(x = 5.7,digits = 0)

# Rounding our average value to 2 digits gives 14.29.
round(average_value,2)

# We can do the same for multiple values
round(c(12.25,15.63,14.42),1)

```

Another useful function is sequence:
  
  This requires the number to start from (*from*), the number to finish at (*to*), and the interval between numbers (*by*) in the sequence. Alternatively, instead of *by* the length of the sequence can be set using *length.out*.

```{r,echo=TRUE}
# find out more about sequence
#?seq

# create a sequence of odds from 1 to 21.
seq(from = 1, to = 21, by = 2)

# create a sequence of length 10 from 1 to 21
seq(from = 1, to = 21, length.out = 10)
```

### Attributes
```{r,echo=TRUE}

# attributes
df
names(df)
#rownames(df) = c("row 1","row 2","row3") # error
rownames(df) = c("row 1","row 2","row3","row 4")
df

x
length(x)


str(df)
dim(df)

```

### Classes

```{r,echo=TRUE}

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

```

### Environment
```{r,echo=TRUE}
# enviroment & wd
ls()
rm("y")
ls()
# attach(...)
rm(list=ls())
ls()
```

\newpage 

## Working with R. #Rob

### If Statements  
If statements allow us to perform different actions depending on a condition. The normal brackets contain the evaluation, the curly brackets the command if that evaluation is true.  For example here if(1 = 1)then print the number 2. 

```{r echo=TRUE}

if(1==2){
  print(2)
}
```


We can use this to assign risks to individuals based on characteristics. For example if an individual has a health condition (e.g. Type2Diabetes) they may have a higher risk of Heart Disease. Therefore if we know that individuals with diabetes have a 10% risk of Heart Disease and individuals without Type 2 Diabetes have a 3% risk of Heart Disease we could assign risk to an individual as follows:``

```{r echo=TRUE}
t2d <- 0

if(t2d==1){
  risk <- 0.1
}else{
  risk <- 0.03
}
```

This method can be combined with the next tool, loops, to assign risks for lots of individuals.

### Loops
There are numerous different ways to create loops, we are going to look at the simplist, the **for** loop which executes the command for each number given. 
```{r echo=TRUE}

# Loop printing 1 to 10

for(i in 1:10) { # for each value of i from 1 to 10.
  print(i)       # print the value of i
}                # close the loop

```

We can also create an object, in this case a vector with the numbers we would like to loop through:
  
  ```{r echo=TRUE}

# create an object of odds
odds <- c(1,3,5,7,9)

# Loop printing all the values in the odds vector.
for(i in odds) { # for each value of i in the odds vector.
  print(i)       # print the value of i
}                # close the loop

```

If we create a vector, *ourdata*,  beforehand we can fill it with the output from each iteration of the loop. This is particularly useful if we want to record the output of a simulation.

```{r echo=TRUE}

#create an vector of empty data
ourdata <- vector(mode = "numeric",length = 10)

# Fill our vector with values
for(i in 1:length(ourdata)) { # for each value of i in our data object.
  ourdata[i] <- i             # print the value of i
}                             # close the loop

print(ourdata)                # print the vector

```
Having multiple loops can can sometimes make code very messy, an alternative is called apply. It *applies* (hence the name) the same function to multiple rows/columns. This is much tidier, especially where the function is complicated.

As an example, I create a dataset, a matrix of random numbers with 100 columns and 100 rows. I want to know the average of each row.

```{r,echo=FALSE}
squarelength <- 1e4

randnums <- matrix(data = runif(squarelength*squarelength,min = 0,max = 1),
                   nrow = squarelength,
                   ncol = squarelength)

temp <- vector(mode = "numeric",
               length = squarelength)


t <- Sys.time()

for(i in 1:100){
  temp[i] <- mean(randnums[i,])
}
print(Sys.time()-t)
```
In  this case using a function is much slower, but it does make the code tidier, which can be a bigger probem than model run-time. It is up for the programmer to decide which is more important.

```{r,echo=TRUE}
squarelength <- 1e4

randnums <- matrix(data = runif(squarelength*squarelength,min = 0,max = 1),
                   nrow = squarelength,
                   ncol = squarelength)

temp <- vector(mode = "numeric",
               length = squarelength)

# measure time to run
t <- Sys.time()

temp <- apply(X = randnums,
              FUN = mean, 
              MARGIN = 1)

print(Sys.time()-t)

```
### Custom Function
Creating custom functions is a huge strength of R. Calling scripts in STATA is possible, but not as tidy as in R. 

A function is a piece of script that is stored as an object. A function generally takes a user input, performs some actions based on the statements in the function, and returns some output. It is possible to write a script that uses no functions, but using them can reduce unncessary replication of long sections of code, thereby making work easier to follow. 

There are many functions predefined in base R. *Mean* is an obvious example. Custom functions can also be defined within a script, or called from another R-Script using *source*.

An example function is shown below. The function simply takes a temperature, and a conversion (Celsius to Fahrenheit = True, Fahrenheit to Celsius = False), and returns the converted temperature. The function has the name *temperature_converter*, it uses two inputs:
  x      : a scalar or vector of numbers
c_to_f : if True then converts celsius to fahrenheight, if FALSE then converts fahrenheight to celsius.

```{r,echo=TRUE}
# my function
temperature_converter = function(x,c_to_f = T){
  if(c_to_f){
    temp = x * 9/5 + 32 
  } else {
    temp = (x - 32) * 5/9
  }
  return(temp)
}

temperature_converter(c(40,30,20,10,0),c_to_f = T)
```

When creating custom functions it is important to ensure that you don't overwrite an existing function. For example, we can create the function *mean* which does not return the arithmetic mean of a vector of numbers, but instead prints an unkind message.

```{r,echo=TRUE}

mean = function(x){
print("You are a buffoon")
}
mean(c(15,10,40,32,18))

```

**Exercise 1**

Create a function which multiplies three input numbers together

```{r,echo=FALSE,eval=FALSE}

multiply_these = function(x,y,z){
temp <- x*y*z

return(temp)
}

multiply_these(10,5,1)
```

**Exercise 2**

Create a function which divides a number by 37, then rounds the number to 2 decimal places. I find it easier to do things one step at at time. In this case I would create a temporary object which was the value of the number divided by 37, then round the temporary number to two digits, overwriting the original temporary object. I would then return that temporary number.

```{r,echo=FALSE,eval=FALSE}

learning_function = function(x){

temp <- x/37

temp <- round(x= temp,
digits = 2
)

return(temp)
}

learning_function(12)
```

**Exercise 3**

Calculate, in real terms, the present value of stream of annual monetary benefits received at the start of each yearfor 10 years, given a user specified discount rate

```{r,echo=FALSE,eval=FALSE}

calc_presval = function(init_val,d.r){

temp <- init_val/(1+d.r)^(0:9)

return(temp)
}

# Value of 100, received at the start of every year for 10 years. Discounted at a rate of 3%.
calc_presval(init_val = 100,
d.r = 0.03)
```

### Packages

Creating all your functions from scratch is a lot of work, where others have previously created the same functions, why reinvent the wheel? Instead we can stand on the shoulders of others by downloading 'packages'. Packages usually contain functions, and sometimes example datasets or datasets which enable a user to do certain things (e.g. plot a world map). Importantly though, we must understand what the functions within these packages are doing if we are going to use them.

A package can be installed from CRAN using the function *install.packages()* with the name of the package in "". Packages can also be installed from Github, but this is covered later. 



```{r,echo=TRUE,eval=FALSE}
#install.packages("stats")
#devtools::install_github("hadley/babynames")
```

To find more information about the babynames package you can type

```{r,echo=TRUE,eval=FALSE}

#help(package = "babynames")
```

To load the downloaded package from the file it was downloaded to you can type:

```{r,echo=TRUE,eval=FALSE}

#library(babynames)
#ls("package:babynames")
#View(babynames)
```

In this package there is just a dataset of baby names. However other packages allow you to do certain things. In many cases there are lots of different options. For example the rworldmap package contains data on country boundaries and enables the user to create custom maps. For a really simple map see the example below:

```{r,echo=TRUE,eval=FALSE}
#install.packages("rworldxtra")
#install.packages("mapdata")
#library(rworldxtra)

#newmap <- getMap(resolution = "high")
#
#plot(newmap, 
#     xlim = c(-10, -2), 
#     ylim = c(50, 62), 
#     asp = 1)
#
#points(x = -1.480840, 
#       y= 53.380720, 
#       col = "red",
#       pch =  16, 
#       cex = 1)
#
#text(x = -1.480840, 
#     y = 53.380720,
#     labels = "Sheffield",
#     pos = 1,
#     col = "red")

```

## Doing Research in R # Tom


### Importing Data

In almost every case, you will want to import some data to analyse. This data will come in a variety of formats. R studio has a nice feature in Environment>Import_Dataset which enables you to select the file you wish to download (similar to STATA) from your computer. The data is then imported into R and the code available in the console.

It is possible to import files in the following formats:

|  Type  | Suffix     | 
|--------|:----------:|
| R      |.R          |
| CSV    |.csv        |
| Excel  |.xls/.xlsx  |
| SPSS   |.spv        |
| Stata  |.dta        |


Alternatively packages can be installed to import data in almost any format. For example the readr package can read in spreadsheets from text files or tab delimited files.


#### CSV (Comma-seperated values)
We can import the file using the full path with the file name and suffix included such as below:

```{r,echo=TRUE,eval=FALSE}

```

#### Setting Working Directory
If you know that you will be reading and writing multiple files from the same folder, you can set a working directory. The working directory is the defined folder in which R will then import and export files from and to. This allows users to send whole files to others who can replicate the work by simply changing the working directory to the new file location. 

The current working directory can be found by typing:

```{r,echo=TRUE}
getwd()
```

A new working directory can be set by clicking on the tab (Session) then (Set_Working Directory), or by the command setwd:

```{r,echo=TRUE,eval=FALSE}
# filename = "C:/Users/Robert/Documents"
setwd(filename)
```

#### Downloading files from the internet

Sometimes it is more practical to download files directly from the internet. There are lots of different packages out there to do this. The one I use was developed by Hadley Wickham, called readr. Here we are going to download some data from the github page for the course.

```{r,echo=TRUE,eval=FALSE}
# load the readr package, if this is not installed then install it.
library(readr)

#use the function read_csv
#data <- read_csv("https://raw.githubusercontent.com/RobertASmith/Intro_to_R/master/Data/who_complete.csv")
```

Downloading files directly to R within the same script as the analysis can be useful since it reduces the risk of you accidently changing the file. Just be careful that the data will always be available. 

### Summarising Data

Once we have our data read into R, we want to ensure that the data is as we would expect, in the correct format etc. 

We can use the function *head* to look at the first 6 number of lines of the data. We can specify a different number of lines by chancing the function input.

```{r,echo=TRUE,eval=FALSE}
library(babynames)

# head data with default 6 rows
head(babynames)

# head data with 10 rows
head(babynames, n = 10)

```
We can summarise a dataset using the function *summary*. This shows us the length, class and Mode. If the class is numeric it will give some indication of the distribution by displaying min, median, mean, max. 

```{r,echo=TRUE,eval=FALSE}

# summarise the data, 
summary(babynames)

# summarise single variable
summary(babynames$prop)

```
### Summarising
Data-frames

Summarise data-frame:

```{r,echo=TRUE}
# We can summarise our data-frame with height, weight, first name and BMI.
#summary(df)

# The data-frame height variable is numeric, will return quantiles.
#(df$height)

# The data-frame first-name lists the first name and number (character)
#summary(df$first_name)

```

We can use the output of the summary function to create objects. The summary of the year variable gives the quantiles. These can be stored as an object, here called temp (temporary object). If we just want any one number from the vector of quantiles we can define this in brackets. The script below creates two new objects, median and range.

```{r,echo=TRUE,eval=FALSE}

temp <- summary(babynames$year)

Median  <- temp['Median']
Range   <- temp['Max.'] - temp['Min.']

```

### Plotting Data

*Line Plot*
It is also possible to plot the data provided. If we subset the babyname data, limiting the data to females called Mary we can plot the incidence in Marys over time. The function to do this is *plot*. Plot requires a vector of x and a vector of y. If x is not specified y is plotted against Index (1= first observation in index ... and so on).

```{r,echo=TRUE,fig.height=5, fig.width=8}
subname <- "Donald"
temp <- subset(babynames,
name == subname & sex=="M")
temp <- as.data.frame(temp)

# A basic plot, just a scatter plot but with year on the x axis.
x <- temp[,"year"]
y <- temp[,"prop"]

plot(x = x, y = y)

```

However, this plot looks quite messy:

1) It is lots of points rather than a line.
2) We have weird axis names.
3) The Y axis numbers are awkward.
4) There is no title.

```{r,echo=TRUE, fig.height=5, fig.width=8}

plot(y = y*1000,
x = x,
type = "l",
xlab = "Year",
ylab = paste(subname," per 1000"),
main = paste("Number of newborns named", 
subname, ", United States 1880 to 2017")
)
```

We can also plot a histogram of how prevalent a name is over the whole period. The command *hist* does this.

```{r,echo=TRUE, fig.height=5, fig.width=8}
subname == "Matthew"

temp <- subset(babynames,
name == subname & sex=="M")

hist1 <- hist(temp$prop,breaks = seq(0,0.05,by=0.005))

plot(hist1)

# we can add a density line in simply using the function *density*.
lines(density(x = temp$prop))

```

### Basic Regression

R is designed for statistical analysis. It therefore has simple inbuilt commands for regression. We can use an example dataset which has information about cars:

```{r,echo=TRUE, fig.height=5, fig.width=8, echo=TRUE}

plot(x = cars$speed,
y = cars$dist,
type = "p",
xlab = "speed",
ylab = "distance")

# correlation is quite high:
cor(cars$speed, cars$dist)

# we can use a linear model to estimate the relationship between speed and distance. 
lm_cars <- lm(dist ~ speed, data=cars) 

# we can then print to see the intercept and beta.
print(lm_cars)

# we can see more information including std. error, p value etc here:
summary(lm_cars)

# As before, we can create an object with one part of this information by subsetting just the coefficients.
lm_coeff <- summary(lm_cars)$coefficients

# Then, for example if we want the intercept we can do:
lm_coeff["(Intercept)","Estimate"]
# Or the standard error of the speed:
lm_coeff["speed", "Std. Error"]

# we can predict distance from a set of speeds using predict. This command predicts the value of distance given a speed. We could do this simply using the equation Intercept + beta*Speed.
dist_speed5 <- lm_coeff["(Intercept)","Estimate"] + lm_coeff["speed", "Estimate"]*5
print(dist_speed5)

# or by predicting from a dataframe
speed <- 5
df <- as.data.frame(speed) 

distPred <- predict(lm_cars,
newdata = df)
print(distPred)

# we can plot estimates derived using our original data by simply predicting and leaving out the new-data option:
distPred <- predict(lm_cars)

plot(x = cars$speed,
y= cars$dist)

lines(x=cars$speed, 
y= distPred,col = "red")

```

### Basic Simulation
Sometimes we want to create a simple simulation, moving entities through time and having events occur. This is particularly useful in health economics.


We can do much more complex calculations within loops, the sky is the limit, but here are two examples.


**Example 1**
Example 1 is an example of discounting each year simply by multiplying the previous year value by (1/(1+d.r)).

```{r echo=TRUE}

#create an vector of empty data
v.val <- vector(mode = "numeric",length = 100)

# start with 1
v.val[1] <- 1

# Discount our value at 1.5% each year
for(i in 2:length(v.val)) {            # for each value of i in the odds object.

v.val[i] <- v.val[i-1]* (1/1.015)    # it takes the value of the previous year value 1/(1.015)

}                                      # close the loop

plot(v.val,type="l")                           # print the vector

```

An important lesson though, it is often possible to achieve a goal without loops, which is much faster in R when running big simulations. In this case we could have achieved the same result with the following, much simpler code:

```{r echo=TRUE}

v.val <- (1/1.015)^(1:100)

plot(v.val,type = "l")

```

**Example 2**
Example 2 records the survival of 1000 individuals who die with probability 0.1 in any given year.

```{r echo=TRUE}

#create an vector of empty data
m.ind <- matrix(data = NA,
nrow = 100,
ncol = 1000)

# everyone starts alive (1) 
m.ind[1,] <- 1

# Each person has a probability of death of 0.1
for(i in 2:nrow(m.ind)) { 

# value is 1 if alive in previous period and random number > 0.1 
m.ind[i,] <- m.ind[i-1,] * runif( n = 1000, min = 0, max=1 ) > 0.1  
}                                      # close the loop

plot(rowSums(m.ind),type="l")   # print the sums of the rows of the matrix (% alive)

```

