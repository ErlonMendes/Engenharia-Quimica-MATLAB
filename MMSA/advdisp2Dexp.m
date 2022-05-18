clear
clc
close all

t = 2e3;
L = 10;
H = 10;

u = 0;
v = 1e-3;
alpha = 1e-3;

U0 = 0;
Ue = 100;

nx = 100;
ny = 100;
deltax = L/nx;
deltay = H/ny;

% Stability condition
% deltat = deltax/u;
% deltat = deltay/v;
deltat = 1/10*(deltax^2+deltay^2)/alpha;
nt = fix(t/deltat);

wb = waitbar(0,'Please wait...','WindowStyle','modal');
frames = java.awt.Frame.getFrames();
frames(end).setAlwaysOnTop(1);

% Solution of differential equation
sigmax = u*deltat/deltax;
sigmay = v*deltat/deltay;
betax = alpha*deltat/deltax^2;
betay = alpha*deltat/deltay^2;

U(1:nx,1:ny,1:nt) = U0;
for n = 1:nt-1
    U(1,1:ny,n) = (4*U(2,1:ny,n)-U(3,1:ny,n))/3; % Neumann
    
    U(nx,1:ny,n) = (4*U(nx-1,1:ny,n)-U(nx-2,1:ny,n))/3; % Neumann
    
    U(1:nx,1,n) = (4*U(1:nx,2,n)-U(1:nx,3,n))/3; % Neumann
    
    U(1:nx,ny,n) = (4*U(1:nx,ny-1,n)-U(1:nx,ny-2,n))/3; % Neumann
    
    % Corners
    U(1,1,n) = (U(1,2,n) + U(2,1,n))/2;
    U(nx,ny,n) = (U(nx,ny-1,n) + U(nx-1,ny,n))/2;
    U(nx,1,n) = (U(nx,2,n) + U(nx-1,1,n))/2;
    U(1,ny,n) = (U(2,ny,n) + U(1,ny-1,n))/2;
    
    % Fonte de emissão
    U(fix(nx/2),fix(ny/2),n) = Ue; % Dirichlet
    for i = 2:nx-1
        for j = 2:ny-1
            U(i,j,n+1) = -sigmax*(U(i,j,n)-U(i-1,j,n)) - sigmay*(U(i,j,n)-U(i,j-1,n)) + betax*(U(i+1,j,n)-2*U(i,j,n)+U(i-1,j,n)) + betay*(U(i,j+1,n)-2*U(i,j,n)+U(i,j-1,n)) + U(i,j,n);
        end
    end
    % Fonte de emissão
    U(fix(nx/2),fix(ny/2),n) = Ue; % Dirichlet
    
    waitbar(n/nt)
end
close(wb)

x = linspace(0,L,nx);
y = linspace(0,H,ny);
t = linspace(0,t,nt);

figure
subplot(2,2,1)
surf(y,x,U(:,:,fix(nt/10)),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
subplot(2,2,2)
surf(y,x,U(:,:,fix(nt/4)),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
subplot(2,2,3)
surf(y,x,U(:,:,fix(nt/2)),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
subplot(2,2,4)
surf(y,x,U(:,:,nt),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')

step = fix(nt/10);
for n = 1:nt
    for i = 1:nx
        Ux(i,n) = U(i,fix(ny/2),n);
    end
    for j = 1:ny
        Uy(j,n) = U(fix(nx/2),j,n);
    end
end

figure
subplot(2,1,1)
plot(x,Ux(:,1:step:nt))
subplot(2,1,2)
plot(y,Uy(:,1:step:nt))

writerObj1 = VideoWriter('advdisp2D.avi');
open(writerObj1);
fig=figure;
step = fix(nt/50);
for n = 1:step:nt
    surf(y,x,U(:,:,n),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
    colorbar

    frame1 = getframe(fig);
    writeVideo(writerObj1,frame1);
end
close(writerObj1)
