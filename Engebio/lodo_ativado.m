clear
clc

syms Qs Qr X mix;
mim = 0.1;
Ks = 0.25;
Yxs = 0.5;
kd = 0.001;

Q = 0.25;
Se = 10;
S = 0.1;
Xs = 0.15;
Xr = 0.001;
V = 13;
eq1 = Qr*Xr - (Q+Qr)*X + mix*X*V - kd*X*V;
eq2 = Q*Se + Qr*S - (Q+Qr)*S - mix/Yxs*X*V;
eq3 = (Q+Qr)*X - Qs*Xs - Qr*Xr - (Q-Qs)*Xr;
eq4 = mim*(S/(Ks+S)) - mix;
[Qs,Qr,X,mix] = solve(eq1,eq2,eq3,eq4)
