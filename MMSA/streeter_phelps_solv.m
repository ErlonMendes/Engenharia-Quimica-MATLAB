clear
clc

global ka kd u
% Rate Constants and Mean velocity:
ka = 2.0; % d^(-1)
kd = 0.6; % d^(-1)
u = 15.6; % mi*d^(-1)

ic = [8,0]; xspan = [0 100]; % Initial and Boundary Conditions
[x,y] = ode45('streeter_phelps',xspan,ic); % Solves the Differential Equations

figure
plot(x,y);xlabel('x(mi)');ylabel('L,D(mg/L)');legend('L','D');

disp('Déficit crítico')
Dc = max(y(:,2))
f = y(:,2)-Dc;
cp = find(f==0);
disp('Ponto crítico')
xc = x(cp)

disp('Ponto crítico analítico')
xc = u/(ka-kd)*log(ka/kd)