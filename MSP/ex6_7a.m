clear
clc
warning('off','all');

tic

Ch0 = 0.021;
Cm0 = 0.0105;
Cx0 = 0;
Chv(1) = Ch0;
Cmv(1) = Cm0;
Cxv(1) = Cx0;

k1 = 55.2;
k2 = 30.2;

nt = 100;
tau = linspace(0,2,nt);

wb = waitbar(0,'Please wait...','WindowStyle','modal');
syms Ch Cm Cx
for i = 2:nt
    eq1 = Ch0 - Ch - (k1*Ch^(1/2)*Cm + k2*Ch^(1/2)*Cx)*tau(i);
    eq2 = Cm0 - Cm - k1*Ch^(1/2)*Cm*tau(i);
    eq3 = Cx0 - Cx + (k1*Ch^(1/2)*Cm - k2*Ch^(1/2)*Cx)*tau(i);

    [solCh,solCm,solCx] = vpasolve([eq1,eq2,eq3],[Ch,Cm,Cx],[0 inf;0 inf;0 inf]);

    Chv(i) = double(solCh);
    Cmv(i) = double(solCm);
    Cxv(i) = double(solCx);
    waitbar(i/nt)
end
close(wb)

figure
plot(tau,Chv,tau,Cmv,tau,Cxv)
xlabel('\tau (h)')
ylabel('C (lbmol/ft^3)')
legend('C_H','C_M','C_X')

toc
