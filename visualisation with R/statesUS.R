
# This data was downloaded from http://www.arcgis.com/home/item.html?
# id=f7f805eb65eb4ab787a0a3e1116ca7e5
packages <- c("ggplot2", "maptools", "rgeos", "mapproj", "broom", 
              "rgdal", "grid", "dplyr")
lapply(packages, require, character.only = TRUE)

#broom replaces fortify, which might be discontinued in the future

#getting location info of states
all_states <- readOGR("states_21basic/", "states")

all_states <- tidy(all_states, region = "STATE_NAME")



#USA tweets
US1 <- read.csv("US_NYE_1.csv", sep=",", header = FALSE, na.strings = "NA")
US2 <- read.csv("US_NYE_2.csv", sep=",", header = FALSE, na.strings = "NA")
US3 <- read.csv("US_NYE_3.csv", sep=",", header = FALSE, na.strings = "NA")
US12 <- rbind(US1, US2)
USdata <- rbind(US12, US3)
str(USdata)
names(USdata) <- c("language", "longitude", "latitude", "id")
unique(USdata$language)
#checking whether there are any missing values
#first need to convert the state names form factors to characters
USdata$id <- as.character(USdata$id)
USdata[!complete.cases(USdata),] 
#this is the state of California, so let's change it manually
USdata[935,4] <- "California"

#we do not have state info from Virgin ISlands nor Puerto Rico, so let's delete that data
USdata <-filter(USdata, !grepl('Virgin Islands|Puerto Rico', id))


#Languages written explicitly
#temporary placeholders
USdata$language <- as.character(USdata$language)
USdata$language <- sub("en", "aa", USdata$language) 
USdata$language <- sub("ro", "bb", USdata$language) 
USdata$language <- sub("es", "cc", USdata$language) 
USdata$language <- sub("fr", "dd", USdata$language) 
USdata$language <- sub("und", "ee", USdata$language) 
USdata$language <- sub("et", "ff", USdata$language) 
USdata$language <- sub("no", "gg", USdata$language) 
USdata$language <- sub("da", "hh", USdata$language) 
USdata$language <- sub("in", "ii", USdata$language) 
USdata$language <- sub("ru", "jj", USdata$language) 
USdata$language <- sub("ht", "kk", USdata$language) 
USdata$language <- sub("cy", "ll", USdata$language) 
USdata$language <- sub("pt", "mm", USdata$language) 
USdata$language <- sub("nl", "nn", USdata$language) 
USdata$language <- sub("hu", "oo", USdata$language) 
USdata$language <- sub("tr", "pp", USdata$language) 
USdata$language <- sub("cs", "qq", USdata$language) 
USdata$language <- sub("ja", "rr", USdata$language) 
USdata$language <- sub("de", "zz", USdata$language) 
USdata$language <- sub("tl", "tt", USdata$language) ###
USdata$language <- sub("uk", "uu", USdata$language) 
USdata$language <- sub("zh", "vv", USdata$language) 
USdata$language <- sub("it", "ww", USdata$language) 
USdata$language <- sub("ar", "xx", USdata$language) 



USdata$language <- as.character(USdata$language)
USdata$language <- gsub("aa", "English", USdata$language) 
USdata$language <- gsub("bb", "Romanian", USdata$language) 
USdata$language <- gsub("cc", "Spanish", USdata$language) 
USdata$language <- gsub("dd", "French", USdata$language) 
USdata$language <- gsub("ee", "no language detected", USdata$language) 
USdata$language <- gsub("ff", "Estonian", USdata$language) 
USdata$language <- gsub("gg", "Norwegian", USdata$language) 
USdata$language <- gsub("hh", "Danish", USdata$language) 
USdata$language <- gsub("ii", "Indian", USdata$language) 
USdata$language <- gsub("jj", "Russian", USdata$language) 
USdata$language <- gsub("kk", "English", USdata$language) 
USdata$language <- gsub("ll", "Haitian Creole", USdata$language) 
USdata$language <- gsub("mm", "Portuguese", USdata$language) 
USdata$language <- gsub("nn", "Dutch", USdata$language) 
USdata$language <- gsub("oo", "Hungarian", USdata$language) 
USdata$language <- gsub("pp", "Turkish", USdata$language) 
USdata$language <- gsub("qq", "Czech", USdata$language) 
USdata$language <- gsub("rr", "Japanese", USdata$language) 
USdata$language <- gsub("zz", "German", USdata$language) 
USdata$language <- gsub("tt", "Tagalog", USdata$language) ###
USdata$language <- gsub("uu", "Ukrainian", USdata$language) 
USdata$language <- gsub("vv", "Chinese", USdata$language) 
USdata$language <- gsub("ww", "Italian", USdata$language) 
USdata$language <- gsub("xx", "Arabic", USdata$language) 

#convert languages back to factors
USdata$language <- as.factor(USdata$language)

#STATE IDs

unique(USdata$id)
#data was noisy, so need to correct the name of the states, in some cases
USdata$id <- sub('Oregn', 'Oregon', USdata$id) 

USdata$id <- as.factor(USdata$id) 



#confirming the dataframe as the desired struture
str(USdata)
USdata <- arrange(USdata, language)
table(USdata$language)

nr.tweets <- dim(USdata)[1]



# plotting main US area (excluding islands, and Alaska)


mainland.states <- subset(all_states, id != "Alaska" & id != "Hawaii")
tweetsmainland <- subset(USdata, id != "Alaska" & id != "Hawaii")


plot.mainland <- ggplot() + geom_polygon(data=mainland.states,  
    aes(x=long, y=lat, group = group), fill = "gray80", 
    colour="gray80", size = 0.25) + 
    geom_point(data=tweetsmainland, aes(x=longitude, y=latitude, colour=language), alpha=0.4)+
    coord_map(projection="azequalarea")

plot.mainland + ggtitle('Languages from USA Tweets during NYE 2015')



plot.mainland <-   plot.mainland + theme(axis.line=element_blank(),
                 axis.text.x=element_blank(),
                 axis.text.y=element_blank(),
                 axis.ticks=element_blank(),
                 axis.title.x=element_blank(),
                 axis.title.y=element_blank(),
                 panel.background=element_blank(),
                 panel.border=element_blank(),
                 panel.grid.major=element_blank(),
                 panel.grid.minor=element_blank(),
                 plot.background=element_blank())

AKstates <- subset(all_states, id == "Alaska") 
AKtweets <- subset(USdata, id == "Alaska")

plot.AK <- ggplot() + geom_polygon(data=AKstates,  
                                         aes(x=long, y=lat, group = group), 
                                   fill = "gray80", 
                                         colour="gray80", size = 0.25) + 
    geom_point(data=AKtweets, aes(x=longitude, y=latitude, colour=language), alpha=0.4)+
    coord_map(projection="azequalarea") 



plot.AK <-   plot.AK + theme(axis.line=element_blank(),
                                         axis.text.x=element_blank(),
                                         axis.text.y=element_blank(),
                                         axis.ticks=element_blank(),
                                         axis.title.x=element_blank(),
                                         axis.title.y=element_blank(),
                                         panel.background=element_blank(),
                                         panel.border=element_blank(),
                                         panel.grid.major=element_blank(),
                                         panel.grid.minor=element_blank(),
                                         plot.background=element_blank())


HIstates <- subset(all_states, id == "Hawaii") 
HItweets <- subset(USdata, id == "Hawaii")

plot.HI <- ggplot() + geom_polygon(data=HIstates,  
                                   aes(x=long, y=lat, group = group), 
                                       fill = "gray80",
                                   colour="gray80", size = 0.25) + 
    geom_point(data=HItweets, aes(x=longitude, y=latitude, colour=language), 
               alpha=0.4)+
    coord_map(projection="azequalarea")


plot.HI <-   plot.HI + theme(axis.line=element_blank(),
                                         axis.text.x=element_blank(),
                                         axis.text.y=element_blank(),
                                         axis.ticks=element_blank(),
                                         axis.title.x=element_blank(),
                                         axis.title.y=element_blank(),
                                         panel.background=element_blank(),
                                         panel.border=element_blank(),
                                         panel.grid.major=element_blank(),
                                         panel.grid.minor=element_blank(),
                                         plot.background=element_blank())





grid.newpage()
vp <- viewport(width = 1.12, height = 1.12, x=0.45, y=0.6)
print(plot.mainland, vp = vp)
subvp1 <- viewport(width = 0.35, height = 0.35, x = 0.18, y = 0.15)
print(plot.AK, vp = subvp1)
subvp2 <- viewport(width = 0.3, height = 0.3, x = 0.55, y = 0.15)
print(plot.HI, vp = subvp2)




##Mainland map

plot.mainland <- ggplot() + geom_polygon(data=mainland.states,  
                                         aes(x=long, y=lat, group = group), fill = "gray80", 
                                         colour="gray80", size = 0.25) + 
    geom_point(data=tweetsmainland, aes(x=longitude, y=latitude, colour=language), alpha=0.4)+
    coord_map(projection="azequalarea") +
    theme(legend.justification=c(1,0), legend.position="bottom")


plot.mainland <-   plot.mainland + theme(axis.line=element_blank(),
                                         axis.text.x=element_blank(),
                                         axis.text.y=element_blank(),
                                         axis.ticks=element_blank(),
                                         axis.title.x=element_blank(),
                                         axis.title.y=element_blank(),
                                         panel.background=element_blank(),
                                         panel.border=element_blank(),
                                         panel.grid.major=element_blank(),
                                         panel.grid.minor=element_blank(),
                                         plot.background=element_blank())



#Alaska mainland

plot.AK <- ggplot() + geom_polygon(data=AKstates,  
                                   aes(x=long, y=lat, group = group), 
                                   fill = "gray80", 
                                   colour="gray80", size = 0.7) + 
    geom_point(data=AKtweets, aes(x=longitude, y=latitude, colour=language), alpha=0.4)+
    coord_map(projection="azequalarea") 


plot.AK <-   plot.AK + theme(axis.line=element_blank(),
                             axis.text.x=element_blank(),
                             axis.text.y=element_blank(),
                             axis.ticks=element_blank(),
                             axis.title.x=element_blank(),
                             axis.title.y=element_blank(),
                             panel.background=element_blank(),
                             panel.border=element_blank(),
                             panel.grid.major=element_blank(),
                             panel.grid.minor=element_blank(),
                             plot.background=element_blank())



#Hawaii mainland


plot.HI <- ggplot() + geom_polygon(data=HIstates,  
                                   aes(x=long, y=lat, group = group), 
                                   fill = "gray80",#as.numeric(as.factor(piece))), 
                                   colour="gray80", size = 0.7) + 
    geom_point(data=HItweets, aes(x=longitude, y=latitude, colour=language), 
               alpha=0.4)+
    coord_map(projection="azequalarea")


plot.HI <-   plot.HI + theme(axis.line=element_blank(),
                             axis.text.x=element_blank(),
                             axis.text.y=element_blank(),
                             axis.ticks=element_blank(),
                             axis.title.x=element_blank(),
                             axis.title.y=element_blank(),
                             panel.background=element_blank(),
                             panel.border=element_blank(),
                             panel.grid.major=element_blank(),
                             panel.grid.minor=element_blank(),
                             plot.background=element_blank())




#using GGMAP instead

#mainstreaming the data points
main.tweetsmainland <- filter(tweetsmainland, language=='Danish' | language=='English' | 
                                  language=='Estonian' |language=='French' |
                                  language=='Indian' | language=='Japanese' |
                                  language=='Portuguese' |language=='Spanish')
#dropping the factors that no longer appear
main.tweetsmainland$language <- factor(main.tweetsmainland$language)


usa.location <- c(-122, 25, -68, 48)

usa.map <- get_map(usa.location, source="stamen", maptype="watercolor", crop=FALSE)
ggmap(usa.map)



ggmap(usa.map)  + geom_point(aes(x = longitude, y = latitude, colour = language), 
                                 size=2, alpha=0.5, data = main.tweetsmainland)+
    labs(x = 'Longitude', y = 'Latitude') + 
    ggtitle('Tweets sent from mainland U.S.A. during NYE 2015')



