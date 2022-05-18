% Solução analítica para problema puramente difusivo
clear
clc

L = 100; % Comprimento da barra (m)
t = 1000; % Tempo de modelagem (s)
T0 = 25; % Temperatura no centro da barra (°C)
alfa = 1; % k/(ro*Cp) (m^2/s)

nx = 200; % Número de pontos na distância x
nt = 200; % Número de pontos no tempo t

x = linspace(0,L,nx);
tp = linspace(0,t,nt);

for i = 1:nt
    for j = 1:nx
        T(i,j) = analytic( x(j),tp(i),alfa,L,T0 );
    end
end

figure
plot(x,T(1:nt/10:nt,:));
axis([0 L 0 T0])
title('Perfil de Temperatura (Solução Analítica)')
xlabel('Distância, x(m)')
ylabel('Temperatura, T(ºC)')

figure
surf(x,tp,T,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
axis([0 L 0 t 0 T0])
colorbar
title('Perfil de Temperatura (Solução Analítica)')
xlabel('Distância, x(m)')
ylabel('Tempo, t(s)')
zlabel('Temperatura, T(°C)')