% Describes the phenomenon of dissolved oxygen decreasing with upstream and
% downstream distance due to degradation of soluble organic biochemical
% oxygen demand (BOD) in large rivers.

clear % Clear Workspace
clc % Clear Command Window

global E u ka kd kr kn L0 N0 D0
% Inlet BOD concentration:
L0 = 4; % mg*L^(-1)
N0 = 6; % mg*L^(-1)

% Rate Constants and Mean velocity:
u = 5; % mi*d^(-1)
E = 15; % mi^2*d^(-1)
ka = 2; % d^(-1)
kd = 0.6; % d^(-1)
kr = 1; % (kd + ks) - d^(-1)
kn = 0.3; % d^(-1)

i = 1;
delta = 1e2;
delta_a = 1e3;
D = linspace(0,L0/2,1e2);
while delta_a > delta
    D0 = D(i);
    delta_a = delta;
    
    xa = linspace(-40,0);
    yinita = [0 0 0 0 0 0];
    solinit = bvpinit(xa,yinita);
    sol = bvp4c(@dolrmod_ode,@dolrmod_bc1,solinit);
    ya = deval(sol,xa);
    
    xb = linspace(0,160);
    yinitb = [0 0 0 0 0 0];
    solinit = bvpinit(xb,yinitb);
    sol = bvp4c(@dolrmod_ode,@dolrmod_bc2,solinit);
    yb = deval(sol,xb);
    
    delta = abs(yb(6,1)-ya(6,end));
    i = i + 1;
end
D0

figure
hold on
plot(xa,ya(1,:),xa,ya(3,:),xa,ya(5,:));
plot(xb,yb(1,:),xb,yb(3,:),xb,yb(5,:));
xlabel('x (mi)');ylabel('L,N,D (mg/L)');legend('L','N','D');
hold off

figure
hold on
plot(xa,kr*ya(1,:),xa,kn*ya(3,:),xa,ka*ya(5,:));
plot(xb,kr*yb(1,:),xb,kn*yb(3,:),xb,ka*yb(5,:));
xlabel('x (mi)');ylabel('Rxn Rates (mg/L*d)');legend('kr*L','kn*N','ka*D');
hold off

figure
hold on
plot(xa,u*ya(1,:),xa,u*ya(3,:),xa,u*ya(5,:));
plot(xb,u*yb(1,:),xb,u*yb(3,:),xb,u*yb(5,:));
xlabel('x (mi)');ylabel('Adv. Fluxes (mg*mi/L*d)');legend('u*L','u*N','u*D');
hold off

figure
hold on
plot(xa,-E*ya(2,:),xa,-E*ya(4,:),xa,-E*ya(6,:));
plot(xb,-E*yb(2,:),xb,-E*yb(4,:),xb,-E*yb(6,:));
plot([xb(1,1),xb(1,1)],[-E*ya(2,end),-E*yb(2,1)],[xb(1,1),xb(1,1)],[-E*ya(4,end),-E*yb(4,1)]);
xlabel('x (mi)');ylabel('Dispersive Fluxes (mg*mi/L*d)');legend('-E*dL/dx','-E*dN/dx','-E*dD/dx');
hold off