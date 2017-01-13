library(ggplot2)
library(dplyr) #for function "arrange"

circleFun <- function(center = c(0,0),radius = 1, npoints = 100){ #���ǻ�ԲȦ�ĺ�����
#������Ĭ��ֵ��center = (0,0),ԭ��Ϊ(0,0) �뾶=1���軭�ĵ�����100���㡣
  tt <- seq(0,2*pi,length.out = npoints)   #��0��2*pi��npoints���㡣
  xx <- center[1] + radius * cos(tt)  
  yy <- center[2] + radius * sin(tt)  #��npoints����ĺ�����������ꡣ
  return(data.frame(x = xx, y = yy))  #����һ�����ݿ���Ϊx���зź����꣬��Ϊy���з������ꡣ
}

#OrbitPoints <- function(c1= c(0,0), c2= c(0,0),r1=1, r2=rV/rE, Obt1=ObtE, Obt2=ObtV, npoints=80) {
#  t1 <- seq(from = 0, by = 2*pi/Obt1, length.out = npoints)
#  t2 <- seq(from = 0, by = 2*pi/Obt2, length.out = npoints)
#  ObtPts <- data.frame(x=numeric(0),y=numeric(0),grp = numeric(0))
#  for (i in (1:npoints)) {
#    pt1 = data.frame( x= c1[1] + r1 * cos(t1[i]), y = c1[2] + r1 * sin(t1[i]), grp = i)
#    pt2 = data.frame( x= c2[1] + r2 * cos(t2[i]), y = c2[2] + r2 * sin(t2[i]), grp = i)
#    ObtPts <- rbind(ObtPts,pt1,pt2)
#  }
#  return(ObtPts)
#}

#OrbitPoints���������������������ڲ�ͬʱ������λ�á�
OrbitPoints <- function(c1= c(0,0), c2= c(0,0),r1=rE, r2=rV, Obt1=ObtE, Obt2=ObtV, npoints=80) {
  #ObtE����ת���ڣ���������ObtV����ת���ڣ�������
  t1 <- seq(from = 0, by = 2*pi/Obt1, length.out = npoints)
  #һ����ת����ת2pi����ôÿ��ת�ĽǶ���2*pi/Obt1��t1��Obt1����������ԲȦ�ϵĽǶ�λ�á�
  t2 <- seq(from = 0, by = 2*pi/Obt2, length.out = npoints)
  #һ����ת����ת2pi����ôÿ��ת�ĽǶ���2*pi/Obt1��t2��Obt2����������ԲȦ�ϵĽǶ�λ�á�
  x1 <- c1[1] + 1 * cos(t1) #����Obt1ÿ����ԲȦ�ϵ�����λ�ã�����1�ǰ뾶��
  y1 <- c1[2] + 1 * sin(t1)
  x2 <- c2[1] + r2/r1 * cos(t2) #����Obt2ÿ����ԲȦ�ϵ�����λ�ã�����r2/r1�ǰ뾶��
  y2 <- c2[2] + r2/r1 * sin(t2)
  ObtPts <- data.frame(x=x1,y=y1,grp =rep(1:npoints))
  #��Obt1ÿ����ԲȦ�ϵ�λ�÷������ݿ�ObtPts���С�grp����group�������ڼ����λ�á�
  ObtPts <- rbind(ObtPts,data.frame(x=x2,y=y2,grp =rep(1:npoints)))
  #��Obt2ÿ����ԲȦ�ϵ�λ�ü������ݿ�ObtPts���С�
  ObtPts <- arrange(ObtPts, grp) #���½�������ȷ��ͬһ���2�������һ���Ա���滭ͼ��
  return(ObtPts)
}

rE = 92.96 #million miles. �������̫��9296��Ӣ�
ObtE = 365 #days - orbital period  ������̫����ת������365�졣
rV = 67.24 #million miles. ���Ǿ���̫��6724��Ӣ�
ObtV = 225 #days - orbital period  ������̫����ת������225�졣

Edat <- circleFun(c(0,0),1,npoints = 100) 
#����ת�뾶��Ϊ1���Ȱѹ�תԲ��������
Vdat <- circleFun(c(0,0),rV/rE,npoints = 100) 
#����һ������ת�뾶��ΪrV/rE���Ȱѹ�תԲ��������
p <- ggplot(Edat) + geom_path(aes(x,y)) + coord_fixed(ratio = 1)
p + geom_path(aes(Vdat$x, Vdat$y))

#�������ǻ�����ͽ�����̫��ת��ͼ������Ӣ������Venus��
LinePoints <- OrbitPoints(npoints=1200)
ggplot(LinePoints)+geom_line(aes(x,y,group=grp))+ coord_fixed(ratio=1)

#�������ǻ������ˮ����̫��ת��ͼ��ˮ��Ӣ������Mercury�����ǰ�rV��ObtV����ˮ�ǵ���Ϣ��
rV = 35.98 #million miles. ˮ�Ǿ���̫��3598��Ӣ�
ObtV = 88 #days - orbital period ˮ����̫����ת������88�졣
LinePoints <- OrbitPoints(r2 = 35.98, Obt2=88, npoints=365)
ggplot(LinePoints)+geom_line(aes(x,y,group=grp))+ coord_fixed(ratio=1)

#�������ǻ�����ͻ�����̫��ת��ͼ������Ӣ������Mars�����ǰ�rV��ObtV���ɻ��ǵ���Ϣ��
rV = 141.6 #million miles. 
ObtV = 687 #days - orbital period
LinePoints <- OrbitPoints(r2 = 141.6, Obt2=687, npoints=800)
ggplot(LinePoints)+geom_line(aes(x,y,group=grp))+ coord_fixed(ratio=1)

LinePoints <- OrbitPoints(c2=c(0.5,0.5),r2 = 141.6, Obt2=687, npoints=800)
ggplot(LinePoints)+geom_line(aes(x,y,group=grp))+ coord_fixed(ratio=1)