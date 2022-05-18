% M�todo das diferen�as finitas aplicado a problema puramente difusivo
clear
clc

global alfa T0 T1 T2
tic

% Dados reais:
% T0 = 25; % CI
% T1 = 100; % CC1
% T2 = 0; % CC2
% L = 1; % Comprimento da barra (m)
% t = 1e4; % Tempo de modelagem (s)
% alfa = 1.25e-5; % k/(ro*Cp) real do a�o (m^2/s)
% %alfa = 8.81e-5; % k/(ro*Cp) real do alum�nio (m^2/s)
% %alfa = 11.22e-5; % k/(ro*Cp) real do cobre (m^2/s)
% %alfa = 2.65e-5; % k/(ro*Cp) real do lat�o (m^2/s)
% %alfa = 17.34e-5; % k/(ro*Cp) real do prata (m^2/s)
% %alfa = 2.35e-5; % k/(ro*Cp) real do chumbo (m^2/s)
% 
% deltax = 5e-3;
% deltat = 5e1;

% Dados imagin�rios:
T0 = 25; % CI
T1 = 100; % CC1
T2 = 0; % CC2
L = 100; % Comprimento da barra (m)
t = 1000; % Tempo de modelagem (s)
alfa = 1; % k/(ro*Cp) (m^2/s)

deltax = 0.5;
deltat = 5;

nx = L/deltax;
nt = t/deltat;
T = T0*ones(1,nx);
T(1) = T1;
T(nx) = T2;
T0f = T;
Tf = T;

for n = 1:nt-1
    k = 1;
    eps = 1;
    while eps>=1e-5
        Tw = T(k,1);
        for i = 1:nx-2
            Te = T(k,i+2);
            Tp(i) = cond_eq( Te,Tw,T0f(i+1),deltat,deltax,alfa );
            Tw = Tp(i);
        end
        T = [T
             T1,Tp,T2];
        eps = sum(abs((T(k+1,:)-T(k,:))/median(T(k,:)))); % Par�metro de converg�ncia
        epsa(k,n)=eps; % Armazenamento dos erros de itera��o
        k = k + 1;
    end
    % An�lise de itera��es
    if n == 1
        It = k;
    else
        It = [It,k];
    end
    Tf = [Tf
          T(k,:)];
    T = T(k,:);
    T0f = T;
end

It
toc

x = linspace(0,L,nx);
tp = linspace(0,t,nt);

figure
surf(epsa,'FaceColor','interp','EdgeColor','none','FaceLighting','phong');
colorbar
title('Desvio (M�todo de Gauss-Seidel)')
xlabel('n')
ylabel('k')
zlabel('sum(abs(T_(_k_) - T_(_k_-_1_))/T_(_k_-_1_)_m)')

figure
plot(x,Tf(1:nt/10:nt,:));
title('Perfil de Temperatura (M�todo de Gauss-Seidel)')
xlabel('Dist�ncia, x(m)')
ylabel('Temperatura, T(�C)')

figure
surf(x,tp,Tf,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
colorbar
title('Perfil de Temperatura (M�todo de Gauss-Seidel)')
xlabel('Dist�ncia, x(m)')
ylabel('Tempo, t(s)')
zlabel('Temperatura, T(�C)')

% Solu��o Anal�tica
for i = 1:nt
    for j = 1:nx
        T(i,j) = analytic2( x(j),tp(i),alfa,L,T0,T1,T2 );
    end
end

% Substitui��o da condi��o inicial
T(1,:) = T0*ones(1,nx);
T(1,1) = T1;
T(1,nx) = T2;

figure
plot(x,T(1:nt/10:nt,:));
axis([0 L 0 max(max(T))])
title('Perfil de Temperatura (Solu��o Anal�tica)')
xlabel('Dist�ncia, x(m)')
ylabel('Temperatura, T(�C)')

figure
surf(x,tp,T,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
axis([0 L 0 t 0 max(max(T))])
colorbar
title('Perfil de Temperatura (Solu��o Anal�tica)')
xlabel('Dist�ncia, x(m)')
ylabel('Tempo, t(s)')
zlabel('Temperatura, T(�C)')

% Gauss vs Anal�tica
dif = Tf - T;
med = median(T,2);
for n=1:nt
    Erro(n,:)=abs((dif(n,:)./med(n)));
end

ErrGauss = median(median(Erro))

figure
surf(x,tp,Erro,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
colorbar
title('Solu��o Anal�tica vs Solu��o Num�rica (M�todo de Gauss-Seidel)')
xlabel('Dist�ncia, x(m)')
ylabel('Tempo, t(s)')
zlabel('abs(T_n_u_m - T_a_n_a)/T_a_n_a_m')