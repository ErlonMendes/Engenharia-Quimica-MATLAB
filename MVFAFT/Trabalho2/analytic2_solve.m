% Solu��o anal�tica para problema puramente difusivo
clear
clc

tic

% Dados reais:
T0 = 25; % CI
T1 = 100; % CC1
T2 = 0; % CC2
L = 1; % Comprimento da barra (m)
t = 1e4; % Tempo de modelagem (s)
%alfa = 8.81e-5; % k/(ro*Cp) real do alum�nio (m^2/s)
alfa = 1.25e-5; % k/(ro*Cp) real do a�o (m^2/s)
%alfa = 11.22e-5; % k/(ro*Cp) real do cobre (m^2/s)
%alfa = 2.65e-5; % k/(ro*Cp) real do lat�o (m^2/s)
%alfa = 17.34e-5; % k/(ro*Cp) real do prata (m^2/s)
%alfa = 2.35e-5; % k/(ro*Cp) real do chumbo (m^2/s)

% Dados imagin�rios:
% T0 = 25; % CI
% T1 = 100; % CC1
% T2 = 0; % CC2
% L = 100; % Comprimento da barra (m)
% t = 1000; % Tempo de modelagem (s)
% alfa = 1; % k/(ro*Cp) (m^2/s)

nx = 200; % N�mero de pontos na dist�ncia x
nt = 200; % N�mero de pontos no tempo t

x = linspace(0,L,nx);
tp = linspace(0,t,nt);

for i = 1:nt
    for j = 1:nx
        T(i,j) = analytic2( x(j),tp(i),alfa,L,T0,T1,T2 );
    end
end

% Substitui��o da condi��o inicial
T(1,:) = T0*ones(1,nx);
T(1,1) = T1;
T(1,nx) = T2;

toc

figure
plot(x,T(1:nt/10:nt,:));
axis([0 L 0 T1])
title('Perfil de Temperatura (Solu��o Anal�tica)')
xlabel('Dist�ncia, x(m)')
ylabel('Temperatura, T(�C)')

figure
surf(x,tp,T,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
axis([0 L 0 t 0 T1])
colorbar
title('Perfil de Temperatura (Solu��o Anal�tica)')
xlabel('Dist�ncia, x(m)')
ylabel('Tempo, t(s)')
zlabel('Temperatura, T(�C)')