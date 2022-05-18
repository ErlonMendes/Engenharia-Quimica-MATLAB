% Modelagem de contaminante em águas subterrâneas
clear % Limpa as variáveis presentes no Workspace
clc % Limpa os comandos presentes no Command Window

L = 2; % m
tf = 100; % dias

R = 2;
ux = 0.02; % m*d^(-1)
alfa = 1;
Dab = 1e-4; % m^2*d^(-1)
Dx = alfa*ux + Dab; % m^2*d^(-1)
k = 0.03; % d^(-1)

% Criação da malha computacional
nx = 100;
deltax = L/nx;
deltat = 1/(ux/R/deltax + 2*Dx/R/deltax^2 + k/R);
nt = fix(tf/deltat);
x = linspace(0,L,nx);
t = linspace(0,tf,nt);

% Condição inicial
C(1:nx,1:nt) = 0;

% Aplicação do método de diferenças finitas
for n = 1:nt
    C(1,n) = 1;
    C(nx,n) = (4*C(nx-1,n)-C(nx-2,n))/3;
    for i = 2:nx-1
        C(i,n+1) = -ux/R*deltat/deltax*(C(i,n)-C(i-1,n)) + Dx/R*deltat/deltax^2*(C(i+1,n)-2*C(i,n)+C(i-1,n)) - k/R*deltat*C(i,n) + C(i,n);
    end
end

figure % Construção do gráfico de C(%) vs r(m) e t(s)
surf(x,t,C(:,1:nt)','FaceColor','interp','EdgeColor','none','FaceLighting','phong')
xlabel('x(m)')
ylabel('t(d)')
zlabel('C(mg/L)')
