function [G,Gmv,Ge] = CostFunctionAerationJacobian(X,U,e,data,uA)
%COSTFUNCTIONAERATION Summary of this function goes here
%   Detailed explanation goes here

p = data.PredictionHorizon;
ref = data.References(2);
Nx = data.NumOfStates;
U1 = U(1:p,data.MVIndex(1));
X2 = X(2:p+1,2);

G = zeros(p,Nx);

% State Jacobian
G(1:p,1) = 0;
G(1:p,2) = -2*1e4*(ref - X2);

Nmv = length(data.MVIndex);

% Input Jacobian
Gmv = zeros(p,Nmv);
Gmv(1:p,1) = 2*1e7*uA;

Ge = 0;

end

