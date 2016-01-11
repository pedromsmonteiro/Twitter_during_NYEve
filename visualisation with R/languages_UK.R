#all NYE data
packages <- c("ggplot2", "dplyr", "maps", "mapdata", "ggmap", "ggplot2")
lapply(packages, require, character.only = TRUE)
library(dplyr)
library(maps)       # Provides functions that let us plot the maps
library(mapdata)    # Contains the hi-resolution maps.
library(ggmap)      # finds longitude and latitude values
library(ggplot2)    # high quality graphing
UK1 <- read.csv("UK_NYE_1.csv", sep=",", header = FALSE)
UK2 <- read.csv("UK_NYE_2.csv", sep=",", header = FALSE)
UK3 <- read.csv("UK_NYE_3.csv", sep=",", header = FALSE)
UK12 <- rbind(UK1, UK2)
UKdata <- rbind(UK12, UK3)
#lonlat <- cbind(sa_UK,geocode(sa_UK[,1]))
names(UKdata) <- c("language", "longitude", "latitude", "region")
#lonlat$sentiment.score <- as.factor(lonlat$sentiment.score)
nr.tweets <- dim(UKdata)[1]






England.data <-subset(UKdata, region == "England")


england.map <- get_map(location='london')
                           
theme_set(theme_bw(16))         
#ggmap(england.map, extent = "normal", darken = .2)

qmap("london", color='bw', legend = "topright")+
    geom_point(aes(x = longitude, y = latitude, colour = language),size=2, 
               alpha=0.8, data = England.data)




#bounding box lowerleftlon, lowerleftlat, upperrightlon, upperrightlat

england.location <- c(-8, 48, 3.5, 58)

england.map <- get_map(england.location, source="stamen", maptype="watercolor", crop=FALSE)
ggmap(england.map)



ggmap(england.map)  + geom_point(aes(x = longitude, y = latitude, colour = language), 
                                 size=2, alpha=0.8, data = UKdata)+
    ggtitle('Languages from UK Tweets during NYE 2015')


