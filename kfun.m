function y = kfun(x,y,h)
y = exp(-norm(x-y)^2/h);

