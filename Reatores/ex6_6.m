function [ dCdtau ] = ex6_6( tau,C )
%EX6_6 Solução do exemplo 6.6 (Fogler, 1999)
% CH = C(1)
% CM = C(2)
% CX = C(3)
% CT = C(4)
% CMe = C(5)
% dCH/dtau = dCdtau(1,:)
% dCM/dtau = dCdtau(2,:)
% dCX/dtau = dCdtau(3,:)
% dCT/dtau = dCdtau(4,:)
% dCMe/dtau = dCdtau(5,:)

% Velocidades específicas de reação:
k1 = 55.20; % (ft^3/lbmol)^0.5/h
k2 = 30.20; % (ft^3/lbmol)^0.5/h

% Sistema de EDOs:
% dCH/dtau = -k1*CM*CH^0.5 - k2*CX*CH^0.5;
% dCM/dtau = -k1*CM*CH^0.5;
% dCX/dtau = k1*CM*CH^0.5 - k2*CX*CH^0.5;
% dCT/dtau = k2*CX*CH^0.5;
% dCMe/dtau = k1*CM*CH^0.5 + k2*CX*CH^0.5;

dCdtau(1,:) = -k1*C(2)*C(1)^0.5 - k2*C(3)*C(1)^0.5;
dCdtau(2,:) = -k1*C(2)*C(1)^0.5;
dCdtau(3,:) = k1*C(2)*C(1)^0.5 - k2*C(3)*C(1)^0.5;
dCdtau(4,:) = k2*C(3)*C(1)^0.5;
dCdtau(5,:) = k1*C(2)*C(1)^0.5 + k2*C(3)*C(1)^0.5;
end

