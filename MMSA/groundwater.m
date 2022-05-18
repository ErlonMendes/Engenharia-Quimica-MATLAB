function groundwater
clear
clc

x = linspace(0,5,200);
t = linspace(0,100,200);

m = 0;
sol = pdepe(m,@cont_groundwater_pde,@cont_groundwater_ic,@cont_groundwater_bc,x,t);

C = sol(:,:,1);

figure
surf(x,t,C,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
xlabel('Distance x(m)')
ylabel('Time t(d)')
zlabel('Contaminant Concentration, C(mg/L)')

function [ c,f,s ] = cont_groundwater_pde ( x,t,C,dCdx )
% CONT_GROUNDWATER_PDE Describes pouring of Contaminants in Groundwater

% Mass Balance Equation to Contaminant Concentration
% R*dC/dt = -ux*dC/dx + Dx*d2C/dx2 - k*C

R = 2;
ux = 0.02; % m*d^(-1)
alfa = 1;
Dab = 10^(-4); % m^2*d^(-1)
Dx = alfa*ux + Dab;
k = 0.03; % d^(-1)

c = R;
 
f = Dx*dCdx;
 
s = -ux*dCdx - k*C;
end

function [ C0 ] = cont_groundwater_ic( x )
% CONT_GROUNDWATER_IC is the function containing initial condition of the
% Groundwater Contaminants' model

C0 = 0;
end

function [pl,ql,pr,qr] = cont_groundwater_bc(xl,Cl,xr,Cr,t)
% CONT_GROUNDWATER_BC is the function containing boundary conditions of the
% Groundwater Contaminants' model

pl = Cl-1;

ql = 0;

pr = 0;

qr = 1;
end

end

