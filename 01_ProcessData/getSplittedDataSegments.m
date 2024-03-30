function [DataCol] = getSplittedDataSegments(Data,N)
%GETSPLITTEDDATACOMPLEX Summary of this function goes here
%   Detailed explanation goes here
% Number of rows

Num_Exp = height(Data) - N;
DataCol = cell(Num_Exp,1);

for i = 1:Num_Exp
    DataCol{i} = Data(i:i+N,:); 
end

end

