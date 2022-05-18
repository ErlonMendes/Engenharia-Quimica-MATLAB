function sensitivity(model,pcs)
% ____Sensitivity analysis____
Gt = full(model.S);
selExchange = findExcRxns(model,true,false);
p = find(selExchange~=0);
pa = find(p==pcs);
p(pa) = [];

% External rates
Gtm = Gt(:,p);

% Internal rates
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

C = norm(Gt)*norm(pinv(Gt));
sens = -pinv(Gtc)*Gtm;

% Accumulated sensitivities
accum = sum(abs(sens));

figure
bar(p,accum,'g');xlabel('Exchange reaction number');ylabel('Accumulated sensitivities');

% Specific sensitivities
pcs = find(q==pcs);
spec = abs(sens(pcs,:));

figure
bar(p,spec,'m');xlabel('Exchange reaction number');ylabel('Specific sensitivities');
