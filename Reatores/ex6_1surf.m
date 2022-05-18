clear
clc

nCa = 50;
nT = 100;
Ca = linspace(0,1,nCa);
T = linspace(300,400,nT);

for i = 1:nCa
    for j = 1:nT
        rd = (0.0012*exp(36000*(1/300-1/T(j))))*Ca(i);
        ru = (0.0018*exp(25000*(1/300-1/T(j))))*Ca(i)^1.5;
        rq = (0.00452*exp(5000*(1/300-1/T(j))))*Ca(i)^0.5;
        Sd_uq(i,j) = rd/(ru+rq);
    end
end

figure
surf(T,Ca,Sd_uq,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
xlabel('T');
ylabel('C_A');
zlabel('S_D_/_U_Q');

figure
surf(Ca,T,Sd_uq','FaceColor','interp','EdgeColor','none','FaceLighting','phong')
ylabel('T');
xlabel('C_A');
zlabel('S_D_/_U_Q');
