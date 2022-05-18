clear
clc

t = 1e3;
L = 4e-1;
H = 4e-1;
W = 4e-1;
h = 20;
k = 13.4;
ro = 7971.89;
Cp = 502.416;
alpha = k/(ro*Cp);
u0 = 25;
ul = 100;
ur = 100;
ud = 100;
uu = 100;
uin = 100;
uout = 100;
uinf = 0;

nx = 50;
deltax = L/nx;
deltay = deltax;
ny = fix(H/deltay);
deltaz = deltax;
nz = fix(W/deltay);
deltat = 1/(2*alpha/deltax^2 + 2*alpha/deltay^2 + 2*alpha/deltaz^2);
nt = fix(t/deltat);

% Solution of differential equation
rx = alpha*deltat/(deltax^2);
ry = alpha*deltat/(deltay^2);
rz = alpha*deltat/(deltaz^2);
u(1:nx,1:ny,1:nz) = u0;
ux(1:nx,1) = u0;
uy(1:ny,1) = u0;
uz(1:nz,1) = u0;

x = linspace(0,L,nx);
y = linspace(0,H,ny);
z = linspace(0,W,nz);
[y,x,z] = meshgrid(y,x,z);
sx = [0.5*L L];
sy = [0.5*H H];
sz = [0 0.5*W];

wb = waitbar(0,'Please wait...','WindowStyle','modal');
frames = java.awt.Frame.getFrames();
frames(end).setAlwaysOnTop(1);

writerObj1 = VideoWriter('cond3Dexp.avi');
open(writerObj1)

fig=figure;
for n = 1:nt-1
    % u(1,1:ny,1:nz) = ul; % Dirichlet
    % u(1,1:ny,1:nz) = (4*u(2,1:ny,1:nz)-u(3,1:ny,1:nz))/3; % Neumann
    u(1,1:ny,1:nz) = (4*u(2,1:ny,1:nz)-u(3,1:ny,1:nz)+2*h/k*deltax*uinf)/(3+2*h/k*deltax); % Robbins
    
    % u(nx,1:ny,1:nz) = ur; % Dirichlet
    % u(nx,1:ny,1:nz) = (4*u(nx-1,1:ny,1:nz)-u(nx-2,1:ny,1:nz))/3; % Neumann
    u(nx,1:ny,1:nz) = (4*u(nx-1,1:ny,1:nz)-u(nx-2,1:ny,1:nz)+2*h/k*deltax*uinf)/(3+2*h/k*deltax); % Robbins
    
    % u(1:nx,1,1:nz) = ud; % Dirichlet
    % u(1:nx,1,1:nz) = (4*u(1:nx,2,1:nz)-u(1:nx,3,1:nz))/3; % Neumann
    u(1:nx,1,1:nz) = (4*u(1:nx,2,1:nz)-u(1:nx,3,1:nz)+2*h/k*deltay*uinf)/(3+2*h/k*deltay); % Robbins
    
    % u(1:nx,ny,1:nz) = uu; % Dirichlet
    % u(1:nx,ny,1:nz) = (4*u(1:nx,ny-1,1:nz)-u(1:nx,ny-2,1:nz))/3; % Neumann
    u(1:nx,ny,1:nz) = (4*u(1:nx,ny-1,1:nz)-u(1:nx,ny-2,1:nz)+2*h/k*deltay*uinf)/(3+2*h/k*deltay); % Robbins
    
    % u(1:nx,1:ny,1) = uin; % Dirichlet
    % u(1:nx,1:ny,1) = (4*u(1:nx,1:ny,2)-u(1:nx,1:ny,3))/3; % Neumann
    u(1:nx,1:ny,1) = (4*u(1:nx,1:ny,2)-u(1:nx,1:ny,3)+2*h/k*deltaz*uinf)/(3+2*h/k*deltaz); % Robbins
    
    % u(1:nx,1:ny,nz) = uout; % Dirichlet
    % u(1:nx,1:ny,nz) = (4*u(1:nx,1:ny,nz-1)-u(1:nx,1:ny,nz-2))/3; % Neumann
    u(1:nx,1:ny,nz) = (4*u(1:nx,1:ny,nz-1)-u(1:nx,1:ny,nz-2)+2*h/k*deltaz*uinf)/(3+2*h/k*deltaz); % Robbins
    
    % Corners
    u(1,1,1) = (u(2,1,1) + u(1,2,1) + u(1,1,2))/3;
    u(nx,ny,nz) = (u(nx-1,ny,nz) + u(nx,ny-1,nz) + u(nx,ny,nz-1))/3;
    u(1,ny,nz) = (u(2,ny,nz) + u(1,ny-1,nz) + u(1,ny,nz-1))/3;
    u(nx,1,nz) = (u(nx,2,nz) + u(nx-1,1,nz) + u(nx,1,nz-1))/3;
    u(nx,ny,1) = (u(nx,ny,2) + u(nx-1,ny,1) + u(nx,ny-1,1))/3;
    u(nx,1,1) = (u(nx-1,1,1) + u(nx,2,1) + u(nx,1,2))/3;
    u(1,ny,1) = (u(1,ny-1,1) + u(2,ny,1) + u(1,ny,2))/3;
    u(1,1,nz) = (u(1,1,nz-1) + u(2,1,nz) + u(1,2,nz))/3;
    
    uf = u;
    ux(1:nx,n) = u(1:nx,fix(ny/2),fix(nz/2));
    uy(1:ny,n) = u(fix(nx/2),1:ny,fix(nz/2));
    uz(1:nz,n) = u(fix(nx/2),fix(ny/2),1:nz);
    for i = 2:nx-1
        for j = 2:ny-1
            for k = 2:nz-1
                uf(i,j,k) = rx*(u(i+1,j,k) + u(i-1,j,k)) + ry*(u(i,j+1,k) + u(i,j-1,k)) + rz*(u(i,j,k+1) + u(i,j,k-1)) + (1-2*rx-2*ry-2*rz)*u(i,j,k);
            end
        end
    end
    u = uf;
    slice(y,x,z,uf,sy,sx,sz);
    lightangle(-45,30)
    shading interp
    set(gcf,'Renderer','zbuffer')
    set(findobj(gca,'type','surface'),'FaceLighting','phong','AmbientStrength',.3,'DiffuseStrength',.8,'SpecularStrength',.9,'SpecularExponent',25,'BackFaceLighting','unlit')
    colorbar
    
    frame1 = getframe(fig);
    writeVideo(writerObj1,frame1);
    
    waitbar(n/nt)
end
close(wb)
close(writerObj1)


x = linspace(0,L,nx);
y = linspace(0,H,ny);
z = linspace(0,W,nz);
t = linspace(0,t,nt);
step = fix(nt/10);

figure
subplot(2,2,1:2)
plot(x,ux(:,1:step:nt))
subplot(2,2,3)
plot(y,uy(:,1:step:nt))
subplot(2,2,4)
plot(z,uz(:,1:step:nt))
