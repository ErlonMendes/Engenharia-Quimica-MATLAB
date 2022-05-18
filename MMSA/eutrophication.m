function [ dCdt ] = eutrophication( t,C )
% EUTROPHICATION Dynamic simulation program that solves the set of ordinary
% differential equations for eutrophication of lakes


% Set of State Variables:

% C(1)=Si mg*L^(-1)
% C(2)=P mg*L^(-1)
% C(3)=N1 mg*L^(-1)
% C(4)=N2 mg*L^(-1)
% C(5)=B mg*L^(-1)
% C(6)=D mg*L^(-1)
% C(7)=Z mg*L^(-1)
% C(8)=F1 mg*L^(-1)
% C(9)=F2 mg*L^(-1)
% dCdt(1,:)=dSi/dt
% dCdt(2,:)=dP/dt
% dCdt(3,:)=dN1/dt
% dCdt(4,:)=dN2/dt
% dCdt(5,:)=dB/dt
% dCdt(6,:)=dD/dt
% dCdt(7,:)=dZ/dt
% dCdt(8,:)=dF1/dt
% dCdt(9,:)=dF2/dt


% Rate Constants and Stoichiometric Coefficients for Dynamic Ecosystem
% Models:

k0 = 0.1; % d^(-1)
fn = 0.3; % d^(-1)
fp = 0.3; % d^(-1)
fsi = 0.4; % d^(-1)
Vsachl = 0.1; % m*d^(-1)
ksH = 0.1; % m*d^(-1)
Vs = 0.2; % m*d^(-1)
ks = 0.1; % m*d^(-1)
H = 2.5; % m
an = 0.05;
ap = 0.01;
asi = 0.1;
e = 0.1; % d^(-1)
umax = 1.5; % d^(-1)
Kp = 0.01; % mg*L^(-1)
Kn1 = 0.01; % mg*L^(-1)
Kn2 = 0.015; % mg*L^(-1)
Ksi = 0.075; % mg*L^(-1)
g1 = 0.4; % L*mg^(-1)*d^(-1)
g2 = 0.4; % L*mg^(-1)*d^(-1)
g3 = 0.4; % L*mg^(-1)*d^(-1)
g4 = 0.4; % L*mg^(-1)*d^(-1)
g5 = 0.4; % L*mg^(-1)*d^(-1)
d = 0.07; % d^(-1)
tetab = 1;
teta0 = 1;
tetan = 1;
tetae = 1;
tetag = 1;
tetaf1 = 1;
tetaf2 = 1;
tetad = 1;
tetaz = 1;
kd1 = 0.05; % d^(-1)
kd2 = 0.05; % d^(-1)
h = 0.05; % d^(-1)
I = 1;
Is = 1;
Wsi = 0.0036; % mg*d^(-1)
Wp = 0.0036; % mg*d^(-1)
Wn1 = 0.0036; % mg*d^(-1)
Wn2 = 0.0036; % mg*d^(-1)
Vi = 5000; % L
kn = 0.05; % d^(-1)


% Set of Differential Equations:

% Nt = N1 + N2

% u = umax*((I/Is)*exp(-(I/Is)+1))*tetab*(Si/(Ksi+Si))*(P/(Kp+P))*(Nt/(Kn1+Nt))

% dSi/dt = -u*B*asi + Wsi(t)/Vi + k0*teta0*D*fsi
% dP/dt = -u*B*ap + Wp(t)/Vi + k0*teta0*D*fp
% dN1/dt = -u*B*an*(N1/Nt) + Wn1(t)/Vi + k0*teta0*D*fn - kn*tetan*N1
% dN2/dt = -u*B*an*(N2/Nt) + Wn2(t)/Vi + kn*tetan*N1
% dB/dt = u*B - e*B*tetae - g1*B*Z*tetag - g2*B*F1*tetaf1 - Vs(T)*B/H
% dD/dt = e*B*tetae + d*Z*tetad - k0*teta0*D - ks(T)*D
% dZ/dt = g1*B*Z*tetaz - d*Z*tetaz - g3*Z*F1*tetaf1 - g4*Z*F2*tetaf2
% dF1/dt = g2*B*F1*tetaf1 + g3*Z*F1*tetaf1 - kd1*F1 - g5*F1*F2*tetaf2
% dF2/dt = g4*Z*F2*tetaf2 + g5*F1*F2*tetaf2 - kd2*F2 - h*F2

Nt = C(3) + C(4);

u = umax*((I/Is)*exp(-(I/Is)+1))*tetab*(C(1)/(Ksi+C(1)))*(C(2)/(Kp+C(2)))*(Nt/(Kn1+Nt));

dCdt(1,:) = -u*C(5)*asi + Wsi/Vi + k0*teta0*C(6)*fsi;
dCdt(2,:) = -u*C(5)*ap + Wp/Vi + k0*teta0*C(6)*fp;
dCdt(3,:) = -u*C(5)*an*(C(3)/Nt) + Wn1/Vi + k0*teta0*C(6)*fn - kn*tetan*C(3);
dCdt(4,:) = -u*C(5)*an*(C(4)/Nt) + Wn2/Vi + kn*tetan*C(3);
dCdt(5,:) = u*C(5) - e*C(5)*tetae - g1*C(5)*C(7)*tetag - g2*C(5)*C(8)*tetaf1 - Vs*C(5)/H;
dCdt(6,:) = e*C(5)*tetae + d*C(7)*tetad - k0*teta0*C(6) - ks*C(6);
dCdt(7,:) = g1*C(5)*C(7)*tetaz - d*C(7)*tetaz - g3*C(7)*C(8)*tetaf1 - g4*C(7)*C(9)*tetaf2;
dCdt(8,:) = g2*C(5)*C(8)*tetaf1 + g3*C(7)*C(8)*tetaf1 - kd1*C(8) - g5*C(8)*C(9)*tetaf2;
dCdt(9,:) = g4*C(7)*C(9)*tetaf2 + g5*C(8)*C(9)*tetaf2 - kd2*C(9) - h*C(9);
end