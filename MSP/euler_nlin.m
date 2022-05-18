% Euler Explícito
clear
clc

a = 0.8;
xe(1) = 4;
tf = 5;
nt = 11;
deltat = tf/(nt-1);

for k = 1:nt-1
    xe(k+1) = xe(k) - deltat*a*sqrt(xe(k));
end

% Euler Implícito
xi(1) = 4;
syms y
for k = 1:nt-1
    b = deltat*a;
    c = xi(k);
    err = 1;
    yi = c;
    gy = y + b*sqrt(y) - c;
    gly = diff(gy,1);
    while err>=1e-10
        yip1 = yi - subs(gy,yi)/subs(gly,yi);
        err = abs(yip1 - yi);
        yi = yip1;
    end
    xi(k+1) = yip1;
end

% Solução Analítica
t = linspace(0,tf,nt);
xa = (sqrt(xe(1))-a*t/2).^2;
figure
plot(t,xe,t,xi,t,xa)
xlabel('t')
ylabel('x')
legend('Euler Explícito','Euler Implícito','Solução Analítica')


