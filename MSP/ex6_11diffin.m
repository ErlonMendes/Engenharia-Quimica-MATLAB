% Resolve o Exemplo 6.11 (CONSTANTINIDES, 2000)
clear % Limpa as variáveis presentes no Workspace
clc % Limpa os comandos presentes no Command Window

R = 0.27/2; % m
a = 19e-3/2; % m
tf = 400; % s
Dsr = 2e-4; % Coeficiente de dispersão radial do sólido (m^2/s)

% Criação da malha computacional
nr = 100;
deltar = (R-a)/nr;
deltat = 1/(2*Dsr/deltar^2);
nt = fix(tf/deltat);
r = linspace(a,R,nr);
t = linspace(0,tf,nt);

% Condição inicial
C(1:nr,1:nt) = 0;

% Aplicação do método de diferenças finitas
for n = 1:nt
    C(1,n) = 100;
    C(nr,n) = (4*C(nr-1,n)-C(nr-2,n))/3;
    for i = 2:nr-1
        C(i,n+1) = Dsr*deltat*(1/r(i)/2/deltar*(C(i+1,n)-C(i-1,n)) + 1/deltar^2*(C(i+1,n)-2*C(i,n)+C(i-1,n))) + C(i,n);
    end
end

figure % Construção do gráfico de C(%) vs r(m) e t(s)
surf(r,t,C(:,1:nt)','FaceColor','interp','EdgeColor','none','FaceLighting','phong')
colorbar
xlabel('Raio r(m)')
ylabel('Tempo t(s)')
zlabel('Concentração, C(%)')
