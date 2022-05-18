clear
clc

T0 = 25+273.15;
Tf = 50+273.15;
Tinf = 19.3+273.15;
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
   A(1,2) = -k/(cp*dz); % Ae
   A(1,1) = ro*dz/dt - 2*A(1,2) - A(1,2) + (h/cp)*(2/R)*dz; % Ap
   B(1) = ro*dz/dt*T(1,n-1) - 2*A(1,2)*Tf + (h/cp)*(2/R)*dz*Tinf; % Bp
   % Internal points
   for i = 2:nz
      A(i,i-1) = -k/(cp*dz); % Aw
      A(i,i+1) = -k/(cp*dz); % Ae
      A(i,i) = ro*dz/dt - A(i,i+1) - A(i,i-1) + (h/cp)*(2/R)*dz; % Ap
      B(i) = ro*dz/dt*T(i,n-1) + (h/cp)*(2/R)*dz*Tinf; % Bp
   end
   % Upper x boundary condition
   A(nz+1,nz) = -k/(cp*dz); % Aw
   A(nz+1,nz+1) = ro*dz/dt - A(nz+1,nz) + (h/cp)/(1+h*dz/(2*k)) + (h/cp)*(2/R)*dz; % Ap
   B(nz+1) = ro*dz/dt*T(nz+1,n-1) + (h/cp)/(1+h*dz/(2*k))*Tinf + (h/cp)*(2/R)*dz*Tinf; % Bp
   % Solving the set of equations
   T(:,n) = A\B;
end

exp = [0.03  41.5+273.15
       0.06  33.5+273.15
       0.12  26.5+273.15
       0.18  24.5+273.15
       0.26  22.4+273.15
       0.34  20.8+273.15
       0.49  19.7+273.15
       0.64  19.5+273.15];

figure
hold on
plot(z,T(:,1:round(nt/10):nt));
plot(exp(:,1),exp(:,2),'LineStyle','none','Marker','x','MarkerEdgeColor','r');
title('Temperature Profile')
xlabel('z(m)')
ylabel('T(ºC)')
hold off

figure
surf(t,z,T,'FaceColor','interp','EdgeColor','none','FaceLighting','phong');
colorbar
title('Temperature Profile')
xlabel('t(s)')
ylabel('z(m)')
zlabel('T(°C)')