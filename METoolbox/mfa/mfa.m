% MFA.M (Part of ME Toolbox)
% Version: 1.0
%
% Description: Makes the metabolic flux analysis.
%   [vc,R,rk,vmnew,vcnew,h,e,answ,C,accum,spec] = MFA(G,vm,p,pcs) Makes the
%   metabolic flux analysis of determined and overdetermined systems.
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
%       pcs = relative position of the unmeasured flux of interest
%       for specific sensitivity analysis.
%
%   output:
%       vc = rates of unmeasured fluxes.
%       R = redundancy matrix.
%       rk = redundancy matrix's rank.
%       vmnew = new rates of measured fluxes, by statistical
%       reconciliation.
%       vcnew = new rates of unmeasured fluxes, by statistical
%       reconciliation.
%       h = test function X^2 distributed.
%       e = residual vector.
%       answ = answer if the solution is unique or not.
%       C = condition number.
%       accum = accumulated sensitivities vector.
%       spec = specific sensitivities vector, related to the
%       "pcs" flux.
%
%   
% Ref.: Stephanopoulos, G., Aristidou, A. A. and Nielsen, J. (1998). Metabolic
% Engineering : principles and methodologies. Academic Press. San Diego.
%
% The toolbox is distributed under the GNU General Public Licence 
% (Free Software Foundation 1991; http://www.gnu.org)


function [vc,R,rk,vmnew,vcnew,h,e,answ,C,accum,spec] = MFA(G,vm,p,pcs)

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
title('Measured and calculated rates')
vmp(p) = vm;
vmp(q) = 0;
vcp(q) = vc;
vcp(p) = 0;
hold on
bar(vmp,'r')
bar(vcp,'b')
hold off
ylabel('Rates of fluxes (mmol/h/g [dry wt])')
xlabel('Fluxes')
legend('Measured rates','Unmeasured rates',2)

% Statistical reconciliation of the measurements

% Redundancy matrix
R = (Gtm - Gtc*pinv(Gtc)*Gtm);
rk = rank(R, 1e-10);

% Reduced redundancy matrix
sg = size(G);
K = [ones(1,rk),zeros(1,sg(2)-rk)];
Rred = K*R;

% Rred = R(1:rk,:);

% Test
e = Rred*vm;
h = e'*inv(Rred*Rred')*e;

% New estimates for the measured rates
vmnew = (eye(length(p))-Rred'*inv(Rred*Rred')*Rred)*vm;

% New estimates for the unmeasured rates
vcnew = -pinv(Gtc)*Gtm*vmnew;

figure
title('New measured and calculated rates')
vmnewp(p) = vmnew;
vmnewp(q) = 0;
vcnewp(q) = vcnew;
vcnewp(p) = 0;
hold on
bar(vmnewp,'r')
bar(vcnewp,'b')
hold off
ylabel('Rates of fluxes (mmol/h/g [dry wt])')
xlabel('Fluxes')
legend('Measured rates','Unmeasured rates',2)

Nc = null(Gtc);
if rank(Nc)==0
    answ='This is an unique solution';
else
    answ='This isn´t an unique solution';
end

% Sensitivity analysis
C = norm(Gt)*norm(pinv(Gt));
sens = -pinv(Gtc)*Gtm;

accum = sum(abs(sens));

figure
hold on
title('Accumulated sensitivities')
bar(p,accum,'g')
hold off

pcs = find(q==pcs);
if isempty(pcs)
    error('The flux for sensitivity is not a unmeasured flux')
else
    spec = abs(sens(pcs,:));
    figure
    hold on
    title('Specific sensitivities')
    bar(p,spec,'m')
    hold off    
end