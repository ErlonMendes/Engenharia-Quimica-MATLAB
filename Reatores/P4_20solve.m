clear
clc

ci = [0,1];
Wspan = [0 1000];

[W,x] = ode45('P4_20',Wspan,ci);

figure
plot(W,x);xlabel('W(kg)');ylabel('Convers�o e queda de press�o');legend('X','y');