function [DataCol] = getSplittedDataComplex(Data,N)
%GETSPLITTEDDATACOMPLEX Summary of this function goes here
%   Detailed explanation goes here
% Number of rows
Num_Row = height(Data)/N;

ind1 = 0;
ind2 = Num_Row;
DataCol = cell(N,1);
% For loop for splitting of data
for i = 1:N
    DataCol{i} = Data(1+ind1:ind2,:);
    ind1 = ind2;
    ind2 = ind1 + Num_Row;
end

end

