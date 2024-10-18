install.packages("readxl")
install.packages("ggplot2")
install.packages("gifski")
install.packages("gganimate")
install.packages("transformr")

library(gganimate)
library(ggplot2)
library(readxl)
library(gifski)
library(dplyr)

#오늘 날짜에 대한 지역별 미세먼지 농도
df <- read_xls("sidoAirInfo.xls",range="A4:E21",col_names = TRUE)
df

df= df %>% mutate(across(일평균, as.numeric))

transposed_dfanim = ggplot(df, aes(x=지역,y=일평균,fill=지역))+
  geom_bar(stat='identity')+
  labs(title="오늘 날짜에 대한 지역별 미세먼지 농도")+
  transition_states(지역)

anim = animate(transposed_dfanim, width=700, height=500,duration=5,renderer=gifski_renderer(loop=FALSE))
anim
anim_save("오늘 날짜에 대한 지역별 미세먼지 농도.gif")


#일주일 동안의 지역별 미세먼지 농도
df2 <- read_xls("sidoAirInfo_7days.xls",range="A4:C123",col_names = TRUE)
df2

df2= df2 %>% mutate(across(평균, as.numeric))

df2 <- df2 %>%
  mutate(
    날짜 = as.Date(날짜)       # 날짜 열을 날짜 형식으로 변환
  )

df2

anim2 = ggplot(df2,aes(x=날짜,y=평균,group=지역))+
  geom_line(aes(color=지역),size=2)+
  geom_point(aes(color=지역),size=5,alpha=0.5)+
  labs(title="지역별 일주일 미세먼지 농도",x="일",y="미세먼지 농도")+
  transition_reveal(날짜)+
  scale_x_date(date_breaks = "1 day", date_labels = "%Y-%m-%d")
  
animate(anim2,width=900,height=700,duration = 5, renderer=gifski_renderer(loop=FALSE))
anim_save("지역별 일주일 미세먼지 농도.gif")
