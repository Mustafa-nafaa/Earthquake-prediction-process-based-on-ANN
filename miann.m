clc;clear all;close all;
% [name,path] = uigetfile('*.xls');
% data = xlsread([path ,name] );
data = xlsread('ci2.xls');
data1=data;

data(:,[1,2])=[];

% data(:,[2:end])=normalize(data(:,[2:end]));
data(:,1)=data(:,1)/100;
% data(:,2)= (data(:,2)- min(data(:,2))) / ( max(data(:,2)) - min(data(:,2)));
% data(:,3)= (data(:,3)- min(data(:,3))) / ( max(data(:,3)) - min(data(:,3)));
% 
% data(:,4)= (data(:,4)- min(data(:,4))) / ( max(data(:,4)) - min(data(:,4)));
% data(:,5)= (data(:,5)- min(data(:,5))) / ( max(data(:,5)) - min(data(:,5)));
data(:,3)=[];    data(:,4)=[];
[trian_data  test_data  ]   =fun_split(data);
x_train  = trian_data (1:end-1,:);      
t_train  =  trian_data  (2:end,[1,end]);
x_test  = test_data (1:end-1,:);      
t_test  =  test_data  (2:end,[1,end]);

errer =10^10; k=1;
errer2 =errer;
while(errer>0.6) && k<100
    k=k+1;
net = feedforwardnet(randi(50,1,1));
net.trainParam.showWindow=0;

if (errer>0.6)
 net11 = train(net,x_train',t_train(:,1)');
 outputs = sim(net11,x_test')';
% 
%  er1= mse(outputs,t_test(:,1));
er1= sum(abs(outputs-t_test(:,1)));
 if errer>er1
     errer=er1;
     net1=net11;
     y1=outputs;
 end
end

if (errer2>0.6)
net22= train(net,x_train(:,2:end)',t_train(:,2)');
y22 = sim(net22,x_test(:,2:end)')';
% er2= mse(y22,t_test(:,2));
er2= sum(abs(y22-t_test(:,2)));
 if errer2>er2
     errer2=er2;
     net2=net22;
     y2=y22;
     
 end
end
end
y1 = sim(net1,x_test')';
y2 = sim(net2,x_test(:,2:end)')';
errer1= mse(y1,t_test(:,1));
errer2= mse(y2,t_test(:,2));
y2=abs(y2);
y1=abs(y1);
clc
disp(errer)
disp(errer2)
subplot(2,1,1)
plot (t_test(:,1),'r'); hold on
plot(y1,'b')
legend('t','y'); title('time')

subplot(2,1,2)
plot (t_test(:,2),'r'); hold on
plot(y2,'b')
legend('t','y'); title('mu')
%%
y=  [y1  y2];
t=  [t_test(:,1) t_test(:,2)];
check(:,1) =  fun_sig(t(:,1), y(:,1),1);
check(:,2) =  fun_sig(t(:,2), y(:,2),1);
check(:,3)=bitand(check(:,1),check(:,2));
acc = (sum(check)/ length(check))*100;
D=  sum (check(:,1));
M=  sum (check(:,2));
DM=  sum (check(:,3));
I=size(check,1)-DM;
D1=D-DM;
M1=M-DM;
I=size(check,1)-(DM);
acc= (D1+M1+DM)/(D1+M1+DM+I);
acc= (DM)/(DM+I);
ii=1;
outputs = sim(net1,trian_data(ii,:)');
dd=data1(ii,1);
tt=data1(ii,2);
[strr1 timm1 ]  = calcute_time(dd,tt,outputs(1));
clc
disp(['date ' strr1 ] )
disp(['time ' timm1 ] )
disp(['accucy ' num2str(acc)])
disp(['mse ' num2str(errer2/100)] )
%saveas(gcf,'p2c1.jpg');
% for   i=1: size(tt,1)
% t(i,2)= min(data1(:,end)) +(t(i,2) * ( max(data1(:,end)) - min(data1(:,end))));
% 
% y(i,2)= min(data1(i,end)) +(y(i,2) * ( max(data1(:,end)) - min(data1(:,end))));
% end
% t(:,1)= min(data(:,1)) +(t(:,1) *100* ( max(data(:,1)) - min(data(:,1))));
% y(:,1)= min(data(:,1)) +(y(:,1) *100* ( max(data(:,1)) - min(data(:,1))));
for  ii=1:size(test_data)
outputs = sim(net1,test_data(ii,:)');
dd=data1(ii,1);
tt=data1(ii,2);
[strr{ii} timm{ii}]  = calcute_time(dd,tt,outputs(1));  
end
figure; 
cls=  sum(check');
subplot(211); plot(cls); title('Test Score')
xlabel('Sample Number'); ylabel('Score'); 

subplot(223); histogram(cls); 
title('Histogram of Test Score')
% xlim([0 3]);
ylabel('Number of Samples')
xlabel('Score'); grid on;
xticklabels({'date','mu','>=2'})

accury =  [sum(check(:,1))/ length(check(:,1)), ...
           sum(check(:,2))/ length(check(:,2)), ...   
           sum(check(:,3))/ length(check(:,3)) ];

subplot(224); bar(accury); 
title('Test Accuracy')
xlim([0 3]); 
ylabel('Accuracy (%)')
xlabel('Score'); grid on;
xticklabels({'date','mu','>=2'})

Predicat_MU = sim(net2,test_data(2:end,2:end)')';
Target_Mu= t_test(:,2);
less  = abs(Predicat_MU - Target_Mu);
[val  idx ]=  mink(less,10);
T = table(Predicat_MU(idx),Target_Mu(idx) );
% disp(T)