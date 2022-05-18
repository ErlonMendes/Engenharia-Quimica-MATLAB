%T = T1 + ((T2-T1)/L)*x + SOMATÓRIO an*exp((-a*n^2*pi^2*t)/L^2)*sin(n*pi*x/L);
clc

T0 = 25;
T1 = 100;
T2 = 0;
L = 100;
nt = 500;
nx = 500;
ns = 2000;
t = linspace(0,1000,nt); 
x = linspace(0,100,nx); 
alfa = 1;

for n = 1:2:ns
    a(n) = (2/(n*pi))*(2*T0-T1-T2);
end
for n = 2:2:ns
    a(n) = (2/(n*pi))*(T2-T1); 
end
for i = 1:nt
    for j = 1:nx
        S=0;
        for n = 1:ns;
            S = S + a(n)*exp(-alfa*n^2*pi^2*t(i)/L^2)*sin(n*pi*x(j)/L);
        end 
        T(i,j) = T1 + ((T2-T1)/L)*x(j) + S;
    end
end
figure
surf(x,t,T,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
colorbar
xlabel('Distância x')
ylabel('Tempo t')
zlabel('Temperatura(°C)');
