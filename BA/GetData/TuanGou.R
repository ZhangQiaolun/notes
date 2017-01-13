library(XML)

setwd('D:/BA/GetData')
#MyPath <- Sys.getenv("PATH")
#MyPath
#��鿴path������û��phantomjs.exe���ڵ�Ŀ¼��D:\BA\GetData
#���û������Ҫ��ϵͳpath���м����Ŀ¼
#if (is.na(str_match(MyPath,'D:\\\\BA\\\\GetData'))) 
#{ Sys.setenv(PATH=paste0(MyPath,'D:\\BA\\GetData;')) } else {};
#Sys.getenv("PATH")

MyScrapeJS <- function(MyURL){
  ## change Phantom.js scrape file
  lines <- readLines("ScrapePage.js")
  lines[1] <- paste0("var url ='", MyURL,"';")
  writeLines(lines, "ScrapePage.js") }

MyScrapeJS('http://hefei.lashou.com/')
system("phantomjs ScrapePage.js")
doc <- htmlParse('MyPage.html')
xpathSApply(doc, "//a[@class='index-goods-name']", xmlValue)

MyScrapeJS('http://shanghai.lashou.com/')
system("phantomjs ScrapePage.js")
doc <- htmlParse('MyPage.html')
xpathSApply(doc, "//a[@class='index-goods-name']", xmlValue)

MyScrapeJS('http://www.oddsportal.com/hockey/usa/nhl-2013-2014/carolina-hurricanes-ottawa-senators-80YZhBGC/')
system("phantomjs ScrapePage.js")
doc <- htmlParse('MyPage.html')
readHTMLTable(doc, header=TRUE, which=1,stringsAsFactors=F)

MyScrapeJS('http://v6.bang.weibo.com/czv/caijing?period=month')
system("phantomjs ScrapePage.js")
doc <- htmlParse('MyPage.html')
xpathSApply(doc, "//dd[@class='name']", xmlValue)
xpathSApply(doc, "//dd[@class='intro_ve']", xmlValue)
xpathSApply(doc, "//span[contains(@data-reactid,'.0.3.1.0')]", xmlValue)