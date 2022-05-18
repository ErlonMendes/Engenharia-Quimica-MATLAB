clear
clc

global ka kd kr kn u R P S H
% Rate Constants and Mean velocity:
ka = 2; % d^(-1)
kd = 0.6; % d^(-1)
kr = 1; % (kd + ks) - d^(-1)
kn = 0.3; % d^(-1)
u = 15.6; % mi*d^(-1)
R = 5; % mg*L^(-1)*d^(-1)
P = 3; % mg*L^(-1)*d^(-1)
S = 5; % mg*dm^(-2)*d^(-1)
H = 20; % dm

ic = [5, 10, 0];
%xspan = linspace(0,100,200); % Initial and Boundary Conditions
xspan = [0 100];
[x,y] = ode45('streeter_phelps2',xspan,ic); % Solves the Differential Equations

figure
plot(x,y);xlabel('x(mi)');ylabel('L,N,D(mg/L)');legend('L','N','D');

disp('Déficit crítico')
Dc = max(y(:,3))
f = y(:,3)-Dc;
cp = find(f==0);
disp('Ponto crítico')
xc = x(cp)