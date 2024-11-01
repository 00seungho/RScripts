library(rvest)
install.packages("RSelenium")
library(RSelenium)
#응용문제 1

url = "https://www.airkorea.or.kr/web/sidoQualityCompare?itemCode=10008&pMENU_NO=102"
html = read_html(url,encoding = "utf-8")
html

content = html_nodes(html, "#sidoTable") %>%
  html_text()

content

