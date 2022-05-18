clear
clc

syms n x t f(x) u(x,t)

L = 100;
tf = 1000;
nx = 50;
nt = 10;
xn = linspace(0,L,nx);
tn = linspace(0,tf,nt);
alpha2 = 1;
f(x) = 25;
T1 = 100;
T2 = 0;

u(x,t) = ((T2-T1)/L*x+T1) + 2/L*symsum((int((f(x)-(T2-T1)/L*x-T1)*sin(n*pi*x/L),x,0,L))*exp(-alpha2*n^2*pi^2*t/L^2)*sin(n*pi*x/L),n,[1; 1000]);

figure
ezsurf(u,[0,tf,0,L]);
shading flat
xlabel('Tempo')
ylabel('Comprimento')
zlabel('Temperatura')
title('\alpha^2.\partial^2u/\partialx^2 = \partialu/\partialt, Solução Analítica')