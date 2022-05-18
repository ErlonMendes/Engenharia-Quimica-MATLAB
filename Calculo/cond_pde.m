function [ c,f,s ] = cond_pde ( x,t,T,dTdx )
%COND_PDE Modela a condução pura em uma barra de aço
% dT/dt = alfa*d2T/dx2

alpha = 1; % alfa = k/(ro*Cp) do aço

c = 1;
f = alpha*dTdx;
s = 0;
end