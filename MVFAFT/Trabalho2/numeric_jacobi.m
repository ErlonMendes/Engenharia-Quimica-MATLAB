% Método das diferenças finitas aplicado a problema puramente difusivo
clear
clc
tic

T0 = 25; % CI
T1 = 0; % CC1
T2 = 0; % CC2
L = 100; % Comprimento da barra (m)
t = 1000; % Tempo de modelagem (s)
alfa = 1; % k/(ro*Cp) (m^2/s)

deltax = 0.5;
deltat = 5;

nx = L/deltax;
nt = t/deltat;
x = linspace(0,L,nx);
T = T0*sin(pi/L.*x);
T0f = T;
Tf = T;
T(1) = T1;
T(nx) = T2;

for n = 1:nt-1
    k = 1;
    eps = 1;
    while eps>=1e-5
        for i = 1:nx-2
            Tw = T(k,i);
            Te = T(k,i+2);
            Tp(i) = cond_eq( Te,Tw,T0f(i+1),deltat,deltax,alfa );
        end
        T = [T
             T1,Tp,T2];
        eps = sum(abs((T(k+1,:)-T(k,:))/median(T(k,:)))); % Parâmetro de convergência
        epsa(k,n)=eps; % Armazenamento dos erros de iteração
        k = k + 1;
    end
    % Análise de iterações
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
title('Desvio (Método de Jacobi)')
xlabel('n')
ylabel('k')
zlabel('sum(abs(T_(_k_) - T_(_k_-_1_))/T_(_k_-_1_)_m)')

figure
plot(x,Tf(1:nt/10:nt,:));
axis([0 L 0 T0])
title('Perfil de Temperatura (Método de Jacobi)')
xlabel('Distância, x(m)')
ylabel('Temperatura, T(ºC)')

figure
surf(x,tp,Tf,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
axis([0 L 0 t 0 T0])
colorbar
title('Perfil de Temperatura (Método de Jacobi)')
xlabel('Distância, x(m)')
ylabel('Tempo, t(s)')
zlabel('Temperatura, T(°C)')

% Solução Analítica
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

% Jacobi vs Analítica
dif = Tf - T;
med = median(T,2);
for n=1:nt
    Erro(n,:)=abs((dif(n,:)./med(n)));
end

ErrJacobi = median(median(Erro))

figure
surf(x,tp,Erro,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
colorbar
title('Solução Analítica vs Solução Numérica (Método de Jacobi)')
xlabel('Distância, x(m)')
ylabel('Tempo, t(s)')
zlabel('abs(T_n_u_m - T_a_n_a)/T_a_n_a_m')