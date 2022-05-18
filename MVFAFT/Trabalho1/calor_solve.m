clear
clc
ii=50;
jj=50;
y = linspace(0,15*10^-2,ii);
ub = linspace(0,20,jj);
for i=1:ii
    for j=1:jj
        q(i,j) = calor(y(i),ub(j));
    end
end
figure
surf(ub,y,q,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
colorbar
title('Fluxo de calor, q(J/m^2*s)')
xlabel('Velocidade média ub(m/s)')
ylabel('Altura y(m)')