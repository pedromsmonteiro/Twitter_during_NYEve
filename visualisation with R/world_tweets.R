#all NYE data
packages <- c("ggplot2", "dplyr", "maps", "mapdata", "ggmap", "ggplot2")
lapply(packages, require, character.only = TRUE)
library(dplyr)
library(maps)       # Provides functions that let us plot the maps
library(mapdata)    # Contains the hi-resolution maps.
library(ggmap)      # finds longitude and latitude values
library(ggplot2)    # high quality graphing
world1 <- read.csv("coord1.csv", sep=",", header = FALSE)
world2 <- read.csv("coord2.csv", sep=",", header = FALSE)
world3 <- read.csv("coord3.csv", sep=",", header = FALSE)
world12 <- rbind(world1, world2)
coord.points <- rbind(world12, world3)
#lonlat <- cbind(sa_UK,geocode(sa_UK[,1]))
names(coord.points) <- c("longitude", "latitude")
#lonlat$sentiment.score <- as.factor(lonlat$sentiment.score)
nr.tweets <- dim(coord.points)[1]



#bounding box lowerleftlon, lowerleftlat, upperrightlon, upperrightlat

#always works: 
world.location <-  c(-170,-60,170,80)


#plotting
world.map <- get_stamenmap(world.location, zoom = 3, maptype="watercolor")
ggmap(world.map)

ggmap(world.map, extent = "device") + geom_point(aes(x = longitude, y = latitude), 
                                size=1, alpha=0.4, color='darkgreen', data = coord.points)+
    labs(x = 'Longitude', y = 'Latitude') + 
    ggtitle('Tweets sent from all over the world during NYE 2015')


#plotting elleged EU data
ggmap(world.map, extent = "device") + 
    geom_point(aes(x = longitude, y = latitude), size=1, alpha=0.4, color='darkgreen', 
               data = EUdata)+
    labs(x = 'Longitude', y = 'Latitude') + 
    ggtitle('Tweets sent from Europe during NYE 2015')




