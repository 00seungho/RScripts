install.packages("leaflet")
library(leaflet)

m<-leaflet() %>%
  setView(lng=126.996542, lat= 37.5290615, zoom = 30) %>%
  addTiles()
m


m<-leaflet() %>%
  setView(lng=126.996542, lat= 37.5290615, zoom = 30) %>%
  addTiles()
m
