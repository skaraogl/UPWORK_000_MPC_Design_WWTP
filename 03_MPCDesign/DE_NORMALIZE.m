function [NOR,DNOR] = DE_NORMALIZE(X,C,S)
%DE_NORMALIZE Summary of this function goes here
%   Detailed explanation goes here

%% NORMALIZATION
NOR = (X - C)/S;

%% DE-NORMALIZATION
DNOR = X * S + C;

end

