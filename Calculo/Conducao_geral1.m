clear
clc

syms n x t f(x) u(x,t)

L = pi;
tf = 1.5;
nx = 50;
nt = 10;
xn = linspace(0,L,nx);
tn = linspace(0,tf,nt);
alpha2 = 1;
f(x) = 100;

u(x,t) = 2/L*symsum((int(f(x)*sin(n*pi*x/L),x,0,L))*exp(-alpha2*n^2*pi^2*t/L^2)*sin(n*pi*x/L),n,[1; 1000]);

figure
ezsurf(u,[0,tf,0,L])
shading flat
xlabel('Tempo')
ylabel('Comprimento')
zlabel('Temperatura')
title('\alpha^2.\partial^2u/\partialx^2 = \partialu/\partialt')