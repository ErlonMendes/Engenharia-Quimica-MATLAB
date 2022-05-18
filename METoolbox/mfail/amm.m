% AMM.M (Part of ME Toolbox)
% Version: 1.0
%
% Description: Makes the atomic mapping matrix.
%   mn = AMM(m,n) Makes the atomic mapping matrix.
%
% Authors: Erlon Mendes & Luismar Porto
% Date: March 11, 2006
%
% Local Parameters:
%   input:
%       m = carbon configuration of reactant.
%       n = carbon configuration of product.
%
%   output:
%       mn = atomic mapping matrix.
%   
% Ref.: Stephanopoulos, G., Aristidou, A. A. and Nielsen, J. (1998). Metabolic
% Engineering : principles and methodologies. Academic Press. San Diego.
%
% The toolbox is distributed under the GNU General Public Licence 
% (Free Software Foundation 1991; http://www.gnu.org)


function mn = AMM(m,n)

for i=1:length(m)
    for j=1:length(n)
        mn(i,j) = strcmp(m(i),n(j));
    end
end
mn = mn';