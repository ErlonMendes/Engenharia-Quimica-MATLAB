function [ c,f,s ] = ex6_11pde( r,t,C,dCdr )
%EX6_11PDE Resolve o Exemplo 6.11 (CONSTANTINIDES, 2000)
% dC/dz = Dsr*(1/r)*d/dr(r*dC/dr)

Dsr = 2e-4; % Coeficiente de dispersão radial do sólido (m^2/s)

c = 1;
f = Dsr*dCdr;
s = 0;
end