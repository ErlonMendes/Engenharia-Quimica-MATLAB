% Runge-Kutta's method for multivariable problems
clear
clc

Beta1 = 2.5;
Beta2 = 5/sqrt(6);
A1 = 5;
A2 = 10;
F = 5;
h = [12
     7];
tf = 100;
nt = 501;
deltat = tf/(nt-1);

for k = 1:nt-1
    m1 = [F/A1 - Beta1/A1*sqrt(h(1,k)-h(2,k))
          Beta1/A2*sqrt(h(1,k)-h(2,k)) - Beta2/A2*sqrt(h(2,k))];
    hm2 = [h(1,k) + deltat/2*m1(1)
           h(2,k) + deltat/2*m1(2)];
    m2 = [F/A1 - Beta1/A1*sqrt(hm2(1)-hm2(2))
          Beta1/A2*sqrt(hm2(1)-hm2(2)) - Beta2/A2*sqrt(hm2(2))];
    h(:,k+1) = h(:,k) + m2*deltat;
end

t = linspace(0,tf,nt);
figure
plot(t,h)
xlabel('t (min)')
ylabel('h (ft)')
legend('h1','h2')
