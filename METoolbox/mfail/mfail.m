% MFAIL.M (Part of ME Toolbox)
% Version: 1.0
%
% Description: Makes the metabolic flux analysis by isotope labelling
% methods.
%   [vc,answ,xpyr,xicit,xakg,xsuc,xmal,xoaa] = MFAIL(G,vm,p) Makes the
%   metabolic flux analysis of determined and overdetermined systems by
%   isotope labelling methods.
%
% Authors: Erlon Mendes & Luismar Porto
% Date: March 11, 2006
%
% Local Parameters:
%   input:
%       G = stoichiometric matrix.
%       vm = rates of measured fluxes.
%       p = vector of relative positions of measured fluxes in the
%       stoichiometric matrix.
%
%   output:
%       vc = rates of unmeasured fluxes.
%       answ = answer if the solution is unique or not.
%       x = fractional labelling states.
%   
% Ref.: Stephanopoulos, G., Aristidou, A. A. and Nielsen, J. (1998). Metabolic
% Engineering : principles and methodologies. Academic Press. San Diego.
%
% The toolbox is distributed under the GNU General Public Licence 
% (Free Software Foundation 1991; http://www.gnu.org)


function [vc,answ,xpyr,xicit,xakg,xsuc,xmal,xoaa] = MFAIL(G,vm,p)

Gt = G';

% Measured rates
Gtm = Gt(:,p);

% Unmeasured rates
sgt = size(Gt);
j = 1;
i = 1;
for k=1:sgt(2)
    if j == length(p)+1
        for l=k:sgt(2)
            q(i) = l;
        end     
        break;
    end
    if k == p(j)
        j = j+1;
    else    
        q(i) = k;
        i = i+1;
    end
end

Gtc = Gt(:,q);
vc = -pinv(Gtc)*Gtm*vm;

figure
hold on
title('Measured and calculated rates')
bar(p,vm,'r')
bar(q,vc,'b')
ylabel('Rates of fluxes (mmol/h/g [dry wt])')
xlabel('Fluxes')
legend('Measured rates','Unmeasured rates',0)
hold off

Nc = null(Gtc);
if rank(Nc)==0
    answ='This is an unique solution';
else
    answ='This isn´t an unique solution';
end

% Atomic mapping matrices
pyr = ['A','B','C'];
icit = ['d','c','b','a','C','B'];
pyr_icit = amm(pyr,icit);

oaa = ['a','b','c','d'];
icit = ['d','c','b','a','C','B'];
oaa_icit = amm(oaa,icit);

icit = ['A','B','C','D','E','F'];
akg = ['A','B','C','E','F'];
icit_akg = amm(icit,akg);

akg = ['A','B','C','D','E'];
suc = ['B','C','D','E'];
akg_suc = amm(akg,suc);

suc = ['A','B','C','D'];
mal = ['A','B','C','D'];
suc_mal8 = amm(suc,mal);

suc = ['A','B','C','D'];
mal = ['D','C','B','A'];
suc_mal9 = amm(suc,mal);

mal = ['A','B','C','D'];
oaa = ['A','B','C','D'];
mal_oaa = amm(mal,oaa);

mal = ['A','B','C','D'];
pyr = ['A','B','C'];
mal_pyr = amm(mal,pyr);

% Merging vm and vc
for i=1:length(p)
    v(p(i)) = vm(i);
    for j=1:length(q)
        v(q(j)) = vc(j);
    end
end
v = v';

% Initial labelling state
xpyr_in = [0;0;1];
xakg_in = [0;0;0;0;0];

% Frational labelling state
%    Pyr                                          ICit                                          AKG                                          SUC                                          MAL                                          OAA           
A = [-sum(v(find(G(:,1)==-1)))*eye(length(pyr))   zeros(length(pyr),length(icit))               zeros(length(pyr),length(akg))               zeros(length(pyr),length(suc))               v(11)*mal_pyr                                zeros(length(pyr),length(oaa))];             % Pyr

A = [A; sum(v(find(G(:,2)==1)))*pyr_icit          -sum(v(find(G(:,2)==-1)))*eye(length(icit))   zeros(length(icit),length(akg))              zeros(length(icit),length(suc))              zeros(length(icit),length(mal))              v(4)*oaa_icit];                              % ICit

A = [A; zeros(length(akg),length(pyr))            v(5)*icit_akg                                 -sum(v(find(G(:,3)==-1)))*eye(length(akg))   zeros(length(akg),length(suc))               zeros(length(akg),length(mal))               zeros(length(akg),length(oaa))];             % AKG

A = [A; zeros(length(suc),length(pyr))            zeros(length(suc),length(icit))               sum(v(find(G(:,4)==1)))*akg_suc              -sum(v(find(G(:,4)==-1)))*eye(length(suc))   zeros(length(suc),length(mal))               zeros(length(suc),length(oaa))];             % SUC

A = [A; zeros(length(mal),length(pyr))            zeros(length(mal),length(icit))               zeros(length(mal),length(akg))               (v(8)*suc_mal8+v(9)*suc_mal9)                -sum(v(find(G(:,5)==-1)))*eye(length(mal))   zeros(length(mal),length(oaa))];             % MAL

A = [A; zeros(length(oaa),length(pyr))            zeros(length(oaa),length(icit))               zeros(length(oaa),length(akg))               zeros(length(oaa),length(suc))               sum(v(find(G(:,6)==1)))*mal_oaa              -sum(v(find(G(:,6)==-1)))*eye(length(oaa))]; % OAA

b = [-v(1)*xpyr_in
    zeros(length(icit),1)
    -v(6)*xakg_in
    zeros(length(suc),1)
    zeros(length(mal),1)
    zeros(length(oaa),1)];

x = A\b; % A*x = b

n(1) = length(pyr);
n(2) = n(1) + length(icit);
n(3) = n(2) + length(akg);
n(4) = n(3) + length(suc);
n(5) = n(4) + length(mal);
n(6) = n(5) + length(oaa);

xpyr = x(1:n(1));
figure
pie(xpyr*10);legend('C1','C2','C3',2);title('Fractional labelling state of Pyr')

xicit = x(n(1)+1:n(2));
figure
pie(xicit*10);legend('C1','C2','C3','C4','C5','C6',2);title('Fractional labelling state of Icit')

xakg = x(n(2)+1:n(3));
figure
pie(xakg*10);legend('C1','C2','C3','C4','C5',2);title('Fractional labelling state of AKG')

xsuc = x(n(3)+1:n(4));
figure
pie(xsuc*10);legend('C1','C2','C3','C4',2);title('Fractional labelling state of Suc')

xmal = x(n(4)+1:n(5));
figure
pie(xmal*10);legend('C1','C2','C3','C4',2);title('Fractional labelling state of Mal')

xoaa = x(n(5)+1:n(6));
figure
pie(xoaa*10);legend('C1','C2','C3','C4',2);title('Fractional labelling state of OAA')