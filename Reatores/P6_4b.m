clear
clc
% P6-4 a
T = linspace(273,2000);
sdu(:,1) = 800*exp(-2000./T)./(10*exp(-300./T));
figure
plot(T,sdu(:,1));xlabel('T(K)');ylabel('S_D_U');

% P6-4 b
T = linspace(273,2000);
sdu(:,2) = 800*exp(-2000./T)./(10*exp(-300./T)+1000*exp(-8000./T));
figure
plot(T,sdu(:,2));xlabel('T(K)');ylabel('S_D_U');

% P6-4 b (da resolução proposta)
T = linspace(273,2000);
sdu(:,3) = 800*exp(-2000./T)./(1000*exp(-8000./T));
figure
plot(T,sdu(:,3));xlabel('T(K)');ylabel('S_D_U');

sdu(:,4) = 0.8*exp(6000./T);
figure
plot(T,sdu(:,4));xlabel('T(K)');ylabel('S_D_U');