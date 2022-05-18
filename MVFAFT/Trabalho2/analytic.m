function [ T ] = analytic( x,t,alfa,L,T0 )
T = T0*exp(-alfa*(pi/L)^2*t)*sin(pi/L*x);
end