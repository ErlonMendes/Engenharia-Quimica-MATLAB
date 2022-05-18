function [ T ] = analytic2( x,t,alfa,L,T0,T1,T2 )
nt = 100; % N�mero total de pontos
ni = nt/2-1; % N�mero de pontos �mpares
np = nt/2; % N�mero de pontos pares
n = 1;
s = (2/(n*pi))*(2*T0-T1-T2)*exp(-alfa*((n^2*pi^2)/L^2)*t)*sin((n*pi/L)*x); % Primeiro termo do somat�rio
for n = 3:2:ni
    s = s + (2/(n*pi))*(2*T0-T1-T2)*exp(-alfa*((n^2*pi^2)/L^2)*t)*sin((n*pi/L)*x);
end
for n = 2:2:np
    s = s + (2/(n*pi))*(T2-T1)*exp(-alfa*((n^2*pi^2)/L^2)*t)*sin((n*pi/L)*x);
end
T = T1 + (T2-T1)*x/L + s;
end