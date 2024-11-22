options("install.lock"=FALSE)
install.packages("RCurl")
install.packages("RmecabKo")
install.packages("wordcloud2")

library(RCurl)
library(XML)
library(wordcloud2)
library(RmecabKo)

# 형태소분석을 위한 기능 설치
install_mecab("C:/RmecabKo/mecab")

searchUrl = "https://openapi.naver.com/v1/search/blog.xml"
Client_ID = "QfEXZ2kHkdH9exIHjJCt"
Client_Secret = "Q5wtHM9zdo"

# 검색하고자 하는 키워드를 한글일 경우 UTF-8로 인코딩 설정
query = URLencode(iconv("일본 여행 후기", "UTF-8"))
url = paste(searchUrl, "?query=", query, "&display=20", sep = "")
url

doc = getURL(url, httpheader=c('Content-Type'="application/xml", 'X-Naver-Client-Id'=Client_ID, 'X-Naver-Client-Secret'=Client_Secret))
doc

# XML 구조로 변환
xmlFile = xmlParse(doc)
xmlFile

# XML 파일의 <item> 태그를 기준으로 데이터프레임으로 변환
df = xmlToDataFrame(getNodeSet(xmlFile, "//item"))
df
str(df)

df
str(df)

# 전체 내용 중에서 description 컬럼의 값만 추출
description = df[, 4]
description

description2 = gsub("\\d|<b>|</b>|&quot;", "", description)
description2

# 블로그 내용 중에 명사만 추출
nouns = nouns(iconv(description2, "utf-8"))
nouns

# 블로그 한 개당 나누어져 있는 벡터를 하나의 벡터로 통합
nouns.all = unlist(nouns, use.names = F)
nouns.all

# 글자수가 2글자 이상인 단어만 추출
nouns.all.2 = nouns.all[nchar(nouns.all) >= 2]
nouns.all.2

# 단어들의 빈도수
nouns.freq = table(nouns.all.2)
nouns.freq

# 단어들의 빈도수를 데이터프레임으로 변환
nouns.df = data.frame(nouns.freq)
nouns.df

# 데이터프레임의 값 중에서 빈도수를 기준으로 내림차순 정렬
nouns.df.sortdesc = nouns.df[order(-nouns.df$Freq), ]
nouns.df.sortdesc

# 워드 클라우드를 사용하여 빈도수에 따른 단어들을 시각화
wordcloud2(nouns.df.sortdesc, size = 3, rotateRatio = 0.5)

