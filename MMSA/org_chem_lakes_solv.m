clear
clc

global Ctin Q M V Z X vsed pH

Ctin = 0; % mg*L^(-1)
Q = 20; % m^3*d^(-1)
M = 20*10^(-6); % kg*L^(-1)
V = 400; % m^3
Z = 1.0; % m
X = 1e9; % cel*L^(-1)
vsed = 0.1; % m*d^(-1)
pH = 9.0;

ic = 0.091; tspan = [0 40]; % Initial and Boundary Conditions
[t,x] = ode45('org_chem_lakes',tspan,ic); % Solves the Differential Equations
exp = [0  0.091
       1  0.041
       2  0.028
       5  0.013
       7  0.010
       9  0.004
       14 0.002];

figure
hold on
plot(t,x);xlabel('t(d)');ylabel('Ct(mg/L)');
plot(exp(:,1),exp(:,2),'LineStyle','none','Marker','o','MarkerEdgeColor','r');
hold off
