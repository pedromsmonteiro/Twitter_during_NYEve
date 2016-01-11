#all NYE data
packages <- c("ggplot2", "dplyr", "maps", "mapdata", "ggmap", "ggplot2")
lapply(packages, require, character.only = TRUE)
library(dplyr)
library(maps)       # Provides functions that let us plot the maps
library(mapdata)    # Contains the hi-resolution maps.
library(ggmap)      # finds longitude and latitude values
library(ggplot2)    # high quality graphing
EU1 <- read.csv("EU_1.csv", sep=",", header = FALSE)
EU2 <- read.csv("EU_2.csv", sep=",", header = FALSE)
EU3 <- read.csv("EU_3.csv", sep=",", header = FALSE)
EU12 <- rbind(EU1, EU2)
EUdata <- rbind(EU12, EU3)
#lonlat <- cbind(sa_UK,geocode(sa_UK[,1]))
names(EUdata) <- c("language", "longitude", "latitude", "region")
#lonlat$sentiment.score <- as.factor(lonlat$sentiment.score)
nr.tweets <- dim(EUdata)[1]



#bounding box lowerleftlon, lowerleftlat, upperrightlon, upperrightlat

europe.location <- c(-25, 36, 58, 67)


#plotting
europe.map <- get_map(europe.location, source="stamen", maptype="watercolor", crop=FALSE)
ggmap(europe.map)



ggmap(europe.map)  + geom_point(aes(x = longitude, y = latitude, colour = language), 
                                 size=2, alpha=0.6, data = EUdata)+
    labs(x = 'Longitude', y = 'Latitude') + 
    ggtitle('Tweets sent from European countries during NYE 2015')



ggmap(europe.map)  + geom_point(aes(x = longitude, y = latitude), 
                                size=2, alpha=0.6, data = EUdata)+
    labs(x = 'Longitude', y = 'Latitude') + 
    ggtitle('Tweets sent from European countries during NYE 2015')





