clear
clc
close all

V = linspace(1e-3,8e-3);
P1 = 10e5;
V1 = 1e-3;
gama = 1.67;
k = P1*(V1^gama);
Pad = k./(V.^gama);
Pib = Pad(end)*ones(1,100);
Pit = P1*V1./V;
Viv = V1*ones(1,100);

figure
hold on
plot(V,Pad,'r');
plot(V,Pib,'g');
plot(V,Pit,'m');
plot(Viv,Pad,'b');
hold off
xlabel('V(m^3)');
ylabel('P(Pa)');
legend('Processo Adiabático','Processo Isobárico','Processo Isotérmico','Processo Isovolumétrico');
axis([0 10e-3 0 11e5]);