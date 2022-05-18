function dxdW=ex10_3b(W,x)
% "ex10_3"
% m-file to solve example 10.3
%
% x(1)=X
% x(2)=y
% dxdW(1,:)=dX/dW
% dxdW(2,:)=dy/dW
global eps PT0
Ft0=50;
eps = 0;
k=.00087;
KT=1.038;
KB=1.39;
alpha=0.000098;
P0=40;
PT0=0.3*P0;

PH2=PT0*(1.5-x(1))/(1+eps*x(1))*x(2);
PB=PT0*x(1)/(1+eps*x(1))*x(2);
PT=PT0*(1-x(1))/(1+eps*x(1))*x(2);
rt=-k*PT*PH2/(1+KB*PB+KT*PT);

dxdW(1,:)=-rt/Ft0;
dxdW(2,:)=-alpha*(1+eps*x(1))/(2*(x(2)));
end