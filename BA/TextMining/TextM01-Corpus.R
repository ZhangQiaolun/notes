library(tm)
#tm��֧�ִӶ����Դ��ȡ�ı���
getSources()
#Ҳ֧�ֶ���Ķ�����
getReaders()

sourcedir <- 'D:/BA/TextMining/Corpus/pdf' #��Ҫ�����������Ͽ��pdf�ļ����ڵ�Ŀ¼
dir(sourcedir) #����dir��䣬��Ŀ¼��������Щpdf�ļ�
pdffiles <- list.files(path = sourcedir, pattern = ".pdf",  full.names = TRUE) 
#��pdf�ļ���·������pdffiles�����С�

sapply(pdffiles, function(filepath) system(paste
     ('D:/BA/TextMining/pdf2txt/bin64/pdftotext.exe', paste0('"', filepath, '"')), wait = FALSE) )
#�����sapply����Ƕ�pdffiles��������Ԫ��Ӧ��һ��������
#�ú�����������ʹ��pdftotext.exe����Ŀ��Ŀ¼������pdf�ļ�ת����txt�ļ���
#ע�⣺���õ���64λ����ϵͳ��������õ���Windows 32λ����ϵͳ��Ӧ�ð�bin64�ĳ�bin32��
#������������������俴��ʲôЧ����
# sapply(1:5, function(i) i^2)
# filepathlength <- sapply(pdffiles, function(f) nchar(f)); names(filepathlength) <-NULL; filepathlength
#paste0('"', filepath, '"') ����˫������������pdf�ļ�·����
#paste0('1','2','3') �����paste('1','2','3',sep='')��ͬ����paste('1','2','3')�õ��Ľ���Ƿָ���Ϊ�ո�
#system()����ִ��һ��������䣬�˴�Ϊ��pdf�ļ�ִ��pdftotext.exe����
#paste('D:/BA/TextMining/pdf2txt/bin64/pdftotext.exe', paste0('"', filepath, '"')
#��������ִ���������䡣
#��������һ�� paste('D:/BA/TextMining/pdf2txt/bin64/pdftotext.exe', paste0('"', pdffiles[1], '"'))
#������֮��Ŀ��Ŀ¼������pdfת����txt�ļ�������ԭĿ¼�С�

dir.create('D:/BA/TextMining/Corpus/txt') #������Ŀ¼�������txt�ļ���
txtfiles <- list.files(path = sourcedir, pattern = ".txt",  full.names = TRUE)
#���������ı��ļ���·����
sapply(txtfiles, function(origintxtfile) { #origintxtfile ��ʾtxtfiles�е�ÿ��Ԫ��
  destfile <- sub('/Corpus/pdf','/Corpus/txt',origintxtfile)
  # Ŀ���ļ�·����ԭ�ļ�·���е�/Corpus/pdf�滻��/Corpus/txt���������䡣
  file.copy(from = origintxtfile, to = destfile, overwrite=TRUE)
  # ��ԭ�ļ�������Ŀ���ļ��С�
  file.remove(origintxtfile)  #�Ƴ�ԭ�ļ���  
  })