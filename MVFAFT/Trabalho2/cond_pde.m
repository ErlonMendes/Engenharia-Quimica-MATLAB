function [ c,f,s ] = cond_pde ( x,t,T,dTdx )
global alfa
% dT/dt = alfa*d2T/dx2
c = 1;
f = alfa*dTdx;
s = 0;
end