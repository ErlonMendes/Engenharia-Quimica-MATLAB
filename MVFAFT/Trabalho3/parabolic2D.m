function [x,y,t,u] = parabolic2D(nx,ny,nt,dx,dy,dt,alpha,...
   u0,bc,func,varargin)
%PARABOLIC2D solution of a two-dimensional parabolic partial
%   differential equation
%
%   [X,Y,T,U]=PARABOLIC2D(NX,NY,NT,DX,DY,DT,ALPHA,U0,BC) solves 
%   the homogeneous parabolic equation by explicit (6.66) 
%   formula where
%      X = vector of x values
%      Y = vector of y values
%      T = vector of T values
%      U = 3D array of dependent variable [U(X,Y,T)]
%      NX = number of divisions in x-direction
%      NY = number of divisions in y-direction
%      NT = number of divisions in t-direction
%      DX = x-increment
%      DY = y-increment
%      DT = t-increment (leave empty to use the default value)
%      ALPHA = coefficient of equation
%      U0 = matrix of U-distribution at T=0 [U0(X,Y)]
%      BC is a matrix of 4x2 or 4x3 containing the types and values
%      of boundary conditions in x- and y-directions. The order of
%      appearing boundary conditions are lower x, upper x, lower y,
%      and upper y in rows 1 to 4 of the matrix BC, respectively.
%      The first column of BC determines the type of condition:
%         1 for Dirichlet condition, followed by the set
%         value of U in the second column.
%         2 for Neumann condition, followed by the set value
%         of U' in the second column.
%         3 for Robbins condition, followed by the constant
%         and the coefficient of U in the second and third
%         column, respectively.
%
%   [X,Y,T,U]=PARABOLIC2D(NX,NY,NT,DX,DY,DT,ALPHA,U0,BC,F,P1,P2,...)
%   solves the nonhomogeneous parabolic equation where F(U,X,Y,T) 
%   is a function described in the M-file F.M. The extra 
%   parameters P1, P2, ... are passed directly to the function 
%   F(U,X,Y,T,P1,P2,...).
%
%   See also PARABOLIC1D, PARABOLIC

% (c) N. Mostoufi & A. Constantinides
% January 1, 1999

% Initialization
if nargin < 9
   error(' Invalid number of inputs.')
end

nx = fix(nx);
x = [0:nx]*dx;
ny = fix(ny);
y = [0:ny]*dy;

% Checking dt for stability
tmax = dt*nt;
if isempty(dt) | dt > (dx^2+dy^2)/(16*alpha)
   dt = (dx^2+dy^2)/(16*alpha);
   nt = tmax/dt+1;
   fprintf('\n dt is adjusted to %6.2e (nt=%3d)',dt,fix(nt))
end

nt = fix(nt);
t = [0:nt]*dt;
rx = alpha*dt/dx^2;
ry = alpha*dt/dy^2;

[r0,c0] = size(u0);
if r0 ~= nx+1 | c0 ~= ny+1
   error(' Size of the matrix of initial condition is not correct.')
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

% Solution of differential equation
u(:,:,1) = u0;
for n = 1:nt				% Iteration on t
   for i = 2:nx			% Iteration on x
      for j = 2:ny		% Iteration on y
         u(i,j,n+1) = rx*(u(i+1,j,n)+u(i-1,j,n))+ ry*(u(i,j+1,n)...
            + u(i,j-1,n)) + (1-2*rx-2*ry)*u(i,j,n);
         if nargin >= 10
            u(i,j,n+1) = u(i,j,n+1) +...
               dt*feval(func,u(i,j,n),x(i),y(j),t(n),varargin{:});
         end
      end
   end

   % Lower x boundary condition
   switch bc(1,1)
   case 1
      u(1,2:ny,n+1) = bc(1,2) * ones(1,ny-1,1);
   case {2, 3}
      u(1,2:ny,n+1) = (-2*bc(1,2)*dx + 4*u(2,2:ny,n+1)...
         - u(3,2:ny,n+1)) / (2*bc(1,3)*dx + 3);
   end
   
   % Upper x boundary condition
   switch bc(2,1)
   case 1
      u(nx+1,2:ny,n+1) = bc(2,2) * ones(1,ny-1,1);
   case {2, 3}
      u(nx+1,2:ny,n+1) = (-2*bc(2,2)*dx - 4*u(nx,2:ny,n+1) ...
         + u(nx-1,2:ny,n+1)) / (2*bc(2,3)*dx - 3);
   end
   
   % Lower y boundary condition
   switch bc(3,1)
   case 1
      u(2:nx,1,n+1) = bc(3,2) * ones(nx-1,1,1);
   case {2, 3}
      u(2:nx,1,n+1) = (-2*bc(3,2)*dy + 4*u(2:nx,2,n+1) ...
         - u(2:nx,3,n+1)) / (2*bc(3,3)*dy + 3);
   end
   
   % Upper y boundary condition
   switch bc(4,1)
   case 1
      u(2:nx,ny+1,n+1) = bc(4,2) * ones(nx-1,1,1);
   case {2, 3}
      u(2:nx,ny+1,n+1) = (-2*bc(4,2)*dy - 4*u(2:nx,ny,n+1) ...
         + u(2:nx,ny-1,n+1)) / (2*bc(4,3)*dy - 3);
   end
end

% Corner nodes
u(1,1,:) = (u(1,2,:) + u(2,1,:)) / 2;
u(nx+1,1,:) = (u(nx+1,2,:) + u(nx,1,:)) / 2;
u(1,ny+1,:) = (u(1,ny,:) + u(2,ny+1,:)) / 2;
u(nx+1,ny+1,:) = (u(nx+1,ny,:) + u(nx,ny+1,:)) / 2; 