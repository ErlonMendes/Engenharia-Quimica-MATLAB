clear
clc

t = 1000;
L = 100;
alpha = 1;
u0 = 25;
ul = 100;
ur = 0;

nx = 200;
deltax = L/nx;
deltat = 1/2*deltax^2/alpha;
nt = fix(t/deltat);

% Solution of differential equation
rx = alpha*deltat/deltax^2;
u(1:nx,1:nt) = u0;
u(1,1:nt) = ul;
u(nx,1:nt) = ur;
for n = 1:nt-1
    for i = 2:nx-1
        u(i,n+1) = rx*(u(i+1,n) + u(i-1,n)) + (1-2*rx)*u(i,n);
    end
end

t = linspace(0,t,nt);
x = linspace(0,L,nx);

figure
s = surf(t,x,u,'FaceColor','interp','EdgeColor','none','FaceLighting','phong');
colorbar

figure
plot(x,u(:,1:nt/10:nt));
