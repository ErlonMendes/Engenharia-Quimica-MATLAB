clear
clc
close all

t = 2e4;
L = 1;
H = 1;
h = 1000;
k = 13.4;
ro = 7971.89;
Cp = 502.416;
alpha = k/(ro*Cp);
u0 = 25;
ul = 0;
ur = 100;
ud = 50;
uu = 30;
uinf = 15;

nx = 100;
deltax = L/nx;
deltay = deltax;
ny = fix(H/deltay);
deltat = 1/(2*alpha/deltax^2 + 2*alpha/deltay^2);
nt = fix(t/deltat);

wb = waitbar(0,'Please wait...','WindowStyle','modal');
frames = java.awt.Frame.getFrames();
frames(end).setAlwaysOnTop(1);

% Solution of differential equation
rx = alpha*deltat/(deltax^2);
ry = alpha*deltat/(deltay^2);
u(1:nx,1:ny,1:nt) = u0;
for n = 1:nt-1   
    u(1,1:ny,n) = ul; % Dirichlet
    % u(1,1:ny,nn) = (4*u(2,1:ny,n)-u(3,1:ny,n))/3; % Neumann
    % u(1,1:ny,n) = (4*u(2,1:ny,n)-u(3,1:ny,n)+2*h/k*deltax*uinf)/(3+2*h/k*deltax); % Robbins
    
    u(nx,1:ny,n) = ur; % Dirichlet
    % u(nx,1:ny,n) = (4*u(nx-1,1:ny,n)-u(nx-2,1:ny,n))/3; % Neumann
    % u(nx,1:ny,n) = (4*u(nx-1,1:ny,n)-u(nx-2,1:ny,n)+2*h/k*deltax*uinf)/(3+2*h/k*deltax); % Robbins
    
    u(1:nx,1,n) = ud; % Dirichlet
    % u(1:nx,1,n) = (4*u(1:nx,2,n)-u(1:nx,3,n))/3; % Neumann
    % u(1:nx,1,n) = (4*u(1:nx,2,n)-u(1:nx,3,n)+2*h/k*deltay*uinf)/(3+2*h/k*deltay); % Robbins
    
    u(1:nx,ny,n) = uu; % Dirichlet
    % u(1:nx,ny,n) = (4*u(1:nx,ny-1,n)-u(1:nx,ny-2,n))/3; % Neumann
    % u(1:nx,ny,n) = (4*u(1:nx,ny-1,n)-u(1:nx,ny-2,n)+2*h/k*deltay*uinf)/(3+2*h/k*deltay); % Robbins
    
    % Corners
    u(1,1,n) = (u(1,2,n) + u(2,1,n))/2;
    u(nx,ny,n) = (u(nx,ny-1,n) + u(nx-1,ny,n))/2;
    u(nx,1,n) = (u(nx,2,n) + u(nx-1,1,n))/2;
    u(1,ny,n) = (u(2,ny,n) + u(1,ny-1,n))/2;
    for i = 2:nx-1
        for j = 2:ny-1
            u(i,j,n+1) = rx*(u(i+1,j,n) + u(i-1,j,n)) + ry*(u(i,j+1,n) + u(i,j-1,n)) + (1-2*rx-2*ry)*u(i,j,n);
        end
    end
    waitbar(n/nt)
end
close(wb)

x = linspace(0,L,nx);
y = linspace(0,H,ny);
t = linspace(0,t,nt);

figure
subplot(2,2,1)
surf(y,x,u(:,:,fix(nt/10)),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
subplot(2,2,2)
surf(y,x,u(:,:,fix(nt/4)),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
subplot(2,2,3)
surf(y,x,u(:,:,fix(nt/2)),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
subplot(2,2,4)
surf(y,x,u(:,:,nt-1),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')

step = fix(nt/10);
for n = 1:nt
    for i = 1:nx
        ux(i,n) = u(i,fix(ny/2),n);
    end
    for j = 1:ny
        uy(j,n) = u(fix(nx/2),j,n);
    end
end

figure
subplot(2,1,1)
plot(x,ux(:,1:step:nt))
subplot(2,1,2)
plot(y,uy(:,1:step:nt))

writerObj1 = VideoWriter('cond2Dexp.avi');
open(writerObj1);
fig=figure;
step = fix(nt/50);
for n = 1:step:nt
    surf(y,x,u(:,:,n),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
    colorbar

    frame1 = getframe(fig);
    writeVideo(writerObj1,frame1);
end
close(writerObj1)
