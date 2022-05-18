clear
clc

% Crescimento em glicose
ci = [0.39,19.8,0,0];
tspan = [0 40];
[t1,x1] = ode45('pesquisa1',tspan,ci);

exp1 = [  0 0.39 19.80 0.00  0.007
         12 0.78 17.00 0.00  0.036
         24 2.38  6.40 0.40  0.068
         36 2.36  0.62 0.68  0.310
         48 2.25     0 2.76 0.567];

figure
hold on
plot(exp1(:,1),exp1(:,2),'LineStyle','none','Marker','x','MarkerEdgeColor','b');
plot(exp1(:,1),exp1(:,3),'LineStyle','none','Marker','x','MarkerEdgeColor','g');
plot(exp1(:,1),exp1(:,4),'LineStyle','none','Marker','x','MarkerEdgeColor','r');
plot(exp1(:,1),exp1(:,5),'LineStyle','none','Marker','x','MarkerEdgeColor','c');
plot(t1,x1);title('Crescimento em glicose');xlabel('t(h)');ylabel('X,S,P_1,P_2(g/L)');legend('Biomassa_e_x_p','Glicose_e_x_p','EtOH_e_x_p','Pigmento_e_x_p','Biomassa','Glicose','EtOH','Pigmento');
hold off

% Crescimento em etanol
ci = [2.25,2.76,0.567];
tspan = [48 140];
[t2,x2] = ode45('pesquisa2',tspan,ci);

exp2 = [ 48 2.25 2.76 0.567
         72 2.38 1.01 1.158
         94 2.44 0.49 2.740
        125 2.02 0.30 2.440
        141 1.87 0.00 2.344];

figure
hold on
plot(exp2(:,1),exp2(:,2),'LineStyle','none','Marker','x','MarkerEdgeColor','b');
plot(exp2(:,1),exp2(:,3),'LineStyle','none','Marker','x','MarkerEdgeColor','g');
plot(exp2(:,1),exp2(:,4),'LineStyle','none','Marker','x','MarkerEdgeColor','r');
plot(t2,x2);title('Crescimento em etanol');xlabel('t(h)');ylabel('X,S,P(g/L)');legend('Biomassa_e_x_p','EtOH_e_x_p','Pigmento_e_x_p','Biomassa','EtOH','Pigmento');
hold off

% Crescimento em amido
ci = [0.154,3,0.042,4.61];
tspan = [0 120];
[t1,x1] = ode45('pesquisa3',tspan,ci);

exp1 = [  0 0.154 3.00 0.042  4.61
         36 0.299 2.30 0.265  4.36
         48 1.560 1.60 1.808  6.02
         72 2.750 0.90 3.603  7.05
         96 5.240 0.20 4.980  35.22
        120 4.36  0.00 4.740  35.22];

figure
hold on
plot(exp1(:,1),exp1(:,2),'LineStyle','none','Marker','x','MarkerEdgeColor','b');
plot(exp1(:,1),exp1(:,3),'LineStyle','none','Marker','x','MarkerEdgeColor','g');
plot(exp1(:,1),exp1(:,4),'LineStyle','none','Marker','x','MarkerEdgeColor','r');
plot(exp1(:,1),exp1(:,5),'LineStyle','none','Marker','x','MarkerEdgeColor','c');
plot(t1,x1);title('Crescimento em amido');xlabel('t(h)');ylabel('X,S,P_1,P_2(g/L)');legend('Biomassa_e_x_p','Amido_e_x_p','Pigmento_e_x_p','Amilase_e_x_p','Biomassa','Amido','Pigmento','Amilase');
hold off