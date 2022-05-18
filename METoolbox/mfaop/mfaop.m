% MFAOP.M (Part of ME Toolbox)
% Version: 1.0
%
% Description: Makes the metabolic flux analysis.
%   [x,fval,exitflag,output,lambda,C] = MFAOP(f,SP,EF,G,pcs) Makes the
%   metabolic flux analysis of subdetermined systems.
%
% Authors: Erlon Mendes & Luismar Porto
% Date: March 11, 2006
%
% Local Parameters:
%   input:
%       f = objective function.
%       G = stoichiometric matrix.
%       lb = lower bounds vector.
%       ub = upper bounds vector.
%       p = position vector of exchange reactions.
%       pcs = relative position of the interest flux for specific
%       sensitivity analysis.
%
%   output:
%       x = metabolic flux vector.
%       fval = objective function value in "x".
%       exitflag =  describes the exit condition. > 0 when LINPROG
%       converged with a solution X. 0 when LINPROG reached the maximum
%       number of iterations without converging. < 0 when the problem was
%       infeasible or LINPROG failed.
%       output = interactions number.
%       lambda = set of Lagrangian multipliers.
%       C = conditional number.
%
%   
% Ref.: Stephanopoulos, G., Aristidou, A. A. and Nielsen, J. (1998). Metabolic
% Engineering : principles and methodologies. Academic Press. San Diego.
%
% The toolbox is distributed under the GNU General Public Licence 
% (Free Software Foundation 1991; http://www.gnu.org)


function [x,fval] = mfaop(f,G,lb,ub,p,pcs)

% ____Linear programming____
S = G';
sG = size(S);

% Equalities of the system
beq = zeros(sG(1),1);

% Optimization solve
f = -1*f;
[x,fval] = linprog(f,[],[],S,beq,lb,ub);

% Flux display
figure
hold on
bar(x,'b')
ylabel('Rates of fluxes (mmol/h/g [dry wt])')
xlabel('Fluxes')
hold off

% ____Sensitivity analysis____
pa = find(p==pcs);
p(pa) = [];

% External rates
Sm = S(:,p);

% Internal rates
sgt = size(S);
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

Sc = S(:,q);

C = norm(S)*norm(pinv(S));
sens = -pinv(Sc)*Sm;

% Accumulated sensitivities
accum = sum(abs(sens));

figure
bar(p,accum,'g');title('Accumulated sensitivities');

% Specific sensitivities
pcs = find(q==pcs);
spec = abs(sens(pcs,:));

figure
bar(p,spec,'m');title('Specific sensitivities');
