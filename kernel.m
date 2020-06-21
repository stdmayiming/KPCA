function K=kernel(X)
% Gaussian Kernel
% Input:
% X: 输入的数据矩阵，每一行是一个数据，行数是数据总数
% sigma_kernel: 径向基核函数的参数
% Output:
% K: X的kernel矩阵，大小为N*N

N = size(X,1); %行数，即为数据个数
DIST=zeros(N,N);
for i=1:N
    for j=1:N
        diff=X(i,:)-X(j,:);
        DIST(i,j)=sqrt(diff*diff');
    end
end
DIST(DIST==0)=inf;
%inf为无穷大
DIST1=min(DIST);
sigma_kernel=5*mean(DIST1);
K = zeros(N);

tmp = zeros(N,N);
        for i = 1:N
            for j = 1:N
                tmp(i,j) = norm(X(i,:)-X(j,:));
            end
        end   
        K = exp(-0.5*(tmp/sigma_kernel).^2);

