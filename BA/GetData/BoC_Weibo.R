library(XML)
library(selectr)
setwd("d:/BA/GetData")
url = 'http://www.boc.cn/sourcedb/whpj/'
Rates = readHTMLTable(url, header=TRUE, which=2,stringsAsFactors=F)
fix(Rates) #����ͷ�����룬������Ҫ���¶������ͷ���������롣
names(Rates) <- c('��������','�ֻ������','�ֳ������','�ֻ�������','�ֳ�������',
                  '���������','��������','����ʱ��')
fix(Rates)
#R���Դ���������ʱ���������룬�����������ֹ�������ȷ�ı���ͷ�������������Զ����롣
#Ч��������������һ���ġ�
doc = htmlParse(url)  #��ȡ��ҳԴ����
t_heads <- xpathSApply(doc, "//th", xmlValue)  #��ȡ����ͷ��Ϣ��

#xpathSApply(doc, "/html/body/div/div[5]/div[1]/div[2]/table/tbody/tr[1]/th[1]", xmlValue)
#�ӹȸ����������360������ﵼ����xPath���󣬶���һ��/tbody������div[5]Ӧ����div[3]��
#������ʹ��htmlParse����������ҳԴ���ʱ������˱䶯��
#xpathSApply(doc, "/html/body/div/div[3]/div[1]/div[2]/table/tr[1]/th", xmlValue)
#���ʹ��xPathʱ��һ�������ص�Դ��Ϊ׼��
querySelectorAll(doc, "body > div > div.BOC_main > div.publish > div:nth-child(3) > 
                 table  > tr:nth-child(1) > th")

t_heads #������ͷ�ǲ���������Ҫ�Ľ����
names(Rates) <- t_heads #������ͷ��Ϣ��ֵ�����ݿ�Rates�ı���ͷ��
write.csv(Rates, file = 'ExRates.csv', row.names = FALSE) #�����ݿ�Rates������д��ExRates.csv

fileName <- 'd:/BA/GetData/Weibo_HTML.txt'
doc <- htmlParse(fileName)
#url = 'http://bang.weibo.com/renwu'
#doc = htmlParse(url)  #��ȡ��ҳԴ����
names <- xpathSApply(doc, "//dd[@class='name']",xmlValue) #��ȡ����
names

influence <- xpathSApply(doc, "//dd[@class='influence']",xmlValue) 
influence
influence <- gsub('Ӱ������','',influence) #ȥ����Ӱ�졯������
influence <- gsub('��','',influence) #ȥ��'��'һ����
influence <- as.numeric(influence) #���ַ�����ʽת�������ָ�ʽ
influence

WeiboURLs <- xpathSApply(doc, "//section", xmlGetAttr, "data-url") #��ȡ΢�����ӵ�ַ��
WeiboURLs <- unlist(WeiboURLs)
WeiboURLs
#����չʾ�����ʹ��unlist����������ֻ��Ҫ��һ����伴����ȡ���е�΢�����ӵ�ַ��
xpathSApply(doc, "//section[@class='list_info']", xmlGetAttr, "data-url") #��ȡ΢�����ӵ�ַ��

shortbio <- xpathSApply(doc, "//dd[@class='bio']",xmlValue)  #��ȡ΢����顣
shortbio

imgs <- xpathSApply(doc, '//img', xmlGetAttr, "src") #��ȡ΢�����а��ϸ���΢����ͼƬ����
imgs

WeiboData <- data.frame(Ranking = c(1:20), Names = names, Influence = influence, 
                        WeiboURLs = WeiboURLs, Icons = imgs, Shortbio = shortbio, 
                        stringsAsFactors=FALSE)
write.csv(WeiboData, file = 'Weibo.csv', row.names = FALSE)