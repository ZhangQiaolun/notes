setwd("D:/BA/LinearRegression")
#���ù���Ŀ¼
year <- rep(2008:2010, each=4)
quarter <- rep(1:4, 3)
cpi <- c(162.2, 164.6, 166.5, 166.0,
         166.2, 167.0, 168.6, 169.5,
         171.0, 172.1, 173.3, 174.0)
plot(cpi, xaxt="n", ylab="CPI", xlab="")
# xaxt = "n" ��ʾ����x���ticks����ֵ��ǣ���xlab��ylab��x���
# y������ƣ��������ʹ��?par���������ļ���
axis(1, labels=paste(year,quarter,sep="Q"), at=1:12, las=3)
# ��x��ı�ǩ��һ������1��ʾ��x���ǣ������2���ʾ��y�ᡣ
# labels=paste(year,quarter,sep="Q") ���ɱ�ǩ�ַ���
cor(year,cpi)
cor(quarter,cpi)
fit <- lm(cpi ~ year + quarter)
# lm�����������Իع顣cpi ~ year + quarter�ǻع�ģ�͡�
fit
names(fit)
fit$coefficients
fit$residuals
fit$fitted.values # predicted values
fit$model
anova(fit) # anova table
vcov(fit) # covariance matrix for model parameters
confint(fit, level=0.95) # Confidence Intervals (CIs) for model parameters 
summary(fit)
# diagnostic plots 
plot(fit)
layout(matrix(c(1,2,3,4),2,2)) # optional 4 graphs/page 
plot(fit)
dev.off()
#�����ģ����ϼ�http://www.statmethods.net/stats/rdiagnostics.html
fit2 <- lm(cpi ~ year)
anova(fit, fit2) #ʹ��F����Ƚ�2��ģ���Ƿ�ͬ�������ʾ����ģ��������ͬ����һ��ģ��RSS����Ҳ�ͽϺá�
anova(fit, fit2, test="Chisq") 
#ʹ��ChiSquare����Ƚ�2��ģ���Ƿ�ͬ�������ʾ����ģ��������ͬ����һ��ģ��RSS����Ҳ�ͽϺá�
#���½���Ԥ��
data2011 <- data.frame(year=2011, quarter=1:4)
data2011
cpi2011 <- predict(fit, newdata=data2011)
cpi2011
style <- c(rep(1,12), rep(2,4)) #����2011��Ԥ��ֵ�ĵ��Style����ɫ��
plot(c(cpi, cpi2011), xaxt="n", ylab="CPI", xlab="", pch=style, col=style)
axis(1, at=1:16, las=3,
     labels=c(paste(year,quarter,sep="Q"), "2011Q1", "2011Q2", "2011Q3", "2011Q4"))