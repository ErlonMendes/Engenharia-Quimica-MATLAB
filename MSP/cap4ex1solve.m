clear
clc

global alfa beta

tf = 10;
nt = 501;
alfa = 1.0;
beta = 1.0;

% Solução usando a ode45:
ci = [1.5,0.75];
tspan = linspace(0,tf,nt);
[t,y] = ode45('cap4ex1ode',tspan,ci);

figure
plot(t,y)
title('ode45')
xlabel('t')
ylabel('y')
legend('y_1','y_2')

% Solução por Euler explícito:
y = [1.5
     0.75];

deltat = tf/(nt-1);

for k = 1:nt-1
    fyk = [alfa*(1-y(2,k))*y(1,k)
           -beta*(1-y(1,k))*y(2,k)];
    y(:,k+1) = y(:,k) + deltat*fyk;
end

t = linspace(0,tf,nt);

figure
plot(t,y)
title('Euler explícito')
xlabel('t')
ylabel('y')
legend('y_1','y_2')

% Solução por Runge-Kutta:
y = [1.5
     0.75];

deltat = tf/(nt-1);

for k = 1:nt-1
    m1 = [alfa*(1-y(2,k))*y(1,k)
          -beta*(1-y(1,k))*y(2,k)];
    ym2 = [y(1,k) + deltat/2*m1(1)
           y(2,k) + deltat/2*m1(2)];
    m2 = [alfa*(1-ym2(2))*ym2(1)
          -beta*(1-ym2(1))*ym2(2)];
    y(:,k+1) = y(:,k) + m2*deltat;
end

t = linspace(0,tf,nt);

figure
plot(t,y)
title('Runge-Kutta')
xlabel('t')
ylabel('y')
legend('y_1','y_2')
