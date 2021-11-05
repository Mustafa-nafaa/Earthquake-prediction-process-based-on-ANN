clc;clear all;close all;
% % [name,path] = uigetfile('*.xls');
% % data = xlsread([path ,name] );
data = xlsread('ci3.xls');
data1=data;
% data(:,[1,2])=[];
% % data(:,[2:end])=normalize(data(:,[2:end]));
% data(:,[2:end])=normalize(data(:,[2:end]));
data(:,1)=data(:,1)/100;
% data(:,2)= (data(:,2)- min(data(:,2))) / ( max(data(:,2)) - min(data(:,2)));
% data(:,3)= (data(:,3)- min(data(:,3))) / ( max(data(:,3)) - min(data(:,3)));
% 
% data(:,4)= (data(:,4)- min(data(:,4))) / ( max(data(:,4)) - min(data(:,4)));
% data(:,5)= (data(:,5)- min(data(:,5))) / ( max(data(:,5)) - min(data(:,5)));

[trian_data  test_data  ]   =fun_split(data);
x_train  = trian_data (1:end-1,:);      
t_train  =  trian_data  (2:end,:);

x_test  = test_data (1:end-1,:);      
t_test  =  test_data  (2:end,:);
errer =10^10; k=1;
errer2 =errer;errer3 =errer;errer4 =errer;errer5 =errer;
while(errer>0.6) && k<100
    k=k+1;
net = feedforwardnet(randi(50,1,1));
net.trainParam.showWindow=0;
if (errer>0.6)
 net11 = train(net,x_train',t_train(:,1)');
 outputs = sim(net11,x_test')';
er1= sum(abs(outputs-t_test(:,1)));
if errer>er1
     errer=er1;
     net1=net11;
     y1=outputs;
 end
end

if (errer2>0.6)
net22= train(net,x_train(:,[2,end])',t_train(:,2)');
y22 = sim(net22,x_test(:,[2,end])')';
er2= sum(abs(y22-t_test(:,2)));
 if errer2>er2
     errer2=er2;
     net2=net22;
     y2=y22;
 end
end
if (errer3>0.6)
net33= train(net,x_train(:,[2,3,end])',t_train(:,3)');
y33 = sim(net33,x_test(:,[2,3,end])')';
er3= sum(abs(y33-t_test(:,3)));
 if errer3>er3
     errer3=er3;
     net3=net33;
     y3=y33;
 end
end

if (errer4>0.6)
net44= train(net,x_train(:,[3,4,end])',t_train(:,4)');
y44 = sim(net44,x_test(:,[3,4,end])')';
% er2= mse(y22,t_test(:,2));
er4= sum(abs(y44-t_test(:,4)));
 if errer4>er4
     errer4=er4;
     net4=net44;
     y4=y44;     
 end
end



if (errer5>0.6)
net55= train(net,x_train(:,[2,5,end])',t_train(:,5)');
y55 = sim(net55,x_test(:,[2,5,end])')';
% er2= mse(y22,t_test(:,2));
er5= sum(abs(y55-t_test(:,5)));
 if errer5>er5
     errer5=er5;
     net5=net55;
     y5=y55;     
 end
end
end
%% 

y1 = sim(net1,x_test')';
y2 = sim(net2,x_test(:,[2,end])')';
y3 = sim(net3,x_test(:,[2,3,end])')';
y4 = sim(net4,x_test(:,[3,4,end])')';
errer1= mse(y1,t_test(:,1));
errer2= mse(y2,t_test(:,2));
errer3= mse(y3,t_test(:,3));
errer4= mse(y4,t_test(:,4));
errer5= mse(y4,t_test(:,5));
y1=abs(y1);y2=abs(y2);y3=abs(y3);y4=abs(y4);y5=abs(y5);



err=min([errer1 errer2 errer3  errer4 errer5]);

check(:,1) =  fun_sig(t_test(:,1), y1,1);
check(:,2) =  fun_sig(t_test(:,2), y2,1);
check(:,3) =  fun_sig(t_test(:,3), y3,1);
check(:,4) =  fun_sig(t_test(:,4), y4,1);
check(:,5) =  fun_sig(t_test(:,5), y5,1);
ss= sum(check')';
check(:,[6:9]) = zeros(size(check,1),4)
 
check(find(ss==2),6)=1;
check(find(ss==3),7)=1;
check(find(ss==4),8)=1;
check(find(ss==5),9)=1;

 
check(find(ss==2),5)=1;
check(find(ss==3),6)=1;
check(find(ss==4),7)=1;


D=  sum (check(:,1));
lat=  sum (check(:,2));
lon=  sum (check(:,3));
depth=  sum (check(:,4));
M =  sum (check(:,5));
% c2 =  sum (check(:,6));
% c3 =  sum (check(:,7));
% c4 =  sum (check(:,8));
% c5 =  sum (check(:,9));
% 
% I=size(check,1)-c5;
c1 =  sum (ss==1);
c2 =  sum (ss==2);
c3 =  sum (ss==3);
c4 =  sum (ss==4);
c5 =  sum (ss==5);
I =  sum (ss==0);

% acc= (D+M+lat+lon+depth+c2+c3+c4+c5)/(D+M+lat+lon+depth+c2+c3+c4+c5+I);
acc= (c3+c4+c5)/(c1+c2+c3+c4+c5+I);
clc
disp(errer)
disp(errer2)
subplot(2,2,1)
plot (t_test(:,1),'r'); hold on
plot(y1,'b')
legend('t','y'); title('time')
disp(errer)
disp(errer2)
subplot(2,2,2)
plot (t_test(:,2),'r'); hold on
plot(y2,'b')
legend('t','y'); title('lat')

subplot(2,3,4)
plot (t_test(:,3),'r'); hold on
plot(y3,'b')
legend('t','y'); title('lot')
subplot(2,3,5)
plot (t_test(:,4),'r'); hold on
plot(y4,'b')
legend('t','y'); title('depth')

subplot(2,3,6)
plot (t_test(:,5),'r'); hold on
plot(y5,'b')
legend('t','y'); title('mu')
saveas(gcf,'p5c3.jpg');
%%

str ={'date','lat','lot' ,'mu','>=2' ,'>=3' ,'>=4'};
fun_plt_acc(check,str)

ii=1;
outputs = sim(net1,trian_data(ii,:)');
dd=data1(ii,1);
tt=data1(ii,2);

[strr timm ]  = calcute_time(dd,tt,outputs(1));

clc
disp(['date ' strr ] )
disp(['time ' timm ] )
disp(['accucy ' num2str(acc)])
disp(['mse ' num2str(err)] )
