A <- data.frame ()   #���������ݿ�A
B <- data.frame(Name=character(0), Grade = numeric(0))  
#�������ݿ�B�� ��2������һ��������Name������һ�е�������Grade��
B <- rbind(B, data.frame(Name='Zach Zhou', Grade=90, stringsAsFactors=FALSE))
#��B�м���1�����ݣ�ʹ�õ�rbind������row bind����
B
B <- cbind(B, data.frame(Sex='M', City='Shanghai'))
#��B������2�����ݣ�ʹ�õ�cbind������column bind)��
B
B <- rbind (B, data.frame(Name ='Eric Liu', Grade = 95, Sex = 'M', City='Beijing'))
B
class(B$Sex) 
class(B$Name)
class(B$City) #City�е���������Ϊ��������ݣ�factor�����ݣ������Ǵ���ת�����ַ������ݡ�
C <- cbind(B[,1:3],data.frame( City=as.character(B$City), stringsAsFactors=FALSE))
C
class(C$Sex)
class(C$Name)
class(C$City)
C[1,] #��ȡ��һ������
C[,1] #��ȡ��һ������
C[2,2] #��ȡ�ڶ��еڶ�������

A1 <- c(1:3)
for (i in (1:length(A1))) { print(A1[i]+1)}