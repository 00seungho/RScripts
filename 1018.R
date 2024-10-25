install.packages("leaflet")
library(leaflet)
library(ggplot2)
m<-leaflet() %>%
  setView(lng=126.996542, lat= 37.5290615, zoom = 30) %>%
  addTiles()
m


m<-leaflet() %>%
  addTiles() %>%
  addMarkers(lng=126.996542, lat= 37.5290615, label = "한국 폴리텍대학", popup = "서울정수캠퍼스 인공지능소프트웨어")

m

m<-leaflet() %>%
  setView(lng=126.993539, lat= 37.5333925, zoom = 30) %>%
  addTiles()
m


# 오늘 내가 수업 끝난 후 갈 장소를 지도에 출력하고 장소이름은 라벨로 표시 주소는 팝업으로 표시
m<-leaflet() %>%
  addTiles() %>%
  addMarkers(lng=126.993539, lat= 37.5333925, label = "면사무소", popup = "서울특별시 용산구 이태원로26길 22") %>%
  addMarkers(lng=126.99354, lat= 37.5334005, label = "빽다방이태원점", popup = "이태원동 66-8번지 1층 용산구 서울특별시 KR")

m

quakes

m = leaflet(data=quakes) %>%
  addTiles() %>%
  addCircleMarkers(~long, ~lat, radius = ~mag, stroke = TRUE, weight = 1, color = "black", fillColor = "red",fillOpacity = 0.3)
m

#지진규모의 크기가 6 이상이면 반지름을 10으로설정하고 6 미만인 지진규모는 반지름을 1로 설정
m = leaflet(data=quakes) %>%
  addTiles() %>%
  addCircleMarkers(~long, ~lat, radius = ~ifelse(mag>=6, 10, 1), stroke = TRUE, weight = 1, color = "black", fillColor = "red",fillOpacity = 0.3)
m

#mag(지진규모)가 5.5이상이면 반지름을 10, 그렇지 않으면 0
#mag(지진규모)가 5.5이상이면 테두리선의 굵기를 1 그렇지 않으면 0
#mag(지진규모)가 5.5이상이면 불투명도를 0.3 그렇지 않으면 0
m = leaflet(data=quakes) %>%
  addTiles() %>%
  addCircleMarkers(
    ~long, ~lat, 
    radius = ~ifelse(mag >= 5.5, 10, 0),  
    stroke = TRUE, 
    weight = ~ifelse(mag >= 5.5, 1, 0),
    color = "black", 
    fillColor = "red",
    fillOpacity = ~ifelse(mag >= 5.5, 0.3, 0)  
  )
m

#mag 6이상 반지름10, 5.5 이상이면 5, 아니면 0
#mag 가 5.5이상 테두리 굵기 1 아님 0
#mag 5.5이상이면 불투명도 0.3 아님 0
#mag 6이상이면 배경색 red, 5.5이상이면 green, 아니면 색이 없이
m = leaflet(data=quakes) %>%
  addTiles() %>%
  addCircleMarkers(
    ~long, ~lat, 
    radius = ~ifelse(mag >= 6, 10, ifelse(mag >= 5.5, 5, 0)), 
    stroke = TRUE, 
    weight = ~ifelse(mag >= 5.5, 1, 0), 
    color = "black", 
    fillColor = ~ifelse(mag >= 6, "red", ifelse(mag >= 5.5, "green", "transparent")), 
    fillOpacity = ~ifelse(mag >= 5.5, 0.3, 0)
  )
m

install.packages("sf")
library(sf)

df_map = st_read("D:/R_data/행정경계데이터셋/Z_NGII_N3A_G0010000.shp")
ggplot(data=df_map)+
  geom_sf(aes(fill="white"), color = "black")

if(!"id"%in%names(df_map)){
  df_map$id = 1:nrow(df_map)
}

ggplot(data=df_map)+
  geom_sf(aes(fill=id), alpha=0.3, color="black")+
  theme(legend.position="none")
  labs(x="경도",y="위도")
  
install.packages("openxlsx")
library(openxlsx)

df = read.xlsx("D:/R_data/행정경계데이터셋/국내지진목록.xlsx", sheet=1, startRow = 4, colNames = FALSE)
head(df)

# X8열에서 북한으로 시작하는 데이터의 행번호 추출
idx = grep("^북한", df$X8)
# 북한 지역의 x8열의 데이터를 확인
df[idx, "X8"]
# X8열에 북한으로 시작하는 행 삭제
df = df[-idx,]



df
#df에 있는 6열과 7열의 데이터중 N과 E를 삭제하는 방법
df[, 6] = gsub("N", "", df[, 6])
df[, 7] = gsub("E", "", df[, 7])


#6, 7열의 값을 숫자형으로 변환
df[, 6] = as.numeric(df[, 6])
df[, 7] = as.numeric(df[, 7])


df[,6]

# shapefile  읽어오기
map = st_read("C:/Users/AISW-509-185/Downloads/행정경계데이터셋/Z_NGII_N3A_G0010000.shp")

#WGS84 좌표계로 변환
map = st_transform(map, crs=4326)

#포인트 데이터를 sf 객체로 변환
df_sf = df%>%
  st_as_sf(coords = c("X7", "X6"), crs = 4326)


ggplot() + 
  geom_sf(data = map, fill="white", alpha = 0.5, color="black") + 
  geom_sf(data = df_sf, aes(size=X3), shape=21, fill="red", alpha = 0.3, color="black") 




