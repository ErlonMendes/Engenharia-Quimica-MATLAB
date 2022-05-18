function [ c,f,s ] = org_chem_rivers_pde ( x,t,u,dudx )
% ORG_CHEM_RIVERS_PDE Describes pouring of Organic Chemicals in Rivers and
% Estuaries

lambdaw = 0.2; % d^(-1)
lambdab = 0.2; % d^(-1)
ks = 0.5; % d^(-1)
d = 0.02; % m
kl = 8.64*10^(-4); % m*d^(-1)
E = 3.456*10^(-5); % m^2*d^(-1)
Kpw = 200; % L*kg^(-1)
Kpb = 100; % L*kg^(-1)
alfa = 5*10^(-5); % d^(-1)
Sw = 1*10^(-5); % kg*L^(-1)
Sb = 0.1;  % kg*L^(-1)
A = 1500; % m^2
h = 5; % m
Q = 1.1664*10^8; % m^3*d^(-1)
gama = (alfa*Sb)/(ks*Sw);
F = 0; % ug*L^(-1)*d^(-1)

% Mass Balance Equation to Total Chemical Concentration
% dCt/dt = -(Q/A)*dCt/dx + d/dx(E*dCt/dx) - lambdaw*(Ct/(1+Kpw*Sw)) -
% ks*Ct*((Kpw*Sw)/(1+Kpw*Sw)) + (kl/h)*((r/Kpb)-(Ct/(1+Kpw*Sw))) +
% alfa*Sb*r/gama + F(x,t)

% Mass Balance Equation to Adsorbed Chemical on Sedment Solids
% dr/dt = -lambdab*r/(1+Kpb*Sb) +
% ((ks*Kpw*Sw*Ct*gama)/(1+Kpw*Sw))/(Sb+1/Kpb) - alfa*Sb*r/(Sb+1/Kpb) -
% (kl*(r/Kpb)-(Ct/(1+Kpw*Sw)))/(d*(Sb+1/Kpb))

c = [1
     1];
 
f = [E*dudx(1)
     0];
 
s = [-(Q/A)*dudx(1) - lambdaw*(u(1)/(1+Kpw*Sw)) - ks*u(1)*((Kpw*Sw)/(1+Kpw*Sw)) + (kl/h)*((u(2)/Kpb)-(u(1)/(1+Kpw*Sw))) + alfa*Sb*u(2)/gama + F
     -lambdab*u(2)/(1+Kpb*Sb) + ((ks*Kpw*Sw*u(1)*gama)/(1+Kpw*Sw))/(Sb+1/Kpb) - alfa*Sb*u(2)/(Sb+1/Kpb) - kl*((u(2)/Kpb)-(u(1)/(1+Kpw*Sw)))/(d*(Sb+1/Kpb))];
