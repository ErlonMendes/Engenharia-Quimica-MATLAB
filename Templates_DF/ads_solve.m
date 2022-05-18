clear
clc
close all

global D v lambda k1 k2 C0 Cin

T = 1;                     % maximum time [s]
L = 1;                     % length [m]
D = 1;                     % diffusivity [m*m/s]
v = 1;                     % velocity [m/s]
lambda = 0.0;              % decay constant [1/s]

k1 = 0.0004;               % sorption parameter 1 (R=0 for linear isotherm with Kd, else k1=R) 
k2 = 0.5;                  % sorption parameter 2 (Kd for linear isotherm with Kd)
rhob = 1300;               % porous medium bulk density [kg/m*m*m]
theta = 0.2;               % porosity [-]
C0 = 0.0;                  % initial concentration [kg/m*m*m]
Cin = 1;                   % boundary concentration [kg/m*m*m]

nt = 40;
nx = 40;
t = linspace(0,T,nt);    % time discretization
x = linspace(0,L,nx);    % space discretization

k1 = rhob*k1/theta;

sol = pdepe(0,@ads_pde,@ads_ci,@ads_cc,x,t);
C = sol(:,:,1);

figure
surf(x,t,C,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
xlabel('Length (m)')
ylabel('Time (s)')
zlabel('Contaminant Concentration, C(kg/m^3)')
colorbar

figure
contour(x,t,C)
xlabel('Length (m)')
ylabel('Time (s)')
zlabel('Contaminant Concentration, C(kg/m^3)')
grid on
colorbar

figure
contourf(x,t,C)
xlabel('Length (m)')
ylabel('Time (s)')
zlabel('Contaminant Concentration, C(kg/m^3)')
grid on
colorbar

figure
plot(x,C'),xlabel('Length (m)');ylabel('Contaminant Concentration, C(kg/m^3)');

figure
plot(t,C),xlabel('Time (s)');ylabel('Contaminant Concentration, C(kg/m^3)');

aviobj = avifile('adsorption.avi','compression','None');
fig=figure;
hold on
for j = 2:size(C,1)
    plot(x,C(j,:),'r');
    legend (['t=' num2str(t(j)) 's']);
    plot(x,C(j-1,:),'b');
    
    F = getframe(fig);
    aviobj = addframe(aviobj,F);
end
hold off
aviobj = close(aviobj);
