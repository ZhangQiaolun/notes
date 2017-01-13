#Data Frame�Ļ�������

Celebrities <- data.frame(Name = c('����','������','����ǿ','������'), 
                          Sex = c('M','F','M','M'), Height = c(175,163 , 165, 147))

#�����ݿ����һ��֮�¼�������һ������
ZHAO_LY <- data.frame(Name='����ӱ',Sex='F',Height=165)
Celebrities <- rbind(Celebrities,ZHAO_LY)
Celebrities

#�����ݿ�����µ�һ��Birthday
Birth <- as.Date(c('1957/04/19','1981/09/16','1984/05/29','1983/06/06','1987/10/16'))
Celebrities <- cbind(Celebrities,Birthday = Birth)
Celebrities

#���ʵ�3������
Celebrities[3,]

#���ʵ�3�͵�5������
Celebrities[c(3,5),]

#���ʵ�1�е���4�е�����
Celebrities[1:4,]

#���ʳ��˵�1�е�����
Celebrities[-1,]

#���ʳ��˵�1��3�е�����
Celebrities[-c(1,3),]

#����ĳһ�����ݣ������г��������ǵ����ֺ����ߣ�
Celebrities[,c('Name','Height')]
Celebrities[,c(1,3)] #���֪�������ǵ�1�У������ǵ�3��

#��������Ϊ���ŵ�����
Celebrities[Celebrities$Name=='����',]

#��������Ϊ�����Լ�������������
Celebrities[Celebrities$Name %in% c('����','������'),]

#���ҹ�����������
Celebrities[Celebrities$Name=='������', 'Height']

#����Ĳ��ң�����ǰ�涼Ҫ�������ݿ����֣����������ô�鷳������ʹ��attach������
attach(Celebrities)
Celebrities[Name=='������', 'Height']
#ȡ��attach
detach(Celebrities)

class(Celebrities) #Celebrities��һ��data.frame
sapply(Celebrities,class) #��Celebrities����ÿһ����ʲô�������͡�
#��������������ͱ�����factor�ͱ��������ⲻ�������������ġ�
#����ϣ������Ӧ�����ַ��ͱ�����
Celebrities$Name <- as.character(Celebrities$Name)
#��Name�ֶε�����ת�����ַ��ͱ�����
sapply(Celebrities,class)

nrow(Celebrities) #�����ݿ��ж����С�
ncol(Celebrities) #�����ݿ��ж����С�
dim(Celebrities) #�����ݿ����С�
colnames(Celebrities) #�����ݿ�������

#������Birthday�ĳ�Birthdate
colnames(Celebrities) <- c('Name','Sex','Height','Birthdate')
colnames(Celebrities)
Celebrities

#���Ǵ��������Birthdate�Ļ�Birthday��������ݿ���зǳ��࣬
#��ô����Birthdate�����ڵڼ��оͷǳ������㡣��Ҫ������������������е���Ϣ��
CelColNames <- colnames(Celebrities)
ColN_to_change <- which(CelColNames=='Birthdate') #�ڵ�4��
ColN_to_change
CelColNames[ColN_to_change]='Birthday' #CelColNames[4]='Birthday'
colnames(Celebrities) <- CelColNames
colnames(Celebrities)

#����
row.names(Celebrities)
row.names(Celebrities) <- c('Ц��','Ů��','Ц��','����','Ů��') #���������ظ�������
row.names(Celebrities) <- c('Ц��1','Ů��1','Ц��2','����1','Ů��2')
Celebrities
#�޸�����
attach(Celebrities)
RowN_to_change <- which(Name=='������')
CelRowNames <- row.names(Celebrities)
CelRowNames[RowN_to_change] = '��Ů1'
row.names(Celebrities) <- CelRowNames

CelAge <- as.integer(format(Sys.Date(),"%Y"))-as.integer(format.Date(Birthday,"%Y"))
Celebrities <- data.frame(Celebrities,Age=CelAge)
Celebrities
detach(Celebrities)

#�ҵ����ߴ���160���������30������
Celebrities[(Celebrities$Height>160 & Celebrities$Age>30),]

#�ҵ����ߴ���160���������30��Ů����
Celebrities[(Celebrities$Height>160 & Celebrities$Age>30 & Celebrities$Sex=='F'),]

attach(Celebrities)
Celebrities[(Height>160 & Age>30 ),]
Celebrities[(Height>160 & Age>30 & Sex=='F'),]

Celebrities[order(Age),] #���������С��������
Celebrities[order(-Age),] #��������Ӵ�С����

detach(Celebrities)

#�ϲ�����data.frame��
Cel_Prov = data.frame(Cel=c('����','������','����ǿ','������','����ӱ'),
                      Prov = c('����','ɽ��','�ӱ�','�Ϻ�','�ӱ�'),stringsAsFactors=FALSE)
merge(Celebrities, Cel_Prov, by.x="Name", by.y="Cel")