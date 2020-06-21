function [Xdim,V]=KPCA(data,dim,d)
[X,X_mean,X_std] = zscore(data);%��׼��
[X_M, X_N] = size(X);
% ���ɺ˾���
K = Gram(X,d,1);%0ѡ�����ʽ�˺���
% �˾������Ļ�
ONES = 1/X_M*ones(X_M,X_M);
K_bar = K - ONES*K - K*ONES + ONES*K*ONES;
% ��K_bar ���������ֽ�
[alpha,Nlambda] = svd(K_bar); % ���ڶԳƾ�����ԣ���svdЧ����eig��ͬ
lambda = Nlambda/X_N;
explained = diag(lambda);
% ��׼��alpha
alpha_nor = alpha*Nlambda^(-0.5);
% ѡȡ��ά����
alpha_dim = alpha_nor(:,1:dim);
%�õ��任������
Xdim = alpha_dim.'*K_bar;
Xdim=Xdim';
V=data'*alpha_dim;