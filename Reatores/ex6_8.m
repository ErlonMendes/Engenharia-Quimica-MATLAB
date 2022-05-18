function [ dFdV ] = ex6_8( V,F )
%EX6_8 Summary of this function goes here
% Fa = F(1)
% Fb = F(2)
% Fc = F(3)
% Fd = F(4)
% Fe = F(5)
% Ff = F(6)
% dFa/dV = dFdV(1,:)
% dFb/dV = dFdV(2,:)
% dFc/dV = dFdV(3,:)
% dFd/dV = dFdV(4,:)
% dFe/dV = dFdV(5,:)
% dFf/dV = dFdV(6,:)
Ct0 = 2;
k1a = 5;
k2a = 2;
k3b = 10;
k4c = 5;
Ft = F(1)+F(2)+F(3)+F(4)+F(5)+F(6);
Ca = Ct0*F(1)/Ft;
Cb = Ct0*F(2)/Ft;
Cc = Ct0*F(3)/Ft;

dFdV(1,:) = -k1a*Ca*Cb^2 - k2a*Ca*Cb - 2/3*k4c*Cc*Ca^(2/3);
dFdV(2,:) = -5/4*k1a*Ca*Cb^2 - 3/4*k2a*Ca*Cb - k3b*(Cc^2)*Cb;
dFdV(3,:) = k1a*Ca*Cb^2 - 2*k3b*(Cc^2)*Cb - k4c*Cc*Ca^(2/3);
dFdV(4,:) = 3/2*k1a*Ca*Cb^2 + 3/2*k2a*Ca*Cb + k4c*Cc*Ca^(2/3);
dFdV(5,:) = 1/2*k2a*Ca*Cb + 5/6*k4c*Cc*Ca^(2/3);
dFdV(6,:) = 2*k3b*(Cc^2)*Cb;
end

