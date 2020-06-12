%����KPCA����
clc;
clear;
load('circle.mat')
X0 = data(:, 1:2);
label = data(:, 3);
h = 1; % ��˹�˳߶�����
dim =2; % ��άά��
[X,X_mean,X_std] = zscore(X0);%��׼��
[X_M, X_N] = size(X);
% ���ɺ˾���
K = Gram(X,h);
% �˾������Ļ�
ONES = 1/X_M*ones(X_M,X_M);
K_bar = K - ONES*K - K*ONES + ONES*K*ONES;
% ��K_bar ���������ֽ�
[alpha,Nlambda] = svd(K_bar); % ���ڶԳƾ�����ԣ���svdЧ����eig��ͬ
% [alpha,Nlambda] = eig(K_bar);
% lambda = Nlambda/X_N;
lambda = Nlambda/X_N;
explained = diag(lambda);
% ȷ����άά��
% for dim=1:X0_N
%     if sum(explained(1:dim))/sum(explained)>0.90
%         break;
%     end
% end
% ��׼��alpha
alpha_nor = alpha*Nlambda^(-0.5);
% ѡȡ��ά����
alpha_dim = alpha_nor(:,1:2);
%�õ��任������
Xdim = alpha_dim.'*K_bar;
Xdim=Xdim';
Visualization.map(X, Xdim, label);