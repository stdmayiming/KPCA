function K = Gram(X,h,flag)
if flag==1
[X_M,X_N] = size(X);
K = zeros(X_M,X_M);
for i=1:X_M
    for j=1:X_M
        K(i,j) = kfun(X(i,:),X(j,:),h);
    end
end
else
    [X_M,X_N] = size(X);
    K = zeros(X_M,X_M);
    for i=1:X_M
        for j=1:X_M
             K(i,j) = (3*X(i,:)*X(j,:)'+15);
        end
    end
    
end
