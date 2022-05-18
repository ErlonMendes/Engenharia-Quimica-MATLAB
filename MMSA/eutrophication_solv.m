% Dynamic simulation program that solves the set of ordinary differential equations for eutrophication of lakes
clear
clc

ic = [1, 1, 1, 1, 1, 1, 1, 1, 1]; tspan = [0 150]; % Initial and Boundary Conditions
[t,C] = ode45('eutrophication',tspan,ic); % Solves the Differential Equations

figure
plot(t,C)
xlabel('t(d)')
ylabel('C(mg/L)')
legend('Si','P','N1','N2','B','D','Z','F1','F2');

