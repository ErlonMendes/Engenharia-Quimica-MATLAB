clear
clc

Wspan = [0 37];
ci = [0 450 1];
[W,X] = ode45('p8_7ode',Wspan,ci);

figure
plot(W,X(:,1),W,X(:,3))
xlabel('W(kg)')
legend('X','y')

figure
plot(W,X(:,2))
xlabel('W(kg)')
ylabel('T(K)')