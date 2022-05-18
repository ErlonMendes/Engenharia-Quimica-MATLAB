function [ dxdW ] = PBRperdadecarga( W,x )
%EX4_7 Resolve o Exemplo 4.7 (FOGLER, 1999)
% x(1) = X
% x(2) = y
% xdot(1,:) = dX/dW
% xdot(2,:) = dy/dW

% Parâmetros das equações diferenciais ordinárias:
global k Pa0 Fa0 thetab vb eps alpha

% Equações diferenciais ordinárias:
% dX/dW = (kprime/Fa0)*((1-X)/(1+eps*X))*y;
% dy/dW = -alpha*(1+eps*X)/(2*y);

dxdW(1,:) = k*Pa0/Fa0*(1-x(1))^(1/3)*(thetab-vb*x(1))^(2/3)/(1+eps*x(1))*x(2);
dxdW(2,:) = -alpha*(1+eps*x(1))/(2*x(2));
end