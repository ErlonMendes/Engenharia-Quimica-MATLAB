function [ dxdW ] = P4_20( W,x )
%EX4_20 Resolve o problema 4.20 (Fogler, 1999)
% x(1) = X
% x(2) = y
% dxdW(1,:) = dX/dW
% dxdW(2,:) = dy/dW

eps = 1;
alpha = 0.00094823;
a = 0.0001005;

% dX/dW = a*(1-X)/(1+eps*X)*y;
% dy/dW = -alpha*(1+eps*X)/(2*y);

dxdW(1,:) = a*(1-x(1))/(1+eps*x(1))*x(2);
dxdW(2,:) = -alpha*(1+eps*x(1))/(2*x(2));
end