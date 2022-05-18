clear
clc
close all

ci = 0;
Vspan = [0 3.5];

[V,X] = ode45('ex8_6',Vspan,ci);

figure
plot(V,X)
xlabel('V(m^3)')
ylabel('X')

T = 330 + 43.3*X;

figure
plot(V,T)
xlabel('V(m^3)')
ylabel('T(K)')

Ca0 = 9.3;
k = 33.1*exp(7906*(T-360)./(T*360));
Kc = 3.03*exp(-830.3*((T-333)./(T*333)));
ra = -k*Ca0.*(1-(1+1./Kc).*X);

figure
plot(V,-ra)
xlabel('V(m^3)')
ylabel('-r_A(kmol.m^-^3.h^-^1)')