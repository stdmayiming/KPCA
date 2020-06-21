function [Xdim,V]=KPCA(data,dim,d)
[X,X_mean,X_std] = zscore(data);%标准化
[X_M, X_N] = size(X);
% 生成核矩阵
K = Gram(X,d,1);%0选择多项式核函数
% 核矩阵中心化
ONES = 1/X_M*ones(X_M,X_M);
K_bar = K - ONES*K - K*ONES + ONES*K*ONES;
% 对K_bar 进行特征分解
[alpha,Nlambda] = svd(K_bar); % 对于对称矩阵而言，其svd效果与eig相同
lambda = Nlambda/X_N;
explained = diag(lambda);
% 标准化alpha
alpha_nor = alpha*Nlambda^(-0.5);
% 选取降维矩阵
alpha_dim = alpha_nor(:,1:dim);
%得到变换后数据
Xdim = alpha_dim.'*K_bar;
Xdim=Xdim';
V=data'*alpha_dim;