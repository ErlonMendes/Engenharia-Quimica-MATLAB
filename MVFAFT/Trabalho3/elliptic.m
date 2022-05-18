function [x,y,U] = elliptic(nx,ny,dx,dy,bc,f)
%ELLIPTIC solution of a two-dimensional elliptic partial
%   differential equation
%
%   [X,Y,U]=ELLIPTIC(NX,NY,DX,DY,BC) solves the Laplace
%   equation for a rectangular object where
%      X = vector of x values
%      Y = vector of y values
%      U = matrix of dependent variable [U(X,Y)]
%      NX = number of divisions in x-direction
%      NY = number of divisions in y-direction
%      DX = x-increment
%      DY = y-increment
%      BC is a matrix of 4x2 or 4x3 containing the types
%      and values of boundary conditions. The order of
%      appearing boundary conditions are lower x, upper x,
%      lower y, and upper y in rows 1 to 4 of the matrix
%      BC, respectively. The first column of BC determines
%      the type of condition:
%         1 for Dirichlet condition, followed by the set
%         value of U in the second column.
%         2 for Neumann condition, followed by the set value
%         of U' in the second column.
%         3 for Robbins condition, followed by the constant
%         and the coefficient of U in the second and third
%         columns, respectively.
%
%   [X,Y,U]=ELLIPTIC(NX,NY,DX,DY,BC,F) solves the Poisson
%   equation for a rectangular object where F is the constant
%   at the right-hand side of the elliptic partial differential
%   equation.
%
%   See also ADAPTMESH, ASSEMPDE, PDENONLIN, POISOLV

% (c) N. Mostoufi & A. Constantinides
% January 1, 1999

% Initialization
if nargin < 5
   error(' Invalid number of inputs.')
end

[a,b]=size(bc);
if a ~= 4
   error(' Invalid number of boundary conditions.')
end
if b < 2 | b > 3
   error(' Invalid boundary condition.')
end
if b == 2 & max(bc(:,1)) <= 2
   bc = [bc zeros(4,1)];
end

if nargin < 6 | isempty(f)
   f = 0;
end

nx = fix(nx);
x = [0:nx]*dx;
ny = fix(ny);
y = [0:ny]*dy;
dx2 = 1/dx^2;
dy2 = 1/dy^2;

% Building the matrix of coefficients and the vector of constants
n = (nx+1)*(ny+1);
A = zeros(n);
c = zeros(n,1);
onex = diag(diag(ones(nx-1)));
oney = diag(diag(ones(ny-1)));

% Internal nodes
i = [2:nx];
for j = 2:ny
   ind = (j-1)*(nx+1)+i;
   A(ind,ind) = -2*(dx2+dy2)*onex;
   A(ind,ind+1) = A(ind,ind+1) + dx2*onex;
   A(ind,ind-1) = A(ind,ind-1) + dx2*onex;
   A(ind,ind+nx+1) = A(ind,ind+nx+1) + dy2*onex;
   A(ind,ind-nx-1) = A(ind,ind-nx-1) + dy2*onex;
   c(ind) = f*ones(nx-1,1);
end

% Lower x boundary condition
switch bc(1,1)
case 1
   ind = ([2:ny]-1)*(nx+1)+1;
   A(ind,ind) = A(ind,ind) + oney;
   c(ind) = bc(1,2)*ones(ny-1,1);
case {2, 3}
   ind = ([2:ny]-1)*(nx+1)+1;
   A(ind,ind) = A(ind,ind) - (3/(2*dx) + bc(1,3))*oney;
   A(ind,ind+1) = A(ind,ind+1) + 2/dx*oney;
   A(ind,ind+2) = A(ind,ind+2) - 1/(2*dx)*oney;
   c(ind) = bc(1,2)*ones(ny-1,1);
end

% Upper x boundary condition
switch bc(2,1)
case 1
   ind = [2:ny]*(nx+1);
   A(ind,ind) = A(ind,ind) + oney;
   c(ind) = bc(2,2)*ones(ny-1,1);
case {2, 3}
   ind = [2:ny]*(nx+1);
   A(ind,ind) = A(ind,ind) + (3/(2*dx) - bc(2,3))*oney;
   A(ind,ind-1) = A(ind,ind-1) - 2/dx*oney;
   A(ind,ind-2) = A(ind,ind-2) + 1/(2*dx)*oney;
   c(ind) = bc(2,2)*ones(ny-1,1);
end

% Lower y boundary condition
switch bc(3,1)
case 1
   ind = [2:nx];
   A(ind,ind) = A(ind,ind) + onex;
   c(ind) = bc(3,2)*ones(nx-1,1);
case {2, 3}
   ind = [2:nx];
   A(ind,ind) = A(ind,ind) - (3/(2*dy) + bc(3,3))*onex;
   A(ind,ind+nx+1) = 2/dy*onex;
   A(ind,ind+2*(nx+1)) = -1/(2*dy)*onex;
   c(ind) = bc(3,2)*ones(nx-1,1);
end

% Upper y boundary condition
switch bc(4,1)
case 1
   ind = ny*(nx+1)+[2:nx];
   A(ind,ind) = A(ind,ind) + onex;
   c(ind) = bc(4,2)*ones(nx-1,1);
case {2, 3}
   ind = ny*(nx+1)+[2:nx];
   A(ind,ind) = A(ind,ind) + (3/(2*dy) - bc(4,3))*onex;
   A(ind,ind-(nx+1)) = A(ind,ind-(nx+1)) - 2/dy*onex;
   A(ind,ind-2*(nx+1)) = A(ind,ind-2*(nx+1)) + 1/(2*dy)*onex;
   c(ind) = bc(4,2)*ones(nx-1,1);
end

% Corner points
A(1,1) = 1;
A(1,2) = -1/2;
A(1,nx+2) = -1/2;
c(1) = 0;

A(nx+1,nx+1) = 1;
A(nx+1,nx) = -1/2;
A(nx+1,2*(nx+1)) = -1/2;
c(nx+1) = 0;

A(ny*(nx+1)+1,ny*(nx+1)+1) = 1;
A(ny*(nx+1)+1,ny*(nx+1)+2) = -1/2;
A(ny*(nx+1)+1,(ny-1)*(nx+1)+1) = -1/2;
c(ny*(nx+1)+1) = 0;

A(n,n) = 1;
A(n,n-1) = -1/2;
A(n,n-(nx+1)) = -1/2;
c(n) = 0;

u = inv(A)*c;	% Solving the set of equations

%Rearranging the final results into matrix format
for k = 1:ny+1
   U(k,1:nx+1) = u((k-1)*(nx+1)+1:k*(nx+1))';
end
