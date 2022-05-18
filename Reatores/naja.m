function [ dfdt ] = naja( t,f )
%NAJA Modela a farmococinética de picada de naja
% fsv = f(1)
% fsa = f(2)
% fs  = f(3)
% Cv  = f(4)
% Ca  = f(5)
% Cp  = f(6)
% dfsv/dt = dfdt(1,:)
% dfsa/dt = dfdt(2,:)
% dfs/dt  = dfdt(3,:)
% dCv/dt  = dfdt(4,:)
% dCa/dt  = dfdt(5,:)
% dCp/dt  = dfdt(6,:)

% Velocidades específicas de reação
kv = 2e8; % dm^3/mol*hr
ksv = 6e8; % dm^3/mol*hr
ka = 2e8; % dm^3/mol*hr
kia = 1; % hr^(-1)
kiv = 1e-3; % hr^(-1)
ksa = 6e8; % dm^3/mol*hr
kp = 1.2e9; % dm^3/mol*hr
kov = 0.3; % hr^-1
koa = 0.3; % hr^-1
kop = 0.3; % hr^-1

% Concentração inicial de sítios receptores, utilizada tornar as dimensões
% coerentes com o termo transiente
Cs0 = 5e-9;

% Sistema de equações diferenciais ordinárias
% dfsv/dt = kv*fs*Cv - kiv*fsv - ksv*fsv*Ca
% dfsa/dt = ka*fs*Ca - kia*fsa - ksa*fsa*Cv
% dfs/dt = -kv*fs*Cv - ka*fs*Ca + kiv*fsv + kia*fsa + ksa*fsa*Cv + ksv*fsv*Ca
% dCv/dt = Cs0*(-kv*fs*Cv+kiv*fsv-ksa*fsa*Cv) - kp*Cv*Ca - kov*Cv
% dCa/dt = Cs0*(-ka*fs*Ca+kia*fsa-ksv*fsv*Ca) - kp*Cv*Ca - koa*Ca
% dCp/dt = Cs0*(ksv*fsv*Ca+ksa*fsa*Cv) + kp*Cv*Ca - kop*Cp

dfdt(1,:) = kv*f(3)*f(4) - kiv*f(1) - ksv*f(1)*f(5);
dfdt(2,:) = ka*f(3)*f(5) - kia*f(2) - ksa*f(2)*f(4);
dfdt(3,:) = -kv*f(3)*f(4) - ka*f(3)*f(5) + kiv*f(1) + kia*f(2) + ksa*f(2)*f(4) + ksv*f(1)*f(5);
dfdt(4,:) = Cs0*(-kv*f(3)*f(4)+kiv*f(1)-ksa*f(2)*f(4)) - kp*f(4)*f(5) - kov*f(4);
dfdt(5,:) = Cs0*(-ka*f(3)*f(5)+kia*f(2)-ksv*f(1)*f(5)) - kp*f(4)*f(5) - koa*f(5);
dfdt(6,:) = Cs0*(ksv*f(1)*f(5)+ksa*f(2)*f(4)) + kp*f(4)*f(5) - kop*f(6);
end

