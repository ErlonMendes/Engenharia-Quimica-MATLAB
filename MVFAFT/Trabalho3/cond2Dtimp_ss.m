clear
clc

Tfw = 250;
Tfe = 100;
Tfs = 500;
Tfn = 50;
Lx = 1;
Ly = 1;
% k = 13.4;
% ro = 7971.89;
% cp = 502.416;
k = 1;
ro = 1;
cp = 1;

nx = 50;
ny = 50;

dx = Lx/nx;
nx = round(nx);
x = (0:nx)*dx;
dy = Ly/ny;
ny = round(ny);
y = (0:ny)*dy;

f = 0;

% Building the matrix of coefficients and the vector of constants
n = (nx+1)*(ny+1);
A = zeros(n);
B = zeros(n,1);
onex = diag(diag(ones(nx-1)));
oney = diag(diag(ones(ny-1)));

% Iteration on t
i = [2:nx];
% Internal points
As = k/(cp*dy)*dx; % As
An = k/(cp*dy)*dx; % An
Aw = k/(cp*dx)*dy; % Aw
Ae = k/(cp*dx)*dy; % Ae
Ap = Ae + Aw + An + As; % Ap
for j = 2:ny
   ind = (j-1)*(nx+1)+i;
   A(ind,ind) = -Ap*onex;
   A(ind,ind+1) = A(ind,ind+1) + Ae*onex;
   A(ind,ind-1) = A(ind,ind-1) + Aw*onex;
   A(ind,ind+nx+1) = A(ind,ind+nx+1) + An*onex;
   A(ind,ind-nx-1) = A(ind,ind-nx-1) + As*onex;
   B(ind) = f*ones(nx-1,1); % Bp
end

% Lower x boundary condition
ind = ([2:ny]-1)*(nx+1)+1;
A(ind,ind) = A(ind,ind) + oney;
B(ind) = Tfw*ones(ny-1,1);

% Upper x boundary condition
ind = [2:ny]*(nx+1);
A(ind,ind) = A(ind,ind) + oney;
B(ind) = Tfe*ones(ny-1,1);

% Lower y boundary condition
ind = [2:nx];
A(ind,ind) = A(ind,ind) + onex;
B(ind) = Tfs*ones(nx-1,1);

% Upper y boundary condition
ind = ny*(nx+1)+[2:nx];
A(ind,ind) = A(ind,ind) + onex;
B(ind) = Tfn*ones(nx-1,1);

% Corner points
A(1,1) = 1;
A(1,2) = -1/2;
A(1,nx+2) = -1/2;
B(1) = 0;

A(nx+1,nx+1) = 1;
A(nx+1,nx) = -1/2;
A(nx+1,2*(nx+1)) = -1/2;
B(nx+1) = 0;

A(ny*(nx+1)+1,ny*(nx+1)+1) = 1;
A(ny*(nx+1)+1,ny*(nx+1)+2) = -1/2;
A(ny*(nx+1)+1,(ny-1)*(nx+1)+1) = -1/2;
B(ny*(nx+1)+1) = 0;

A(n,n) = 1;
A(n,n-1) = -1/2;
A(n,n-(nx+1)) = -1/2;
B(n) = 0;

T = A\B;	% Solving the set of equations

%Rearranging the final results into matrix format
for k = 1:ny+1
   T2d(k,1:nx+1) = T((k-1)*(nx+1)+1:k*(nx+1))';
end

figure
surf(y,x,T2d','FaceColor','interp','EdgeColor','none','FaceLighting','phong');
colorbar
title('Temperature Profile')
xlabel('y(m)')
ylabel('x(m)')
zlabel('T(°C)')