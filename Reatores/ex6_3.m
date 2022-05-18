function [ dCdtau ] = ex6_3( tau,C )
%EX6_7 Fogler
%   CA = C(1)
%   CB = C(2)
%   CC = C(3)
%   dCAdtau = dCdtau(1,:)
%   dCBdtau = dCdtau(2,:)
%   dCCdtau = dCdtau(3,:)
% Velocidades específicas:
k1 = 1; % s^-1
k2 = 0.5; % s^-1

% Equações:
% dCAdtau = -k1*CA;
% dCBdtau = k1*CA - k2*CB;
% dCCdtau = k2*CB;

dCdtau(1,:) = -k1*C(1);
dCdtau(2,:) = k1*C(1) - k2*C(2);
dCdtau(3,:) = k2*C(2);
end

