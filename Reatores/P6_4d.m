function [ dFdV ] = P6_4d( V,F )
%P6_4D2 Resolve o problema 6-4 (Fogler, 1999)
% F(1) = Fa
% F(2) = Fb
% F(3) = Fc
% F(4) = Fd
% F(5) = Fe
% dFdV(1,:) = dFa/dV
% dFdV(2,:) = dFb/dV
% dFdV(3,:) = dFc/dV
% dFdV(4,:) = dFd/dV
% dFdV(5,:) = dFe/dV

k1 = 10;
k2 = 0.03;
Ft = F(1)+F(2)+F(3)+F(4)+F(5);
Ct0 = 5/(0.73*900);
Ca = Ct0*(F(1)/Ft);

dFdV(1,:) = -k1*Ca;
dFdV(2,:) = k1*Ca;
dFdV(3,:) = -k2;
dFdV(4,:) = k2;
dFdV(5,:) = k2;
end

