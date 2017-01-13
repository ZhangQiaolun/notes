setwd("C:/BA/PCA")
Cereals <- read.csv("Cereals.csv", header=TRUE, sep=",")
Cereals_pca <-prcomp(Cereals[,c("calories","rating")],scale = TRUE)
#���ɷַ�����scale=TRUE��ζ�����ȶԱ������б�׼��֮���������ɷַ�����
#�˴�ֻ��2����������calories��rating�������ɷַ�����
print(Cereals_pca)
#��ʾcalories��rating��2�����ɷ��е�Ȩ��ֵ��
summary(Cereals_pca)
#�ӽ��������һ�����ɷֲ�׽��84.47%���ܷ�����ϵڶ������ɷ���׽��100%���ܷ��
Cereals_pca <-prcomp(na.omit(Cereals[,4:16]),scale = FALSE)
#��Cereals���еĵ�4����������16�������������ɷַ���������û�н��б�׼����
#na.omit������ʹ����ζ�Ž������ɷַ���ʱ�Զ�ɾ����ȱʧ���ݵļ�¼��
print(Cereals_pca)
#��ʾ��Щ�����ڸ������ɷ��е�Ȩ��ֵ��
summary(Cereals_pca)
#�ӽ������2�����ɷּ��ɲ�׽��92.62%���ܷ��
Cereals_pca <-prcomp(na.omit(Cereals[,4:16]),scale = TRUE)
#ͬ���Ե�4����������16�������������ɷַ����������ݽ����˱�׼����
print(Cereals_pca)
summary(Cereals_pca)
#�ӽ������Ҫ��7�����ɷֲ��ܲ�׽��90%���ϵĵ��ܷ����7��������׽��93.026%���ܷ��
(Cereals$calories-mean(Cereals$calories))/sd(Cereals$calories)
scale(Cereals$calories)
#������ʾ����ı�׼������֮��Ľ����ʹ��scale���������Ľ����ͬ��
#����scale�����Ƕ����ݽ��б�׼��������һ���ܺ��õĺ�����