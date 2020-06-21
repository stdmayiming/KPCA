clc;
clear;
disp('��ȡѵ������...')
disp('......') 
[train_faceContainer,train_label] = ReadFace(40,0);
disp('ѵ������kPCA��ά...') 
disp('......') 
[KpcaA ,V]=KPCA(train_faceContainer,20,5);

disp('��ʾ���ɷ���...') 
disp('.......') 
visualize(V);%��ʾ��������,��������

disp('ѵ�����ݹ�һ��...');
disp('.........') 
[ scaledface] = scaling( KpcaA,-1,1 );
trainlabel=-1*ones(200,40);
disp('SVM����ѵ��...') 
svm_model=cell(1,40);
for i=1:40
trainlabel((i-1)*5+1:i*5,i)=ones(5,1);
svm_model{i}=fitcsvm(scaledface,trainlabel(:,i));
end
disp('��ȡ��������...')  
[test_faceContainer,test_label]=ReadFace(40,1);

disp('��������kpca��ά...') 
disp('.......') 
load 'ORL/PCA.mat'
[test_KpcaA ,test_V]=KPCA(test_faceContainer,20,5);


disp('SVM��������Ԥ��...')
disp('......')  
predict_label=zeros(200,40);
for i=1:40
predict_label(:,i)=predict(svm_model{i},test_KpcaA);
end
err_mat=abs(trainlabel-predict_label);
err=sum(sum(err_mat))/16000;
acc=1-err