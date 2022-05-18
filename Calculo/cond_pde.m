function [ c,f,s ] = cond_pde ( x,t,T,dTdx )
%COND_PDE Modela a condu��o pura em uma barra de a�o
% dT/dt = alfa*d2T/dx2

alpha = 1; % alfa = k/(ro*Cp) do a�o

c = 1;
f = alpha*dTdx;
s = 0;
end