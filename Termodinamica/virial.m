clear
clc

R = 8.205e-2;
T = [273 600];
B = [ -21.7  11.9
     -149.7 -12.4
      -10.5  21.7
     -153.7 -19.6]/1000;
 
Vm = linspace(0.1,0.6);

for i=1:2
    for j=1:4
        p(j,:) = R*T(i)./Vm.*(1+(B(j,i)./Vm));
    end
    figure
    plot(Vm,p);xlabel('Vm(dm^3*mol^-^1)');ylabel('p(atm)');legend('Ar','CO_2','N_2','Xe');
end
