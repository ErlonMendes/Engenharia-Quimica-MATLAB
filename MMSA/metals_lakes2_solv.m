clear
clc

pH = linspace(5,8);
[ R,fp ] = metals_lakes2( pH );

figure
hold on
plot(pH,R,pH,fp);
xlabel('pH');ylabel('R, fp');legend('R','fp');
hold off
