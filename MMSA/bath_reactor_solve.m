clear
clc
close all

ci = [0.013,6,0];
tspan = linspace(0,42,30);
[t,x] = ode45('bath_reactor',tspan,ci);

figure
plot(t,x);xlabel('t(h)');ylabel('X,S,P(g/L)');legend('X','S','P','Location','best','Orientation','horizontal');