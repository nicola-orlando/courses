# Set your directory to the folder where you have downloaded dataset 
setwd('/Users/nicolaorlando/Documents/GitHub/courses/business_ana_essec/data/')

# To clean up the memory of your current R session run the following line
rm(list=ls(all=TRUE))

# Let's load our dataset and call it data
data=read.table('202212-capitalbikeshare-tripdata.csv',sep=',',header=TRUE) # The function read.table enables us to read flat files such as .csv files

# Now let's have a look at our variables and see some summary statistics
str(data) # The str() function shows the structure of your dataset and details the type of variables that it contains
summary(data) # The summary() function provides for each variable in your dataset the minimum, mean, maximum and quartiles

install.packages("RColorBrewer")
library("RColorBrewer")

par(mfrow=c(1,1))

plot(data$end_lat~data$end_lng, ylab='End latitude [dgr]', xlab='End longitude [dgr]')
plot(data$start_lat~data$start_lng, ylab='Start latitude [dgr]', xlab='Start longitude [dgr]')
plot(data$start_lat~data$end_lat, ylab='Start latitude [dgr]', xlab='End latitude [dgr]')
plot(data$start_lng~data$end_lng, ylab='Start longitute [dgr]', xlab='End longitude [dgr]')
xyplot(data$start_lat~data$start_lng, ylab='Start latitude [dgr]', xlab='Start longitude [dgr]',)

barplot(table(data$rideable_type), col = '#9ebcda', cex.names=2.)
barplot(table(data$member_casual), col = '#9ebcda', cex.names=2.)

table(data$rideable_type)
table(data$member_casual)

cor(data[,c(9:12)], use = "complete.obs") # Compute the correlation between all the numerical variables of the sample, use only complete rows 

#testdata=c(data$start_lat,data$start_lng,data$rideable_type,data$member_casual)  # To keep our dataset safe, let's create a copy of it called "testdata"
#testdata <- select(data, member_casual, rideable_type)
#str(testdata)
#summary(testdata)

testdata =data[c(0:5000),c(2,9:13)]
copydata = data[c(0:5000),c(2,9:13)]

testdata
copydata

# Convert data to categorical 
install.packages("dplyr")
library(dplyr)
data_cat <- copydata %>% 
  mutate_if(is.character, as.factor)
str(data_cat)
summary(data_cat)
copydata[c(0:5),]
data_cat[c(0:5),]

data_cat_mod = data_cat[c(0:5000),c(1,6)]
data_cat_mod

data_cat_mod<-transform(data_cat_mod, rideable_type = factor(rideable_type, 
       levels = c("classic_bike", "docked_bike", "electric_bike"),
       labels = c(0, 1, 2)))

data_cat_mod<-transform(data_cat_mod, member_casual = factor(member_casual, 
       levels = c("member", "casual"),
       labels = c(0, 1)))

data_cat_mod
# data_cat = scale(data_cat) # To keep our dataset safe, let's create a copy of it called "testdata"

d = dist(data_cat_mod, method = "euclidean") # the dist() function computes the distances of all the observations in our dataset
hcward = hclust(d, method="ward.D") # hclust() function performs hiearchical clustering, we pass it the distances, and we set the method argument to "ward.D"

data_cat$groups<-cutree(hcward,k=5) # assign our points to our k=3 clusters, define a new variable  
str(data_cat)
summary(data_cat)

data_cat_g1<-data_cat[data_cat$groups==1,]
data_cat_g1
data_cat_g2<-data_cat[data_cat$groups==2,]
data_cat_g2
data_cat_g3<-data_cat[data_cat$groups==3,]
data_cat_g3
data_cat_g4<-data_cat[data_cat$groups==4,]
data_cat_g4
data_cat_g5<-data_cat[data_cat$groups==5,]
data_cat_g5

data_cat_casual<-data_cat[(data_cat$groups==2|data_cat$groups==3|data_cat$groups==5),]
data_cat_casual

par(mfrow=c(3,4))

barplot(table(data_cat_g1$rideable_type), main = 'Group 1')
barplot(table(data_cat_g1$member_casual), main = 'Group 1')

barplot(table(data_cat_g2$rideable_type), main = 'Group 2')
barplot(table(data_cat_g2$member_casual), main = 'Group 2')

barplot(table(data_cat_g3$rideable_type), main = 'Group 3')
barplot(table(data_cat_g3$member_casual), main = 'Group 3')

barplot(table(data_cat_g4$rideable_type), main = 'Group 4')
barplot(table(data_cat_g4$member_casual), main = 'Group 4')

barplot(table(data_cat_g5$rideable_type), main = 'Group 5')
barplot(table(data_cat_g5$member_casual), main = 'Group 5')


aggdata= aggregate(.~ groups, data=data_cat, FUN=mean) # Aggregation by group and computation of the mean values
str(aggdata)
summary(aggdata)
aggdata

# The lattice library provides a complete set of functions for producing advanced plots.
install.packages("lattice") #install the lattice package by using the install.packages() function
library(lattice) # load the lattice package by using the library() function and passing it the name of the package you wish to load
xyplot(copydata$start_lat~copydata$start_lng,main = "After Clustering", type="p",group=groups,data= data_cat, # define the groups to be differentiated 
       auto.key=list(title="Group", space = "left", cex=1.0, just = 0.95), # to produce the legend we use the auto.key= list() 
       par.settings = list(superpose.line=list(pch = 0:18, cex=1)), # the par.settings argument allows us to pass a list of display settings
       col=c('blue','magenta','cyan', 'red', 'black'), 
       ylab='Start latitude [dgr]', xlab='Start longitude [dgr]') # finally we choose the colour of our plotted points per group
       
xyplot(data_cat_casual$start_lat~data_cat_casual$start_lng,main = "After Clustering", type="p",group=groups,data=data_cat_casual, # define the groups to be differentiated 
       auto.key=list(title="Group", space = "left", cex=1.0, just = 0.95), # to produce the legend we use the auto.key= list() 
       par.settings = list(superpose.line=list(pch = 0:18, cex=1)), # the par.settings argument allows us to pass a list of display settings
       col=c('blue','magenta','black'), 
       ylab='Start latitude [dgr]', xlab='Start longitude [dgr]') # finally we choose the colour of our plotted points per group
       
xyplot(copydata$end_lat~copydata$end_lng,main = "After Clustering", type="p",group=groups,data= data_cat, # define the groups to be differentiated 
       auto.key=list(title="Group", space = "left", cex=1.0, just = 0.95), # to produce the legend we use the auto.key= list() 
       par.settings = list(superpose.line=list(pch = 0:18, cex=1)), # the par.settings argument allows us to pass a list of display settings
       col=c('blue','magenta','cyan', 'red', 'black'), 
       ylab='End latitude [dgr]', xlab='End longitude [dgr]') # finally we choose the colour of our plotted points per group       

install.packages('tidyverse')
install.packages('sf')
install.packages('mapview')


library(tidyverse)
library(sf)
library(mapview)

mapview(data_cat, zcol = "groups", xcol = "start_lng", ycol = "start_lat", crs = 4269, grid = FALSE, cex = "start_lng", alpha=0.9, alpha.regions=0.01, legend=TRUE)
?mapview