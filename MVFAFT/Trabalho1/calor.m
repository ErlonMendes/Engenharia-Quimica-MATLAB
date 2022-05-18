function [ q ] = calor( y,ub )

mi = 1.003*10^-3; % Pa*s
k = 0.61; %W/(m.K)
y0 = 15*10^-2; % m
T1 = 90; % °C
T0 = 20; % °C

q = abs((3*mi*ub.^2/y0^4)*y.^3-k*(T1-T0)/(2*y0));