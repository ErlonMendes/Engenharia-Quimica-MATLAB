function [ xdot ] = ex4_7( W,x )
%EX4_7 Resolve o Exemplo 4.7 (FOGLER, 1999)
% x(1) = X
% x(2) = y
% xdot(1,:) = dX/dW
% xdot(2,:) = dy/dW

% Parâmetros das equações diferenciais ordinárias:
global kprime eps
kprime = 0.0266; % lbmol/(h*lb cat)
eps = -0.15;
alpha = 0.0166; % 1/lb cat
Fa0 = 1.08; % lbmol/h

% Equações diferenciais ordinárias:
% dX/dW = (kprime/Fa0)*((1-X)/(1+eps*X))*y;
% dy/dW = -alpha*(1+eps*X)/(2*y);

xdot(1,:) = (kprime/Fa0)*((1-x(1))/(1+eps*x(1)))*x(2);
xdot(2,:) = -alpha*(1+eps*x(1))/(2*x(2));
end