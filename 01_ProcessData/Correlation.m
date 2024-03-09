%% Correlation
Corr.U = (Data.DO);
Corr.X = (Data.TNout);
Corr.coeff = polyfit(Corr.U, Corr.X,1);

%% Determine correlation coefficient of splitted data
Corr.coeffs = cell(N,1);
Corr.coeffsN = cell(N,1);
for i = 1:N
    Corr.coeffs{i} = polyfit(DataCol{i}(:,2),DataCol{i}(:,3),1);
    Corr.coeffsN{i} = polyfit(DataColN{i}(:,2),DataColN{i}(:,3),1);
end

clear ind1 ind2