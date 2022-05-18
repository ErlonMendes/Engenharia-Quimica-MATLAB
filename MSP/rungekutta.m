% Runge-Kutta's method
clear
clc

tau = 5;
xr(1) = 4;
tf = 5;
nt = 6;
deltat = tf/(nt-1);

for k = 1:nt-1
    m1 = -1/tau*xr(k);
    xm2 = xr(k)+deltat/2*m1;
    m2 = -1/tau*xm2;
    xr(k+1) = xr(k) + m2*deltat;
end

% Solução Analítica
t = linspace(0,tf,nt);
xa = xr(1)*exp(-t/tau);
figure
plot(t,xr,t,xa)
xlabel('t')
ylabel('x')
legend('Runge-Kutta','Analítico')
