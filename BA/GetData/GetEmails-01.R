library(stringr) # for the function str_match ����stringr package
setwd("d:/BA/GetData") #���ù���Ŀ¼
con <- file("Email.txt", "r") #���ı��ļ�Email.txt
email_list <- NULL  #email_list����������ȡ������Email����ʼ��Ϊ�ա�
pattern <- '[[:alnum:]_.-]+@[[:alnum:]_.-]+\\.[A-Za-z]+'  #Email���������ʽ��
# a simplier RE: pattern <- '[[:alnum:].-_]+@[[:alnum:].-_]+'
# However, the above simplier RE may match "ABC@AAA.Com._"
line=readLines(con,n=1) #��һ�����֡�
while( length(line) != 0 ) { #�����û���ļ�β��
  match_emails <- unlist(str_match_all(line, pattern)) 
  #����һ��������û��Email����������򽫽������match_emails��������С�
  #str_match_all returns all matched emails.
  # unlist a list to a vector variable.
  if (length(match_emails)!=0)
     {  email_list <- append(email_list, match_emails)
        print(match_emails) }
  line=readLines(con,n=1)
}
close(con) #�رմ򿪵�Email.txt�ļ�
paste(email_list,collapse=";") #�ϲ�email_list���б����emails���÷ֺ���Ϊ�ָ�����
length(email_list) #��һ����ȡ�����ٸ�email��