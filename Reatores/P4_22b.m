function [ dxdW ] = P4_22b( W,x )
%P4_22 Solução do problema 4.22 (FOGLER,1999)
k = 1.74;
Pa0 = 0.333*5;
Fa0 = 0.333*40;
alpha = 0.034;

%x(1) = X
%x(2) = y
%dxdW(1,:) = dX/dW
%dxdW(2,:) = dy/dW
dxdW(1,:) = 2*k*Pa0/Fa0*(1-x(1))/(1-0.6667*x(1))*x(2);
dxdW(2,:) = -alpha*(1-0.6667*x(1))/(2*x(2));
end