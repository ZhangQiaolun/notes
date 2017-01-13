setwd("D:/BA/LinearRegression")
ToyotaData <- read.csv("TOyotaCorolla.csv",header = TRUE)

#���Fuel_Type�ͱ�����Factor�ͱ����������Իع��ʱ��R�Զ������ֱ����������������
ToyotaModel <- ToyotaData[,c("Price","Age_08_04","KM","Fuel_Type","HP","Met_Color",
                         "Automatic","cc","Doors","Quarterly_Tax","Weight")]
ToyotaModel <-na.omit(ToyotaModel)
Numeric_cc<-as.character(ToyotaModel[,"cc"]) #�����Ȱ�factor�ͱ���ת�����ַ��ͱ���
Numeric_cc<-sub(',','',Numeric_cc) #Ȼ��ȥ������Ķ���
Numeric_cc<-as.numeric(Numeric_cc) #������ת������ֵ��
ToyotaModel[,"cc"]<-Numeric_cc #������ֵ����cc�С�
summary(ToyotaModel[,"Fuel_Type"]) #��Fuel_Type�����ڴ���NAֵ�����°����е�NA��Ϊһ��factor��
#�Ѱ���NA����ɾ��֮��Fuel_Type����NA���Ӧ��factor level��û����ʧ�����Կ��Կ���countֵΪ0�Ŀ�level��
ToyotaModel[,"Fuel_Type"] <- droplevels(ToyotaModel[,"Fuel_Type"]) #�Ѹ�Levelɾ����
summary(ToyotaModel[,"Fuel_Type"])
fit <- lm(Price ~ ., data = ToyotaModel)
summary(fit)

ToyotaData <- read.csv("TOyotaCorolla.csv",header = TRUE,stringsAsFactors=FALSE)
#�����stringsAsFactors���ó�FALSE����ôcc�еõ������ַ��ͱ�����Fuel_Type�õ���Ҳ���ַ��ͱ�����
#����Ĳ����У���Ȼ��Ҫ��cc��ת������ֵ�ͱ�����������Ҫ��Fuel_Type��ת����Factor�ͱ�����

ToyotaModel <- ToyotaData[,c("Price","Age_08_04","KM","Fuel_Type","HP","Met_Color",
                             "Automatic","cc","Doors","Quarterly_Tax","Weight")]
ToyotaModel <-na.omit(ToyotaModel)
Numeric_cc<-ToyotaModel[,"cc"]  #��cc����ȡ��������������ת�����ַ��ͱ���
Numeric_cc<-sub(',','',Numeric_cc) #Ȼ��ȥ������Ķ���
Numeric_cc<-as.numeric(Numeric_cc) #������ת������ֵ��
ToyotaModel[,"cc"]<-Numeric_cc #������ֵ����cc�С�
is.factor(ToyotaModel[,"Fuel_Type"])
ToyotaModel[,"Fuel_Type"]=as.factor(ToyotaModel[,"Fuel_Type"])
fit <- lm(Price ~ ., data = ToyotaModel)
summary(fit)

library(ggplot2)
ToyotaCount = c(1:nrow(ToyotaModel))
ggplot(ToyotaModel) + geom_point( aes(x=ToyotaCount, y = sort(Price)) ,size=2,colour="black")+
  geom_point( aes(x=ToyotaCount, y = sort(fit$fitted)),size=2,colour="red") + xlab("") + ylab("") +
  annotate("text", x=1000, y=10000, size=10, label="Price")+
  annotate("text", x=1100, y=14000, size=10, colour="red",label="Fitted Price")

ggplot(ToyotaModel) + geom_point( aes(x=ToyotaCount, y = sort(Price), colour="Price")) +
  geom_point( aes(x=ToyotaCount, y = sort(fit$fitted), colour="Fitted Price") ) +  xlab("") + ylab("") +
  scale_colour_manual("", breaks = c("Price", "Fitted Price"),
                      values = c("black", "red"))

#����չʾ����forward selection, backward elemination��both directions��ʽѡ��Ԥ�����ӡ�
library(MASS)
min_model = lm (Price ~ 1, data = ToyotaModel)
biggest <- formula(lm(Price ~ ., data = ToyotaModel))
stepf <- stepAIC(min_model, direction="forward",scope=biggest) #forward selection
stepf$anova # display results

max_model = lm (Price ~ ., data = ToyotaModel)
stepb <- stepAIC(max_model, direction="backward") #backward elemination
stepb$anova # display results

stept <- stepAIC(lm (Price ~ Age_08_04 + KM + Fuel_Type + cc, data = ToyotaModel), 
                 direction="both",scope=biggest) #both directions
stept$anova # display results

stept <- stepAIC(lm (Price ~ Age_08_04 + KM + Fuel_Type + cc, data = ToyotaModel), 
                 direction="both",scope=biggest,k=4) #both directions
#kֵ�Ƕ�Ԥ�����Ӹ����ĳͷ��ȣ�kԽ���Ԥ�����Ӹ����ͷ�Խ��
#kֵĬ��Ϊ2�����������ߵ�4�������Ԥ�����Ӹ������١�
stept$anova # display results
summary(stept)

# All Subsets Regression
library(leaps)
sapply(ToyotaModel, class)
leaps<-regsubsets(Price~.,data=ToyotaModel,nbest=6)
# view results 
summary(leaps)
# plot a table of models showing variables in each model.
# models are ordered by the selection statistic.
plot(leaps,scale="adjr2") #Adjusted R-Square
plot(leaps,scale="Cp") #Colin Lingwood Mallows' Cp