clear
clc

x = linspace(0,9e5);
t = linspace(0,20);

m = 0;
sol = pdepe(m,@org_chem_rivers_pde,@org_chem_rivers_ic,@org_chem_rivers_bc,x,t);

Ct = sol(:,:,1);
r = sol(:,:,2);

figure
surf(x,t,Ct,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
xlabel('Distance x(m)')
ylabel('Time t(d)')
zlabel('Total Chemical Concentration, Ct(ug/L)')

figure
surf(x,t,r,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
xlabel('Distance x(m)')
ylabel('Time t(d)')
zlabel('Adsorbed Chemical on Sediment Solids, r(ug/kg)')