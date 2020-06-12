%测试KPCA代码
clc;
clear;
load('circle.mat')
X0 = data(:, 1:2);
label = data(:, 3);
h = 1; % 高斯核尺度因子
dim =2; % 降维维数
[X,X_mean,X_std] = zscore(X0);%标准化
[X_M, X_N] = size(X);
% 生成核矩阵
K = Gram(X,h);
% 核矩阵中心化
ONES = 1/X_M*ones(X_M,X_M);
K_bar = K - ONES*K - K*ONES + ONES*K*ONES;
% 对K_bar 进行特征分解
[alpha,Nlambda] = svd(K_bar); % 对于对称矩阵而言，其svd效果与eig相同
% [alpha,Nlambda] = eig(K_bar);
% lambda = Nlambda/X_N;
lambda = Nlambda/X_N;
explained = diag(lambda);
% 确定降维维数
% for dim=1:X0_N
%     if sum(explained(1:dim))/sum(explained)>0.90
%         break;
%     end
% end
% 标准化alpha
alpha_nor = alpha*Nlambda^(-0.5);
% 选取降维矩阵
alpha_dim = alpha_nor(:,1:2);
%得到变换后数据
Xdim = alpha_dim.'*K_bar;
Xdim=Xdim';
Visualization.map(X, Xdim, label);