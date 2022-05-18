clear
clc

ci = [500,200];
tspan = [0 500];
[t,x] = ode45('predator_prey',tspan,ci);

figure
plot(t,x);xlabel('t(dias)');ylabel('população');legend('coelhos','raposas');

figure
plot(x(:,1),x(:,2));xlabel('coelhos');ylabel('raposas');