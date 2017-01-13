library("neuralnet")
setwd("D:/BA/NN")
dataset <- read.csv("creditset.csv")
head(dataset)

## extract a set to train the NN
trainset <- dataset[1:800, ]

## select the test set
testset <- dataset[801:2000, ]

## build the neural network (NN)
creditnet <- neuralnet(default10yr ~ LTI + age, trainset, hidden = 4, lifesign = 'minimal', 
                       linear.output = FALSE, threshold = 0.1)
#ģ�ͣ��������LTI��age���������default10yr�����ز���4���ڵ㣬lifesign��ѡ��Ĳ���
#��'minimal'��'full'��'none' ��ʾ���й�������Ϣ����ķḻ�̶ȡ�
#linear.output��ʾ�Ƿ����������Ĭ�ϵ�ʹ��logistic�������з����Դ�����
#���ѡ��TRUE��ֱ��������ز�ļ�Ȩ�͡����ѡ��FALSE��Ҫ�Լ�Ȩ����logistic����������
#threshold ��ʾ�����Ȩ�ص�ƫ��������ʲôʱ��ֹͣ������ѡ��0.1��Ĭ����0.01��
## plot the NN
plot(creditnet, rep = "best")
## test the resulting output
temp_test <- subset(testset, select = c("LTI", "age"))

creditnet.results <- compute(creditnet, temp_test)
results <- data.frame(actual = testset$default10yr, prediction = creditnet.results$net.result)
results[100:115, ]
results$prediction <- round(results$prediction)
results[100:115, ]
table(results)