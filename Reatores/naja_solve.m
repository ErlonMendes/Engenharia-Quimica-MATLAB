clear
clc
close all
% Estudo da farmacocinética de picada de naja (Fogler, 1999)
% fsv = f(1)
% fsa = f(2)
% fs  = f(3)
% Cv  = f(4)
% Ca  = f(5)
% Cp  = f(6)

% Vítima recebe a picada, mas não recebe antiveneno
ci = [0,0,1,5e-9,0,0];
tspan = [0 0.5];
[t,f] = ode45('naja',tspan,ci);

figure
hold on
p = plot(t,f(:,3));title('Problema Naja sem antiveneno');xlabel('t(hr)');ylabel('Fração de sítios livres')
set(p,'Color',[1,0,0])
s = size(t);
p = plot(t,(2/3)*ones(s(1),1));
set(p,'Color',[1,0,1])
hold off

clear
clc
% Vítima recebe a picada e o antiveneno simultaneamente
ci = [0,0,1,5e-9,5e-9,0];
tspan = [0 2];
[t,f] = ode45('naja',tspan,ci);

figure
hold on
p = plot(t,f(:,3));title('Problema Naja com antiveneno');xlabel('t(hr)');ylabel('Fração de sítios livres')
set(p,'Color',[0,0,1])
s = size(t);
p = plot(t,(2/3)*ones(s(1),1));
set(p,'Color',[1,0,1])
hold off

clear
clc
% Vítima recebe a picada e vários tempos de espera para receber o antiveneno
tesp = [5,10,15,20,25,27.5]/60;

figure
ci = [0,0,1,5e-9,5e-9,0];
tspan = [0 2];
[t,f] = ode45('naja',tspan,ci);
hold on
p = plot(t,f(:,3));
set(p,'Color',[0,0,1])

for i=1:6
ci = [0,0,1,5e-9,0,0];
tspan = [0 tesp(i)];
[ta,fa] = ode45('naja',tspan,ci);

ci = fa(end,:);
ci(5) = 5e-9;
tspan = [tesp(i) 2];
[tb,fb] = ode45('naja',tspan,ci);

t = [ta;tb];
f = [fa;fb];
p = plot(t,f(:,3));
set(p,'Color',[0+i/6,0,1-i/6])
end
s = size(t);
p = plot(t,(2/3)*ones(s(1),1));
set(p,'Color',[1,0,1])
hold off
title('Injeções atrasadas de antiveneno');xlabel('t(hr)');ylabel('Fração de sítios livres');legend('0 min','5 min','10 min','15 min','20 min','25 min','27.5 min');

clear
clc
% Uma grande dosagem de antiveneno pode ser letal?
ci = [0,0,1,5e-9,10.25e-9,0];
tspan = [0 2];
[t,f] = ode45('naja',tspan,ci);

figure
hold on
p = plot(t,f(:,3));title('Uma grande dosagem de antiveneno pode ser letal?');xlabel('t(hr)');ylabel('Fração de sítios livres')
set(p,'Color',[0,0,1])
s = size(t);
p = plot(t,(2/3)*ones(s(1),1));
set(p,'Color',[1,0,1])
hold off

clear
clc
% Existe alguma forma de reverter os efeitos da superdosagem de antiveneno?
tesp = [5,10,15,20,25,30]/60;

figure
hold on
for i=1:6
ci = [0,0,1,5e-9,15e-9,0];
tspan = [0 tesp(i)];
[ta,fa] = ode45('naja',tspan,ci);

ci = fa(end,:);
ci(4) = ci(4)+10e-9;
tspan = [tesp(i) 2];
[tb,fb] = ode45('naja',tspan,ci);

t = [ta;tb];
f = [fa;fb];
p = plot(t,f(:,3));
set(p,'Color',[0+i/6,0,1-i/6])
end
s = size(t);
p = plot(t,(2/3)*ones(s(1),1));
set(p,'Color',[1,0,1])
hold off
title('Injeções de veneno para reverter superdosagem');xlabel('t(hr)');ylabel('Fração de sítios livres');legend('Injeção de veneno em 5 min','Injeção de veneno em 10 min','Injeção de veneno em 15 min','Injeção de veneno em 20 min','Injeção de veneno em 25 min','Injeção de veneno em 30 min');

clear
clc
% E se a vítima for picada duas vezes?
ci = [0,0,1,10e-9,8.84e-9,0];
tspan = [0 6];
[t,f] = ode45('naja',tspan,ci);

figure
hold on
p = plot(t,f(:,3));title('Vítima picada duas vezes');xlabel('t(hr)');ylabel('Fração de sítios livres')
set(p,'Color',[0,0,1])
s = size(t);
p = plot(t,(2/3)*ones(s(1),1));
set(p,'Color',[1,0,1])
hold off

clear
clc
% E se o antiveneno por injetano lentamente no período de 1 a 4 horas?
figure
hold on
for i = 1:4
    div = [4,8,16,48];

    ci = [0,0,1,5e-9,5e-9/div(i),0];
    tspan = [0 4/div(i)];
    [t,f] = ode45('naja',tspan,ci);

    for j = 4:4:3.5*div(i);
        ci = f(end,:);
        ci(5) = ci(5)+5e-9/div(i);
        tspan = [j/div(i) (j+4)/div(i)];
        [ti,fi] = ode45('naja',tspan,ci);
        t = [t;ti];
        f = [f;fi];
    end

    ci = f(end,:);
    ci(5) = ci(5)+5e-9/div(i);
    tspan = [(j+4)/div(i) 15];
    [ti,fi] = ode45('naja',tspan,ci);
    t = [t;ti];
    f = [f;fi];

    p = plot(t,f(:,3));
    set(p,'Color',[i/4,0,4/(4*i)])
end
title('Antiveneno injetado lentamente');xlabel('t(hr)');ylabel('Fração de sítios livres');legend('1 em 1 hora','30 em 30 minutos','15 em 15 minutos','5 em 5 minutos');
s = size(t);
p = plot(t,(2/3)*ones(s(1),1));
set(p,'Color',[1,0,1])
hold off

clear
clc
% E se, depois de receber o tratamento apropriado, a vítima é picada novamente?
tesp = [10,20,30,40,50,60]/60;

figure
hold on
for i=1:6
ci = [0,0,1,5e-9,5e-9,0];
tspan = [0 tesp(i)];
[ta,fa] = ode45('naja',tspan,ci);

ci = fa(end,:);
ci(4) = ci(4)+5e-9;
ci(5) = ci(5)+5e-9;
tspan = [tesp(i) 2];
[tb,fb] = ode45('naja',tspan,ci);

t = [ta;tb];
f = [fa;fb];
p = plot(t,f(:,3));
set(p,'Color',[0+i/6,0,1-i/6])
end
s = size(t);
p = plot(t,(2/3)*ones(s(1),1));
set(p,'Color',[1,0,1])
hold off
title('Vítima é picada novamente após o tratamento');xlabel('t(hr)');ylabel('Fração de sítios livres');legend('10 min','20 min','30 min','40 min','50 min','60 min');

clear
clc
% Veneno injetano no músculo
figure
hold on
for i = 1:4
    div = [4,8,16,48];

    ci = [0,0,1,5e-9/div(i),5e-9,0];
    tspan = [0 4/div(i)];
    [t,f] = ode45('naja',tspan,ci);

    for j = 4:4:3.5*div(i);
        ci = f(end,:);
        ci(4) = ci(4)+5e-9/div(i);
        tspan = [j/div(i) (j+4)/div(i)];
        [ti,fi] = ode45('naja',tspan,ci);
        t = [t;ti];
        f = [f;fi];
    end

    ci = f(end,:);
    ci(4) = ci(4)+5e-9/div(i);
    tspan = [(j+4)/div(i) 15];
    [ti,fi] = ode45('naja',tspan,ci);
    t = [t;ti];
    f = [f;fi];

    p = plot(t,f(:,3));
    set(p,'Color',[4/(4*i),0,i/4])
end
title('Veneno injetado no músculo');xlabel('t(hr)');ylabel('Fração de sítios livres');legend('1 em 1 hora','30 em 30 minutos','15 em 15 minutos','5 em 5 minutos');
s = size(t);
p = plot(t,(2/3)*ones(s(1),1));
set(p,'Color',[1,0,1])
hold off
