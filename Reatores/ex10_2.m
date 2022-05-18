clear
clc

rt = [41.6e-10
      19.7e-10
      42.0e-10
      17.1e-10
      71.8e-10
      142.0e-10
      284.0e-10
      47.0e-10
      71.3e-10
      117.0e-10
      127.0e-10
      131.0e-10
      133.0e-10
      41.8e-10];

Pt = [1
      1
      1
      1
      1
      1
      1
      0.5
      1
      5
      10
      15
      20
      1];
 
Ph2 = [1
       1
       1
       1
       1
       2
       4
       1
       1
       1
       1
       1
       1
       1];
 
Pb = [1
      4
      1
      5
      0
      0
      0
      0
      0
      0
      0
      0
      0
      1];

ds = dataset(Pt,Ph2,Pb,rt);
modelfun = @(k,P)k(1)*P(:,1).*P(:,2)./(1+k(2)*P(:,3)+k(3)*P(:,1));
beta0 = [1 1 1];
mdl = NonLinearModel.fit(ds,modelfun,beta0)