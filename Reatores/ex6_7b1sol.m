clear
clc

Ch0 = 0.021;
Cm0 = 0.0105;
Cx0 = 0;
k1 = 55.2;
k2 = 30.2;
tau = 1;

syms Ch Cm Cx
eq1 = Ch0 - Ch - (k1*Ch^(1/2)*Cm + k2*Ch^(1/2)*Cx)*tau;
eq2 = Cm0 - Cm - k1*Ch^(1/2)*Cm*tau;
eq3 = Cx0 - Cx + (k1*Ch^(1/2)*Cm - k2*Ch^(1/2)*Cx)*tau;

[solCh,solCm,solCx] = solve(eq1,eq2,eq3);

Ch = double(solCh)
Cm = double(solCm)
Cx = double(solCx)