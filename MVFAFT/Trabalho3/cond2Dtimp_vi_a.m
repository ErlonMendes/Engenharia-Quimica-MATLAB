clear
clc

T0 = 25;
Tf = 50;
Tinf = 19.3;
h = 8;
Lx = 1;
Ly = 2.54e-2/2;
R = 2.54e-2/2;
t = 1e4;
k = 13.4;
ro = 7971.89;
cp = 502.416;

nx = 200;
ny = 200;
nt = 200;

dx = Lx/nx;
nx = round(nx);
x = (0:nx-1)*dx;
dy = Ly/ny;
ny = round(ny);
y = (0:ny-1)*dy;
dt = t/nt;
nt = round(nt);
t = (0:nt-1)*dt;

T = T0*ones(nx,nt);
B = zeros(nx,1);

desl = 6;
% Iteration on t
for n = 2:nt
   % Internal points
   %As = -k/(cp*dy)*dx; % As
   %An = -k/(cp*dy)*dx; % An
   %Aw = -k/(cp*dx)*dy; % Aw
   Aw = -k/(cp*dx);
   %Ae = -k/(cp*dx)*dy; % Ae
   Ae = -k/(cp*dx);
   %Ap = ro*dx*dy/dt - Ae - Aw - An - As; % Ap
   Ap = ro*dx/dt - Ae - Aw + (h/cp)*(2/R)*dx; % Ap
   %A = diag(Ap*ones(nx,1),0)+diag(Ae*ones(nx-1,1),1)+diag(Aw*ones(nx-1,1),-1)+diag(An*ones(nx-desl,1),desl)+diag(As*ones(nx-desl,1),-desl);
   A = diag(Ap*ones(nx,1),0)+diag(Ae*ones(nx-1,1),1)+diag(Aw*ones(nx-1,1),-1);
   for i = 2:nx-1
       B(i) = ro*dx/dt*T(i,n-1) + (h/cp)*(2/R)*dx*Tinf; % Bp
   end
   % Lower x boundary condition
   A(1,1) = ro*dx/dt - 2*Ae - Ae + (h/cp)*(2/R)*dx; % Ap
   B(1) = ro*dx/dt*T(1,n-1) - 2*Ae*Tf + (h/cp)*(2/R)*dx*Tinf; % Bp
   % Upper x boundary condition
   A(nx,nx) = ro*dx/dt - 2*Aw - Aw + (h/cp)*(2/R)*dx; % Ap
   B(nx) = ro*dx/dt*T(nx,n-1) - 2*Aw*Tinf + (h/cp)*(2/R)*dx*Tinf; % Bp
   % Solving the set of equations
   T(:,n) = A\B;
end
exp = [0.03  41.5
       0.06  33.5
       0.12  26.5
       0.18  24.5
       0.26  22.4
       0.34  20.8
       0.49  19.7
       0.64  19.5];

figure
hold on
plot(x,T(:,1:round(nt/10):nt));
plot(exp(:,1),exp(:,2),'LineStyle','none','Marker','x','MarkerEdgeColor','r');
title('Temperature Profile')
xlabel('x(m)')
ylabel('T(ºC)')
hold off

figure
surf(t,x,T,'FaceColor','interp','EdgeColor','none','FaceLighting','phong');
colorbar
title('Temperature Profile')
xlabel('t(s)')
ylabel('x(m)')
zlabel('T(°C)')