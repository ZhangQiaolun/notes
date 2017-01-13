library(caret)
setwd("D:/BA/KNN")
RidingMowers <- read.csv("RidingMowers.csv",header = TRUE)

Predictors <- RidingMowers[,c("Income","Lot_Size")]

model <- train(
  Predictors, RidingMowers[,"Ownership"],
  method='knn',
#�������г�Predictors, Ȼ���ǽ��������Ȼ��˵��ʹ��KNN������
  tuneGrid = data.frame(k=1:17),
#KNNģ�͵���k��ȡֵ��Χ��1��17��
  metric='Accuracy',
#����ָ���ǡ�׼ȷ�ʡ� Accuracy
  trControl=trainControl(
    method='repeatedcv', 
    number=4, 
    repeats=20) )
#trControl �Ƕ�ѵ�����̽��п��Ƶĺ������˴���method='repeatedcv'��˼��ʹ��repeated cross validation
#�������ظ�������֤����number=4��ʾ��4-fold cross validation����˼�ǰ����ݼ����4�飬Ȼ����4��
#ѵ������֤��ÿ�ζ�ȡ����һ�����ݣ�1/4�����ݣ�����֤���ݼ���ʣ�µĵ�ѵ�����ݼ���repeat=30��ʾ�����
#�����ظ�20�Σ����ܹ�Ҫ��80��ѵ��-��֤�����ռ�������ָ�꣨�˴���Accuracy����ƽ��ֵ��

model
plot(model)
confusionMatrix(model)

Predictors_Example <- data.frame(Income=80, Lot_Size=20)
predict(model$finalModel,Predictors_Example)