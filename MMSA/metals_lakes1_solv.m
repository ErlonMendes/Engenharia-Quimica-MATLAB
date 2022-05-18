clear
clc

x = [];
KdM = linspace(0.001,100,100000);

for i=1:4
kstau = 1000/10^(i);
[ R ] = metals_lakes1( KdM, kstau );
x = [x; R];
end

figure
semilogx(KdM,x');xlabel('Kd*M');ylabel('R');legend('ks*tau=100','ks*tau=10','ks*tau=1','ks*tau=0.1');
