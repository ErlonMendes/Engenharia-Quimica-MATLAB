function [x,t,u] = parabolic1D(nx,nt,dx,dt,alpha,u0,bc,func,varargin)
%PARABOLIC1D solution of a one-dimensional parabolic partial
%   differential equation
%
%   [X,T,U]=PARABOLIC1D(NX,NT,DX,DT,ALPHA,U0,BC) solves the
%   homogeneous parabolic equation by Crank-Nicolson implicit
%   formula where
%      X = vector of x values
%      T = vector of T values
%      U = matrix of dependent variable [U(X,T)]
%      NX = number of divisions in x-direction
%      NT = number of divisions in t-direction
%      DX = x-increment
%      DT = t-increment
%      ALPHA = coefficient of equation
%      U0 = vector of U-distribution at T=0
%      BC is a matrix of 2x2 or 2x3 containing the types
%      and values of boundary conditions in x-direction.
%      The order of appearing boundary conditions are lower
%      x and upper x in rows 1 and 2 of the matrix BC,
%      respectively. The first column of BC determines the
%      type of condition:
%         1 for Dirichlet condition, followed by the set
%         value of U in the second column.
%         2 for Neumann condition, followed by the set value
%         of U' in the second column.
%         3 for Robbins condition, followed by the constant
%         and the coefficient of U in the second and third
%         column, respectively.
%
%   [X,T,U]=PARABOLIC1D(NX,NT,DX,DT,ALPHA,U0,BC,F,P1,P2,...) solves
%   the nonhomogeneous parabolic equation where F(U,X,T) is a
%   constant or linear function with respect to U, described in
%   the M-file F.M. The extra parameters P1, P2, ... are passed
%   directly to the function F(U,X,T,P1,P2,...).
%
%   See also PARABOLIC2D, PARABOLIC

% (c) N. Mostoufi & A. Constantinides
% January 1, 1999

% Initialization
if nargin < 7
   error(' Invalid number of inputs.')
end

nx = fix(nx);
x = [0:nx]*dx;
nt = fix(nt);
t = [0:nt]*dt;
r = alpha*dt/dx^2;

u0 = (u0(:).')';	% Make sure it's a column vector
if length(u0) ~= nx+1
   error(' Length of the vector of initial condition is not correct.')
end

[a,b]=size(bc);
if a ~= 2
   error(' Invalid number of boundary conditions.')
end
if b < 2 | b > 3
   error(' Invalid boundary condition.')
end
if b == 2 & max(bc(:,1)) <= 2
   bc = [bc zeros(2,1)];
end

u(:,1) = u0;
c = zeros(nx+1,1);
% Iteration on t
for n = 2:nt+1
   
   % Lower x boundary condition
   switch bc(1,1)
   case 1
      A(1,1) = 1;
      c(1) = bc(1,2);
   case {2, 3}
      A(1,1) = -3/(2*dx) - bc(1,3);
      A(1,2) = 2/dx;
      A(1,3) = -1/(2*dx);
      c(1) = bc(1,2);
   end
   
   % Internal points
   for i = 2:nx
      A(i,i-1) = -r;
      A(i,i) = 2*(1+r);
      A(i,i+1) = -r;
      c(i) = r*u(i-1,n-1) + 2*(1-r)*u(i,n-1) + r*u(i+1,n-1);
      if nargin >= 8	% Nonhomogeneous equation
         intercept = feval(func,0,x(i),t(n),varargin{:});
         slope = feval(func,1,x(i),t(n),varargin{:}) - intercept;
         A(i,i) = A(i,i) - dt*slope;
         c(i) = c(i) + dt*feval(func,u(i,n-1),x(i),t(n-1),...
            varargin{:}) + dt*intercept;
      end
   end
   
   % Upper x boundary condition
   switch bc(2,1)
   case 1
      A(nx+1,nx+1) = 1;
      c(nx+1) = bc(2,2);
   case {2, 3}
      A(nx+1,nx+1) = 3/(2*dx) - bc(2,3);
      A(nx+1,nx) = -2/dx;
      A(nx+1,nx-1) = 1/(2*dx);
      c(nx+1) = bc(2,2);
   end
   
   u(:,n) = inv(A)*c;	% Solving the set of equations
end 