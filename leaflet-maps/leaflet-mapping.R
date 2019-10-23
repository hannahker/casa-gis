library(leaflet)
library(readr)
library(classInt)

# get some data
murals <- read_csv("Montreal/murals.csv")

murals
summary(murals)

# make breaks in the data
breaks<-classIntervals(murals$annee, 
                       n=5, 
                       style="jenks")
breaks

# just keep the breaks 
breaks <- as.numeric(breaks$brks)

# create new palette 
pal <- colorBin(palette = "YlOrRd", 
                domain = murals$annee,
                #create bins using the breaks object from earlier
                bins = breaks)

# make a murals map
murals_map <- leaflet(murals) %>%
  addCircleMarkers(radius = 7, lng = ~longitude, lat = ~latitude, popup = paste0("<img width = '200px'; src = ", murals$image, "><p>Artist(s): <b>", murals$artiste, "</b></p><p>Address: <b>", murals$adresse, "</b></p>"), color = ~pal(annee)) %>%
  addProviderTiles(providers$Stamen.Toner) %>%
  addLegend("bottomright", 
            pal= pal, 
            values = ~annee, 
            title = "Year", 
            opacity = 1,
            labFormat = labelFormat(big.mark = "")
  )

# display the map
murals_map


