function [pl,ql,pr,qr] = cond_cc(xl,Tl,xr,Tr,t)
%COND_CC Possui as condi��es de contorno para a resolu��o do modelo de condu��o pura em uma barra de a�o
% Os �ndices l e r significam left e right, isto �, esquerda e direita da barra.

pl = Tl-100; % Em x = 0, T = 100�C (CC do tipo Dirichlet)

ql = 0; % N�o h� CC do tipo Neumann em x = 0

pr = Tr-0; % Em x = L, T = 0�C (CC do tipo Dirichlet)

qr = 0; % N�o h� CC do tipo Neumann em x = L
end