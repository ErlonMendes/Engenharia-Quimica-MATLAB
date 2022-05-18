clear
clc
close all

t = 100;
L = 1;
H = 1;
W = 1;

u = 0;
v = 1e-2;
w = 0;
Dx = 1e-3;
Dy = 1e-3;
Dz = 1e-3;

U0 = 0;
Ue = 100;

nx = 50;
ny = 50;
nz = 50;
deltax = L/nx;
deltay = H/ny;
deltaz = W/nz;

% Stability condition
deltat = 1/(u/deltax + v/deltay + w/deltaz + 2*Dx/deltax^2 + 2*Dy/deltay^2 + 2*Dz/deltaz^2);
nt = fix(t/deltat);

% Solution of differential equation
sigmax = u*deltat/deltax;
sigmay = v*deltat/deltay;
sigmaz = w*deltat/deltaz;
betax = Dx*deltat/deltax^2;
betay = Dy*deltat/deltay^2;
betaz = Dz*deltat/deltaz^2;

U(1:nx,1:ny,1:nz) = U0;
Ux(1:nx,1) = U0;
Uy(1:ny,1) = U0;
Uz(1:nz,1) = U0;

x = linspace(0,L,nx);
y = linspace(0,H,ny);
z = linspace(0,W,nz);
[y,x,z] = meshgrid(y,x,z);
sx = [0.5*L L];
sy = [H];
sz = [0 0.5*W];

wb = waitbar(0,'Please wait...','WindowStyle','modal');
frames = java.awt.Frame.getFrames();
frames(end).setAlwaysOnTop(1);

writerObj1 = VideoWriter('advdisp3D.avi');
open(writerObj1)

fig=figure;
for n = 1:nt-1
    U(1,1:ny,1:nz) = (4*U(2,1:ny,1:nz)-U(3,1:ny,1:nz))/3; % Neumann
    
    U(nx,1:ny,1:nz) = (4*U(nx-1,1:ny,1:nz)-U(nx-2,1:ny,1:nz))/3; % Neumann
        
    U(1:nx,1,1:nz) = (4*U(1:nx,2,1:nz)-U(1:nx,3,1:nz))/3; % Neumann
        
    U(1:nx,ny,1:nz) = (4*U(1:nx,ny-1,1:nz)-U(1:nx,ny-2,1:nz))/3; % Neumann
        
    U(1:nx,1:ny,1) = (4*U(1:nx,1:ny,2)-U(1:nx,1:ny,3))/3; % Neumann
        
    U(1:nx,1:ny,nz) = (4*U(1:nx,1:ny,nz-1)-U(1:nx,1:ny,nz-2))/3; % Neumann
        
    % Corners
    U(1,1,1) = (U(2,1,1) + U(1,2,1) + U(1,1,2))/3;
    U(nx,ny,nz) = (U(nx-1,ny,nz) + U(nx,ny-1,nz) + U(nx,ny,nz-1))/3;
    U(1,ny,nz) = (U(2,ny,nz) + U(1,ny-1,nz) + U(1,ny,nz-1))/3;
    U(nx,1,nz) = (U(nx,2,nz) + U(nx-1,1,nz) + U(nx,1,nz-1))/3;
    U(nx,ny,1) = (U(nx,ny,2) + U(nx-1,ny,1) + U(nx,ny-1,1))/3;
    U(nx,1,1) = (U(nx-1,1,1) + U(nx,2,1) + U(nx,1,2))/3;
    U(1,ny,1) = (U(1,ny-1,1) + U(2,ny,1) + U(1,ny,2))/3;
    U(1,1,nz) = (U(1,1,nz-1) + U(2,1,nz) + U(1,2,nz))/3;
    
    % Fonte de emissão
    U(fix(nx/2),fix(ny/2),fix(nz/2)) = Ue; % Dirichlet
    
    Uf = U;
    
    Ux(1:nx,n) = U(1:nx,fix(ny/2),fix(nz/2));
    Uy(1:ny,n) = U(fix(nx/2),1:ny,fix(nz/2));
    Uz(1:nz,n) = U(fix(nx/2),fix(ny/2),1:nz);
    for i = 2:nx-1
        for j = 2:ny-1
            for k = 2:nz-1
                Uf(i,j,k) = -sigmax*(U(i,j,k)-U(i-1,j,k)) - sigmay*(U(i,j,k)-U(i,j-1,k)) - sigmaz*(U(i,j,k)-U(i,j,k-1)) + betax*(U(i+1,j,k)-2*U(i,j,k)+U(i-1,j,k)) + betay*(U(i,j+1,k)-2*U(i,j,k)+U(i,j-1,k)) + betaz*(U(i,j,k+1)-2*U(i,j,k)+U(i,j,k-1)) + U(i,j,k);
            end
        end
    end
    U = Uf;
    
    % Fonte de emissão
    U(fix(nx/2),fix(ny/2),fix(nz/2)) = Ue; % Dirichlet
    
    slice(y,x,z,Uf,sy,sx,sz);
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
plot(x,Ux(:,1:step:nt))
subplot(2,2,3)
plot(y,Uy(:,1:step:nt))
subplot(2,2,4)
plot(z,Uz(:,1:step:nt))
