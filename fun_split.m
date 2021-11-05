function  [trian_data  test_data]  =fun_split(data)
cv = cvpartition(size(data,1),'HoldOut',0.3);
idx = cv.test;
dataTrain = data(~idx,:);
dataTest  = data(idx,:);
trian_data=dataTrain (:,1:end);
test_data=dataTest (:,1:end);
