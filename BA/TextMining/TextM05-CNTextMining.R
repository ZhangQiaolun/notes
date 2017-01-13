library(tm)   #�ı��ھ�
library(wordcloud) #���ƴ���
library(Rwordseg)  #���ķִ�
library(slam) #for function row_sums
library(lda)
library(topicmodels)

setwd('D:/BA/TextMining/Corpus/CNSample')
csv <- read.csv("TXTCorpus.csv",header=T, stringsAsFactors=F)
mystopwords<- unlist (read.table("D:/BA/TextMining/CN_StopWords.txt",stringsAsFactors=F))

#�Ƴ����� 
removeNumbers = function(x) { return(gsub("[0-9��������������������]","",x)) } 
removeNumbers('00��������Hello') #���Ժ�����
removeNonBreakingSpace = function(x) { return(gsub("&nbsp;","",x)) } #�Ƴ��ı��е�&nbsp;
#���ķִʣ�Ҳ���Կ���ʹ�� rmmseg4j��rsmartcn 
wordsegment<- function(x) { segmentCN(x, returnType = "tm") }
wordsegment('����û�в���,ÿһ�춼���ֳ�ֱ����') #���Ժ�����

#�Ƴ�����Ϊ1�������ַ�������ֹͣ�ʣ���ûʲô����Ĵʣ���
removeSingleANDStopWords = function(x, stopwords) 
{ return_text = character(0)  #����һ�����ַ�����
  `%not_in%` <- Negate(`%in%`) #������������������С�
  Strings <- unlist(strsplit(x,' ')) #�����ַ�����ɢ��һ�����ʡ�
  index <- 1 
  it_max <- length(Strings) 
  while (index <= it_max) { 
    if ((nchar(Strings[index])>1) && (Strings[index] %not_in% stopwords))
      return_text <- paste(return_text,Strings[index]) 
    #�����(index)���ʳ��ȴ���1�����Ҳ���ͣ�ʱ��У����������ַ����С�
    index <- index +1 } #���������һ���ʡ�
  return_text <- substr(return_text, 2, nchar(return_text)) #�Ƴ����ַ���ǰ��ĵ�һ���ַ������ո�
  return(return_text) }
removeSingleANDStopWords('���� û�� ���� ÿ һ�� �� �� �ֳ� ֱ��',mystopwords)

sample.words <- sapply(csv$text, removeNumbers)  #�Ƴ����� 
sample.words <- sapply(sample.words, removeNonBreakingSpace) 
sample.words <- sapply(sample.words, wordsegment) #���ķִ�
names(sample.words) <- (1:length(sample.words))

#�ȴ������ķִʣ��ٴ��� stopwords����ֹȫ���滻��ʧ��Ϣ������һ������ʱ�ϳ���
sample.words <- sapply(sample.words, removeSingleANDStopWords, mystopwords)
sample.words[1] 

corpus <- Corpus(VectorSource(as.character(sample.words))) #�������Ͽ⡣
meta(corpus,"cluster") <- csv$type #�����Ͽ��е��ı��ӱ�ǩ����ǩ���������Ѿ��˽�����ǵ����͡�
unique_type <- unique(csv$type)
unique_type

#�����ĵ�-�������󣬴ʵĳ�������Ϊ2��
sample.dtm <- DocumentTermMatrix(corpus, control = list(wordLengths = c(2, Inf)))
#��������-�ĵ����󣬴ʵĳ�������Ϊ2��
sample.tdm <- TermDocumentMatrix(corpus, control = list(wordLengths = c(2, Inf)))
tdm_matrix <- as.matrix(sample.tdm) #������-�ĵ������þ�����ʽ���
tail(tdm_matrix) #�ɼ��þ�����β�������ݣ���ʾ����������100���ĵ��г��ֵĴ�����
write.csv(tdm_matrix,file='tdmMatrix.csv')
#��C:\BA\TextMining\Corpus\CNSample\tdmMatrix.csv�ļ���
#���Է���R��tm����ʶ������ʱ�����һЩ����
#�����310�еĴ��ǡ������� ���ݡ�����311�еĴ��ǡ������� ���ʡ������Ǵ���ġ�
#Ӧ�ðѡ������ߡ��������ݡ��͡����ʡ��ֱ���Ϊ1���ʡ�����tm���ڴ������ĵ�ʱ����������ģ�
#���ǿ�����Ҫ��дTermDocumentMatrix������Ŀǰ��û��ʱ�䴦��������飬�����ʱ����д�ú����ٷ������ǡ�

#���������wordcloud�Ա�ͼ
n <- nrow(csv) 
zz1 = 1:n
cluster_matrix<-sapply(unique_type,function(type){apply(tdm_matrix[,zz1[csv$type==type]],1,sum)})
#���������ǰ����е��ĵ����������д�Ƶ���ܡ��ĵ����Ϊ1��100��
#��TXTCorpus.csv��type���д�����ĵ����͡���1����10ƪ�ĵ�������������
#��ô���ÿ���ʣ��硰�ڳ���������Ҫ��1��10ƪ�ĵ��г��֡��ڳ����Ĵ������л��ܡ����ܽ������cluster_matrix
png(paste("Cluster_Comparison",".png", sep = ""), width = 800, height = 800 )
#ͼ���ڹ���Ŀ¼�µ�png��ʽͼƬ�ļ��С�
comparison.cloud(cluster_matrix,colors=brewer.pal(ncol(cluster_matrix),"Paired"))
#�˴�������10�������Ҫ�õ�10����ɫ����ɫ��Paired���Ե���12����ɫ��
#���ʹ�õ�ɫ��Dark2�ͻ��������Ϊ��ֻ�ܵ���8����ɫ������кܶ�������15�֣���ô�κ�����
#����ĵ�ɫ�̶���������ô����ɫ��������Ҫ�ֹ���ɫ����������CHNMap�ļ��е��ļ��п����ҵ���
#�����13����ɫ������ʹ��������䣺
#myColors <- colorRampPalette(c("lightgoldenrod1", "red3"))(13)
#comparison.cloud(cluster_matrix,colors=myColors)
#Ҳ������comparison.cloud(cluster_matrix,colors=rainbow(13))
title(main = "sample cluster comparision")  #ͼ���ı���
dev.off() #�رջ�ͼ��device����ͼƬ�ļ�����
#��ͼ�Ͽ���������ʶ����������Ĺؼ��ʰ����й������Ρ��ο͡��ƽ�ȡ�������ʶ����Ƹ�����
#�ؼ��ʰ����绰����������Ƹ���㶫����ݸ��ƭ�ֵȡ�������ʶ���Ļ�����Ĵʽ��٣���õ�塢��Ϸ�ȡ�

#���໭����ͼ
sample.cloud <- function(topic, maxwords = 100) {  
  words <- sample.words[which(csv$type==topic)]  #��ȡ�������topic�����Ĵ�
  allwords <- unlist(strsplit(words,' ')) #�����ַ�����ɢ���һ�����ʡ�
  wordsfreq <- sort(table(allwords), decreasing = T)  #�����Ƶ������wordsfreq
  wordsname <- names(wordsfreq) 
  png(paste("Topic_", topic, ".png", sep = ""), width = 800, height = 800 )  
  wordcloud(wordsname, wordsfreq, scale = c(6, 1.5), min.freq = 2, 
            max.words = maxwords, colors = rainbow(100))  
  title(main = paste("Topic:", topic))  
  dev.off()  
}
sapply(unique_type,sample.cloud)# unique(csv$type)
#������Ŀ¼��C:\BA\TextMining\Corpus\CNSample���鿴��������ͼ��

#����ģ�ͷ���
#library(lda)
dim(sample.dtm) #�ĵ�-����������100���ĵ���9211��������
dtm_matrix <- as.matrix(sample.dtm)
#�������ÿ��������ƽ��tf-idfֵ�����ֵ��������һ������һ�����Ͽ��һƪ�ĵ����е���Ҫ�ԡ�
#��Ƶ(term frequency, TF)ָ���Ǹ�������ĳ���ʳ��ֵĴ������Ը����µ��ܴ�����
#��ƵԽ��˵���ô����ĵ���Խ��Ҫ������һƪ�ĵ������ᵽ����������������Ӧ�ó�Ϊ���ĵ��ؼ��ʡ�
#�����ĵ�Ƶ�ʣ�inverse document frequency, IDF����һ�����ձ���Ҫ�ԵĶ���
#���㹫ʽ��IDF = log(D/Dt)��DΪ����������DtΪ�ôʳ��ֵ�����������
#�����ĵ�Ƶ��Խ��˵���ô������ĵ�����Խ��Ҫ���������Ͽ������ۿ������ĵ�������ֻ��1-2ƪ�����������ģ�
#������������ĵ�����ͺ���Ҫ����������Ͽ���ĵ�ȫ�������������ģ����������Ͳ���Ҫ�ˡ�
#����sample.dtm�ĵ�һ�������ڵ�һƪ���µ�tf-idfֵӦ���������㣺
NDoc <- nrow(dtm_matrix) #���Ͽ��е��ĵ�������100ƪ��
DocWords <- sum(dtm_matrix[1,]) #��һƪ�ĵ����ܴ���
tf <- dtm_matrix[1,1]/DocWords #��һ�����ڵ�һƪ�ĵ��Ĵ�Ƶ
DocTimes <- sum(dtm_matrix[,1]>0) #��һ�����ڼ�ƪ�ĵ��г��ֹ�
idf <- log2(NDoc/DocTimes) #idf
tf_idf <- tf*idf #��һ�������ڵ�һƪ���µ�tf-idfֵ

#��������һ�����дʵĴ���0��tf-idfֵ��ƽ��ֵ��
NDoc <- nrow(dtm_matrix)
DocTimes <- rep(0,ncol(dtm_matrix)) #DocTimes ������¼ÿ�������ڼ�ƪ�ĵ��г��ֹ���
for (j in (1:ncol(dtm_matrix)) ) DocTimes[j] <- sum(dtm_matrix[,j]>0)
DocWords <- rep(0,nrow(dtm_matrix)) #DocWords ������¼ÿ���ĵ��м����ʡ�
for (i in (1:nrow(dtm_matrix)) ) DocWords[i] <- sum(dtm_matrix[i,])

term_tf <- apply(dtm_matrix, 2, function(x) x/DocWords) #����ÿ������ÿ���ĵ��е�tfֵ
term_tf_idf <- apply(term_tf, 1, function (x) x*log2(NDoc/DocTimes))
#���ϼ���ÿ������ÿ���ĵ��е�tf-idfֵ������������дʵĴ���0��tf-idfֵ��ƽ��ֵ��
#�����ƽ��ֵ����ʹ�øôʽ����ĵ����������õġ�
avg_term_tf_idf <- apply(term_tf_idf, 1, sum)/DocTimes
summary(avg_term_tf_idf)

#�����2�����Ҳ����������дʵĴ���0��tf-idfֵ��ƽ��ֵ��
avg_term_tf_idf <- tapply(sample.dtm$v/row_sums( sample.dtm)[ sample.dtm$i], sample.dtm$j, mean)* 
  log2(nDocs( sample.dtm)/col_sums( sample.dtm > 0)) 
summary(avg_term_tf_idf)

dtm.Lg.tf.idf <- sample.dtm[, avg_term_tf_idf >= 0.1] #��tf-idfȡֵ�ϸߵĴ���������
#��summary(avg_term_tf_idf)�Ľ������ȡֵ����0.1�����ų�����75%�Ĵʣ�ע�⵽75%��λ��Ϊ0.030620��
#ɾ����tf_idfȡֵ�ϵ͵Ĵ�֮���е��ĵ��������еĴʶ���ɾ���ˣ���Щ�ĵ�Ӧ�ô����Ͽ���ȥ����
dtm.Lg.tf.idf <- dtm.Lg.tf.idf[row_sums(dtm.Lg.tf.idf) > 0,]
dim(dtm.Lg.tf.idf) #94ƪ�ĵ���ֻʣ��313���ʽ��з�����

n_topics <- length(unique(csv$type)) 
#library(topicmodels) 
SEED <- 2012 
sample_TM <- list( VEM = LDA( dtm.Lg.tf.idf, k=n_topics, control = list(seed = SEED)), 
                   VEM_fixed = LDA( dtm.Lg.tf.idf, k = n_topics, control = list(estimate.alpha = FALSE, seed = SEED)), 
                   Gibbs = LDA( dtm.Lg.tf.idf, k = n_topics, method = "Gibbs", control = list(seed = SEED, burnin = 1000, thin = 100, iter = 1000)), 
                   CTM = CTM( dtm.Lg.tf.idf, k = n_topics, control = list(seed = SEED, var = list(tol = 10^-4), em = list(tol = 10^-3)))) 
Topic <- topics(sample_TM[["VEM"]], 1) #����ܵ������ĵ�
Terms <- terms(sample_TM[["VEM"]], 5) #ÿ�������ǰ5���ؼ���
Terms[, 1:10]

#����ʹ�ò�ξ��ࣺ
sample_matrix = as.matrix(sample.dtm) 
rownames(sample_matrix) <- csv$type 
sample_hclust <- hclust(dist(sample_matrix), method="ward.D") 
plot(sample_hclust)  #Ч�����Ǻܺã����������¡���Ƹ�����ξ��໹���ԣ�����Ч�����á�
rect.hclust(sample_hclust,k=length(unique(csv$type)))

#����ʹ��kMeans��
sample_KMeans <- kmeans(sample_matrix, length(unique(csv$type))) 
library(clue)
cl_agreement(sample_KMeans, as.cl_partition(csv$type), "diag") 
#���㹲ͬ�����ʣ�ֻ��24%�ĵ�������������֪�ķ�����ͬ��

#����ʹ��string kernels��
library(kernlab)
stringkern  <-  stringdot(type  =  "string")
stringC1 <- specc(sample_matrix, 10, kernel=stringkern)
#�鿴ͳ��Ч��
table("String  Kernel"=stringC1,  cluster = csv$type )
#Ч���ܲ����롣