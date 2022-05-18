function [dydt] = cap4ex1ode(t,y)
global alfa beta
dydt(1,:) = alfa*(1-y(2))*y(1);
dydt(2,:) = -beta*(1-y(1))*y(2);
end

