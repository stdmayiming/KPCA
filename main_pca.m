clc;
clear;
disp('读取训练数据...')
disp('......') 
[train_faceContainer,train_label] = ReadFace(40,0);

disp('训练数据PCA降维...') 
disp('......') 
[pcaA ,V]=fastPCA(train_faceContainer,20);

disp('显示主成分脸...') 
disp('.......') 
visualize(V);%显示主分量脸,即特征脸

disp('训练数据归一化...');
disp('.........') 
[ scaledface] = scaling( pcaA,-1,1 );
trainlabel=-1*ones(200,40);
disp('SVM样本训练...') 
svm_model=cell(1,40);
for i=1:40
trainlabel((i-1)*5+1:i*5,i)=ones(5,1);
svm_model{i}=fitcsvm(scaledface,trainlabel(:,i));
end
disp('读取测试数据...')  
[test_faceContainer,test_label]=ReadFace(40,1);

disp('测试数据pca降维...') 
disp('.......') 
load 'ORL/PCA.mat'
testData = (test_faceContainer - repmat(meanVec,200,1)) * V;

disp('测试数据归一化...')  
disp('.......')  
scaled_testData = testscaling( testData,-1,1);

disp('SVM样本分类预测...')
disp('......')  
predict_label=zeros(200,40);
for i=1:40
predict_label(:,i)=predict(svm_model{i},scaled_testData);
end
err_mat=abs(trainlabel-predict_label);
err=sum(sum(err_mat))/16000;
acc=1-err