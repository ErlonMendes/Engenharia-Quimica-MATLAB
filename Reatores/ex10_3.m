% "ex10_3"
% m-file to solve example 10.3
%
% x(1)=X
% xdot(1)=d(X)/dw

function xdot=ex10_3(w,x)

global PT0 alpha

Ft0=50;
k=.00087;
KT=1.038;
KB=1.39;
alpha=0.000098;
P0=40;
PT0=0.3*P0;
y=(1-alpha*w)^0.5;
P=y*P0;
PH2=PT0*(1.5-x(1))*y;
PB=PT0*x(1)*y;
PT=PT0*(1-x(1))*y;
rt=-k*PT*PH2/(1+KB*PB+KT*PT);

xdot(1,:)=-rt/Ft0;
end