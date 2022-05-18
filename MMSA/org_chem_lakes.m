function [ xdot ] = org_chem_lakes( t,x )
% ORG_CHEM_LAKES Summary of this function goes here

% Set of State Variables:

% x(1)=Ct mg*L^(-1)
% xdot(1)=dCt/dt

global Ctin Q M V Z X vsed pH

% Rate Constants

tau = V/Q; % d
kp = 0.10; % d^(-1)
H = 10^(-pH);
OH = 10^(-14+pH);
kN = 3.64e-3; % d^(-1)
kA = 1.28e2; % mol^(-1)*d^(-1)
kB = 2.46e3; % mol^(-1)*d^(-1)
kh = kN + kA*H + kB*OH; % d^(-1)
kv = 0.05; % d^(-1)
kbprime = 2.35e-10; % L*cel^(-1)*d^(-1)
kb = kbprime*X; % d^(-1)
kox = 0.005; % d^(-1)
ks = vsed/Z; % d^(-1)
Kp = 50; % ug/kg per ug*L^(-1)
fd = (1/(Kp*M+1));
fp = (Kp*M/(Kp*M+1));
sumk = (1/tau) + kp + kh + kv + kb + kox + ks*fp;

% dCt/dt = Q*Ctin/V - Q*Ct/V - ks*fp*Ct - sumk*fd*Ct

xdot(1,:) = Q*Ctin/V - Q*x(1)/V - ks*fp*x(1) - sumk*fd*x(1);

end