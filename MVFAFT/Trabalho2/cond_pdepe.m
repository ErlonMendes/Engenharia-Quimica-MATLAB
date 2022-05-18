% Problema puramente difusivo usando a função PDEPE
clear
clc

global alfa T0 T1 T2

% Dados reais:
% T0 = 25; % CI
% T1 = 100; % CC1
% T2 = 0; % CC2
% L = 1; % Comprimento da barra (m)
% t = 1e4; % Tempo de modelagem (s)
% alfa = 1.25e-5; % k/(ro*Cp) real do aço (m^2/s)
% %alfa = 8.81e-5; % k/(ro*Cp) real do alumínio (m^2/s)
% %alfa = 11.22e-5; % k/(ro*Cp) real do cobre (m^2/s)
% %alfa = 2.65e-5; % k/(ro*Cp) real do latão (m^2/s)
% %alfa = 17.34e-5; % k/(ro*Cp) real do prata (m^2/s)
% %alfa = 2.35e-5; % k/(ro*Cp) real do chumbo (m^2/s)

% Dados imaginários:
T0 = 25; % CI
T1 = 100; % CC1
T2 = 0; % CC2
L = 100; % Comprimento da barra (m)
t = 1000; % Tempo de modelagem (s)
alfa = 1; % k/(ro*Cp) (m^2/s)

nx = 200;
nt = 200;
x = linspace(0,L,nt);
tp = linspace(0,t,nt);

m = 0;
sol = pdepe(m,@cond_pde,@cond_ic,@cond_bc,x,tp);

Tf2 = sol(:,:,1);

figure
plot(x,Tf2(1:nt/10:nt,:));
title('Perfil de Temperatura (PDEPE)')
xlabel('Distância, x(m)')
ylabel('Temperatura, T(ºC)')

figure
surf(x,tp,Tf2,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
colorbar
title('Perfil de Temperatura (PDEPE)')
xlabel('Distância, x(m)')
ylabel('Tempo, t(s)')
zlabel('Temperatura, T(°C)')

% Solução Analítica
for i = 1:nt
    for j = 1:nx
        T(i,j) = analytic2( x(j),tp(i),alfa,L,T0,T1,T2 );
    end
end

% Substituição da condição inicial
T(1,:) = T0*ones(1,nx);
T(1,1) = T1;
T(1,nx) = T2;

figure
plot(x,T(1:nt/10:nt,:));
axis([0 L 0 T1])
title('Perfil de Temperatura (Solução Analítica)')
xlabel('Distância, x(m)')
ylabel('Temperatura, T(ºC)')

figure
surf(x,tp,T,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
axis([0 L 0 t 0 T1])
colorbar
title('Perfil de Temperatura (Solução Analítica)')
xlabel('Distância, x(m)')
ylabel('Tempo, t(s)')
zlabel('Temperatura, T(°C)')

% PDEPE vs Analítica
dif = Tf2 - T;
med = median(T,2);
for n=1:nt
    Erro(n,:)=abs((dif(n,:)./med(n)));
end

ErrPDEPE = median(median(Erro))

figure
surf(x,tp,Erro,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
colorbar
title('Solução Analítica vs Solução Numérica (PDEPE)')
xlabel('Distância, x(m)')
ylabel('Tempo, t(s)')
zlabel('abs(T_n_u_m - T_a_n_a)/T_a_n_a_m')