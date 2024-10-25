#7장 웹 스크랩핑
install.packages("rvest")
library(rvest)

url = "http://192.168.26.169:70/movie1"
html = read_html(url,encoding = "utf-8")
html

movie = html_nodes(html, "table tr td") %>%
  html_text()
movie


url = "http://192.168.26.169:70/movie2"
html = read_html(url,encoding = "utf-8")
html

moviel = html_nodes(html, "#movie1 tr td") %>%
  html_text()

moviel


url = "http://192.168.26.169:70/movie3"
html = read_html(url,encoding = "utf-8")
html

movie_name = html_nodes(html, "#movie2 tr .title2") %>%
  html_text()
movie_name
