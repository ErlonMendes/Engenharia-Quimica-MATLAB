clear
clc

ci = [0,10,0];
tspan = [0 160];
[t,C] = ode45('eutroph_10',tspan,ci);

figure
plot(t,C);
xlabel('t(dias)');
ylabel('C(\mug/L)');
legend('P inorgânico','P fitoplâncton','P orgânico');