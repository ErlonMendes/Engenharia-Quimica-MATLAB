% Euler Expl�cito
clear
clc

tau = 5;
xe(1) = 4;
tf = 20;
nt = 21;
deltat = tf/(nt-1);

for k = 1:nt-1
    xe(k+1) = xe(k) - deltat/tau*xe(k);
end


% Euler Impl�cito
xi(1) = xe(1);

for k = 1:nt-1
    xi(k+1) = (1/(1+deltat/tau))*xi(k);
end

% Solu��o Anal�tica
t = linspace(0,tf,nt);
xa = xe(1)*exp(-t/tau);
figure
plot(t,xe,t,xi,t,xa)
xlabel('t')
ylabel('x')
legend('Euler Expl�cito','Euler Impl�cito','Solu��o Anal�tica')


