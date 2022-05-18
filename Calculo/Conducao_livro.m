
clear
clc
nt=100;
nx=50;
t = linspace(0,1.5,nt);
x = linspace(0,pi,nx);
for i = 1:nt
    for j = 1:nx
        s = 0;
        for n = 1:1000
            s = s + (1-(-1)^n)/n * exp(-n^2*t(i))*sin(n*x(j));
        end
       u(j,i) = 200/pi*s;
    end
end
figure
surf(t,x,u,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
xlabel('Tempo t')
ylabel('Distância x')
zlabel('Temperatura(°C)')