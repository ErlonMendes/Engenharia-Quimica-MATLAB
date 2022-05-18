clear
clc
global f
tspan = [0 22];
ci = [60,0.2,0.125];
f = 0;
[t1,C1] = ode45('metano_ode',tspan,ci);

tspan = [22 45];
ci = [C1(end,1),C1(end,2),C1(end,3)];
f = 0.8;
[t2,C2] = ode45('metano_ode',tspan,ci);

tspan = [45 58];
ci = [C2(end,1),C2(end,2),C2(end,3)];
f = 1;
[t3,C3] = ode45('metano_ode',tspan,ci);

tspan = [58 63];
ci = [C3(end,1),C3(end,2),C3(end,3)];
f = 0;
[t4,C4] = ode45('metano_ode',tspan,ci);

t = [t1;t2;t3;t4];
C = [C1;C2;C3;C4];

figure
plot(t,C(:,1))
xlabel('t(dias)')
ylabel('S(mg/L)')

figure
plot(t,C(:,2))
xlabel('t(dias)')
ylabel('X(mg/L)')

figure
plot(t,C(:,3))
xlabel('t(dias)')
ylabel('M(mg/L)')

