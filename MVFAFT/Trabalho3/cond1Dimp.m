clear
clc

T0 = 25;
Tf = 50;
Tinf = 19.3;
h = 8;
L = 1;
R = 2.54e-2/2;
t = 1e4;
k = 13.4;
ro = 7971.89;
cp = 502.416;

nz = 200;
nt = 200;

dz = L/nz;
nz = round(nz);
z = (0:nz)*dz;
dt = t/nt;
nt = round(nt);
t = (0:nt)*dt;

T = T0*ones(nz+1,nt+1);
B = zeros(nz+1,1);
% Iteration on t
for n = 2:nt+1
   % Lower x boundary condition
   A(1,1) = 1;
   B(1) = Tf;
   % Internal points
   for i = 2:nz
      A(i,i-1) = -k/(ro*cp)*dt/dz^2;
      A(i,i+1) = -k/(ro*cp)*dt/dz^2;
      A(i,i) = (1 - A(i,i-1)) + (1 - A(i,i+1));
      B(i) = -A(i,i-1)*T(i-1,n-1) + (1 + A(i,i-1))*T(i,n-1) + (1 + A(i,i+1))*T(i,n-1) - A(i,i+1)*T(i+1,n-1);
   end
   % Upper x boundary condition
   A(nz+1,nz+1) = 1;
   B(nz+1) = Tinf;
   % Solving the set of equations
   T(:,n) = A\B;
end

figure
plot(z,T(:,1:nt/10:nt));
title('Perfil de Temperatura')
xlabel('Distância, z(m)')
ylabel('Temperatura, T(ºC)')

figure
surf(t,z,T,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
colorbar
title('Perfil de Temperatura')
xlabel('Tempo, t(s)')
ylabel('Distância, z(m)')
zlabel('Temperatura, T(°C)')