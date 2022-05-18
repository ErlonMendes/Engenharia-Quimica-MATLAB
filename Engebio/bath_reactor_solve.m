clear
clc

ci = [0.01,25,0];
tspan = linspace(0,110,30);
[t,x] = ode45('bath_reactor',tspan,ci);

figure
plot(t,x);xlabel('t(h)');ylabel('X,S,P(g/L)');legend('X','S','P');