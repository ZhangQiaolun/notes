library(dplyr) #for the function 'arrange','group_by','summarise'
library(ggplot2)
setwd("D:/BA/Visualization")
Sales <- read.table('Salesdata.csv',header=T,sep=',',stringsAsFactors=FALSE)
#���������ǽ���ͬ���ڵ��������ܲ��浽�µı���Sales_Merge 
Sales_Merge <- aggregate(Order.Qty ~ Order.Date, data = Sales, sum)
#Sales_Merge <- aggregate(Sales$Order.Qty, list(Sales$Order.Date), sum)
#colnames(Sales_Merge) <- c("Order.Date","Order.Qty")

Sales_Merge$Order.Date <- as.Date(Sales_Merge$Order.Date,"%m/%d/%Y")
#�����ڱ����ĸ�ʽ�ĳ� 12/21/2011 �����ĸ�ʽ��
Sales_Merge <- arrange(Sales_Merge,Order.Date)
#���ݶ������ڶ�Sales_Merge��������

Sales2 <- data.frame(Sales_Merge, MonDay = format.Date(Sales_Merge$Order.Date,"%m-%d"))
#Sales2 �� Sales_Merge �м����µ�һ��MonDay��ȡֵΪ����ʱ��� �·�-������06-23
Sales2 <- data.frame(Sales2,Year = as.factor(format.Date(Sales2$Order.Date,"%Y")))
#Sales2 ���������µ�һ��Year��ȡֵΪ����ʱ�����ݣ����Ұ������Ϊ����ͱ�����
#��Ϊ���滭ͼ��ʱ��Ҫ������ݲ�ͬ������ͬ����ͼ��������Ӧ��������ͱ�����

g <- ggplot(Sales2, aes(x=MonDay, y=Order.Qty, group=Year,colour  = Year)) + geom_line() 
#x�������ڣ���-�գ���y���Ƕ�������������ݽ��з��飬����ͼ��
g + scale_colour_brewer(palette="Set2")
#ʹ��Set2��ɫ��
g + scale_colour_manual(values = c("#E69F00", "#56B4E9", "#009E73", 
                                   "#F0E442", "#0072B2", "#D55E00")) 
#�Զ�����ɫ
g + scale_colour_manual(values = c("blue4", "brown4", "darkgoldenrod1", 
                                   "darkgreen", "deeppink2", "mediumturquoise"))

Sales3 <- data.frame(Sales2, Month = as.factor(format.Date(Sales2$Order.Date,"%m")))
#��Sales2���в����µ�һ��ΪMonth�·ݣ�׼�����·ݽ������������ܡ�
Sales4 <- aggregate(Order.Qty ~ Month + Year, data = Sales3, sum)
#������ݺ��·ݶ����������л��ܡ�
g <- ggplot(Sales4, aes(x=Month, y=Order.Qty, group = Year, colour  = Year)) + geom_line() 
g + scale_colour_manual(values = c("blue4", "brown4", "darkgoldenrod1", 
                                   "darkgreen", "deeppink2", "mediumturquoise"))

idx <- which(Sales4[,"Year"] %in% c(2004,2005,2006))
#ֻ��2004-2006������ݡ�
Sales5 <- Sales4[idx,]
g <- ggplot(Sales5, aes(x=Month, y=Order.Qty, group = Year, colour  = Year)) + geom_line() 
g + scale_colour_manual(values = c("blue4", "brown4", "darkgoldenrod1", 
                                   "darkgreen", "deeppink2", "mediumturquoise"))