function J = CostFunctionAeration(X,U,e,data,uA)
%COSTFUNCTIONAERATION Summary of this function goes here
%   Detailed explanation goes here

J = 1e7*uA*sum(U(1:end-1,data.MVIndex(1))) + 1e4*sum((data.References(2) - X(2:end,2)).^2);

end

