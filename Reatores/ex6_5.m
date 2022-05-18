function [dFdV] = ex6_5(V,F)
%EX6_5 Fogler
% F(1) = Fno
% F(2) = Fnh3
% F(3) = Fh2o
% F(4) = Fn2
% F(5) = Fo2
% F(6) = Fno2
% dFdV(1,:) = dFno/dV
% dFdV(2,:) = dFnh3/dV
% dFdV(3,:) = dFh2o/dV
% dFdV(4,:) = dFn2/dV
% dFdV(5,:) = dFo2/dV
% dFdV(6,:) = dFno2/dV

T0 = 300; % K
P0 = 5; % atm
R = 0.082; % dm^3*atm/(mol*K)

Ct0 = P0/(R*T0);
Ft = F(1)+F(2)+F(3)+F(4)+F(5)+F(6);

% Parâmetros:
k1no = 0.43; % (dm^3/mol)^1.5/s
k2n2 = 2.7; % dm^3/(mol*s)
k3o2 = 0.25; % (dm^3/mol)^2/s

% Sistema de EDOs:
% dFno/dV = -k1no*Ct0^2.5*(Fnh3/Ft)*(Fno/Ft)^1.5 - 2*k2n2*Ct0^2*(Fno/Ft)^2;
% dFnh3/dV = -2/3*k1no*Ct0^2.5*(Fnh3/Ft)*(Fno/Ft)^1.5;
% dFh2o/dV = k1no*Ct0^2.5*(Fnh3/Ft)*(Fno/Ft)^1.5;
% dFn2/dV = 5/6*k1no*Ct0^2.5*(Fnh3/Ft)*(Fno/Ft)^1.5 + k2n2*Ct0^2*(Fno/Ft)^2 - 1/2*k3o2*Ct0^3*(Fn2/Ft)*(Fo2/Ft)^2;
% dFo2/dV = k2n2*Ct0^2*(Fno/Ft)^2 - k3o2*Ct0^3*(Fn2/Ft)*(Fo2/Ft)^2;
% dFno2/dV = k3o2*Ct0^3*(Fn2/Ft)*(Fo2/Ft)^2;

dFdV(1,:) = -k1no*Ct0^2.5*(F(2)/Ft)*(F(1)/Ft)^1.5 - 2*k2n2*Ct0^2*(F(1)/Ft)^2;
dFdV(2,:) = -2/3*k1no*Ct0^2.5*(F(2)/Ft)*(F(1)/Ft)^1.5;
dFdV(3,:) = k1no*Ct0^2.5*(F(2)/Ft)*(F(1)/Ft)^1.5;
dFdV(4,:) = 5/6*k1no*Ct0^2.5*(F(2)/Ft)*(F(1)/Ft)^1.5 + k2n2*Ct0^2*(F(1)/Ft)^2 - 1/2*k3o2*Ct0^3*(F(4)/Ft)*(F(5)/Ft)^2;
dFdV(5,:) = k2n2*Ct0^2*(F(1)/Ft)^2 - k3o2*Ct0^3*(F(4)/Ft)*(F(5)/Ft)^2;
dFdV(6,:) = k3o2*Ct0^3*(F(4)/Ft)*(F(5)/Ft)^2;
end

