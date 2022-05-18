function [ c,f,s ] = cont_groundwater_pde ( x,t,C,dCdx )
% CONT_GROUNDWATER_PDE Describes pouring of Contaminants in Groundwater

% Mass Balance Equation to Contaminant Concentration
% R*dC/dt = -ux*dC/dx + Dx*d2C/dx2 - k*C

R = 2;
ux = 0.02; % m*d^(-1)
alfa = 1;
Dab = 1e-4; % m^2*d^(-1)
Dx = alfa*ux + Dab;
k = 0.03; % d^(-1)

c = R;
 
f = Dx*dCdx;
 
s = -ux*dCdx - k*C;
end