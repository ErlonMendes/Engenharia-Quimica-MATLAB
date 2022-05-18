clear
clc
 
nx = 200;
nt = 200;
x = linspace(0,5,nx);
t = linspace(0,100,nt);
 
m = 0;
sol = pdepe(m,@cont_groundwater_pde,@cont_groundwater_ic,@cont_groundwater_bc,x,t);
 
C = sol(:,:,1);
 
figure
plot(x,C(1:fix(nt/10):nt,:))
xlabel('Distance x(m)')
ylabel('Contaminant Concentration, C(mg/L)')
legend([num2str(t(1)) ' dias'],[num2str(t(1+fix(nt/10)),3) ' dias'],[num2str(t(1+2*fix(nt/10)),3) ' dias'],[num2str(t(1+3*fix(nt/10)),3) ' dias'],[num2str(t(1+4*fix(nt/10)),3) ' dias'],[num2str(t(1+5*fix(nt/10)),3) ' dias'],[num2str(t(1+6*fix(nt/10)),3) ' dias'],[num2str(t(1+7*fix(nt/10)),3) ' dias'],[num2str(t(1+8*fix(nt/10)),3) ' dias'],[num2str(t(1+9*fix(nt/10)),3) ' dias'])
 
figure
surf(x,t,C,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
xlabel('Distance x(m)')
ylabel('Time t(d)')
zlabel('Contaminant Concentration, C(mg/L)')
colormap('jet')