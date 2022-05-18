clear
clc

Wspan = [0 50];
ci = [0 450];
[W,X] = ode45('p8_6ode',Wspan,ci);

figure
plot(W,X(:,1))
xlabel('W(kg)')
ylabel('X')

figure
plot(W,X(:,2))
xlabel('W(kg)')
ylabel('T(K)')