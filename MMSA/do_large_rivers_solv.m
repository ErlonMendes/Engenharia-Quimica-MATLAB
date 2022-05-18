% Describes the phenomenon of dissolved oxygen decreasing with upstream and
% downstream distance due to degradation of soluble organic biochemical
% oxygen demand (BOD) in large rivers.

clear % Clear Workspace
clc % Clear Command Window
close all

global E kd u ka L0 D0
% Inlet BOD concentration:
L0 = 14.16; % mg*L^(-1)

% Rate Constants and Mean velocity:
u = 3.57; % mi*d^(-1)
%u = 0; % mi*d^(-1)
%u = 10; % mi*d^(-1)
E = 15; % mi^2*d^(-1)
kd = 0.15; % d^(-1)
ka = 0.18; % d^(-1)

i = 1;
delta = 1e2;
delta_a = 1e3;
D = linspace(0,L0/2,1e2);
while delta_a > delta
    D0 = D(i);
    delta_a = delta;
    
    x1 = linspace(-40,0);
    yinit = [0 0 0 0];
    solinit = bvpinit(x1,yinit);
    sol = bvp4c(@do_large_rivers_ode,@do_large_rivers_bc1,solinit);
    y1 = deval(sol,x1);
    
    x2 = linspace(0,200);
    yinit = [0 0 0 0];
    solinit = bvpinit(x2,yinit);
    sol = bvp4c(@do_large_rivers_ode,@do_large_rivers_bc2,solinit);
    y2 = deval(sol,x2);
    
    delta = abs(y2(4,1)-y1(4,end));
    i = i + 1;
end
D0

figure
hold on
plot(x1,y1(1,:),x1,y1(3,:));
plot(x2,y2(1,:),x2,y2(3,:));
hold off
xlabel('x (mi)');ylabel('L,D (mg/L)');legend('L','D');

figure
hold on
plot(x1,kd*y1(1,:),x1,ka*y1(3,:));
plot(x2,kd*y2(1,:),x2,ka*y2(3,:));
xlabel('x (mi)');ylabel('Rxn Rates (mg/L*d)');legend('kd*L','ka*D');
hold off

figure
hold on
plot(x1,u*y1(1,:),x1,u*y1(3,:));
plot(x2,u*y2(1,:),x2,u*y2(3,:));
xlabel('x (mi)');ylabel('Adv. Fluxes (mg*mi/L*d)');legend('u*L','u*D');
hold off

figure
hold on
plot(x1,-E*y1(2,:),x1,-E*y1(4,:));
plot(x2,-E*y2(2,:),x2,-E*y2(4,:));
plot([x1(end,end),x2(1,1)],[-E*y1(2,end),-E*y2(2,1)]);
xlabel('x (mi)');ylabel('Dispersive Fluxes (mg*mi/L*d)');legend('-E*dL/dx','-E*dD/dx');
hold off