%% Load Data
clear;
clc;
load('C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\00_RawData\Data_2024_03_08.mat')

%% Slice Data
% Number of experiments/ days
N = 7; 
% Number of inputs to be used
N_u = 1;
% Number of columns
Num_Col = height(Data)/N;

ind1 = 0;
ind2 = Num_Col;
DataCol = cell(N,1);
% For loop for splitting of data
for i = 1:N
    if N_u == 1
        DataCol{i} = [Data.t_Day(1+ind1:ind2),...
            Data.DO(1+ind1:ind2),...
            Data.TNout(1+ind1:ind2)];
    elseif N_u == 3
        DataCol{i} = [Data.t_Day(1+ind1:ind2),...
            Data.DO(1+ind1:ind2),...
            Data.NO(1+ind1:ind2),...
            Data.NH(1+ind1:ind2),...
            Data.TNout(1+ind1:ind2)];
    end
    ind1 = ind2;
    ind2 = ind1 + Num_Col;
end


M = width(DataCol{1});

%% Normalize Data
DataColN = cell(N,1);
for i = 1:N
    DataColN{i} = [DataCol{i}(:,1), normalize(DataCol{i}(:,2:M))];
end

%% Get Model Training Data
[~,U,Y] = getModelData(DataColN);

%% Split Data into Training and Testing Data
if ~exist('U_T','var') 
    U_T = U{end};
    Y_T = Y{end};
    
    U = {U{1:end-1}}';
    Y = {Y{1:end-1}}';

    save('Model_Data.mat','U','Y','U_T','Y_T')
end

%% Clear Workspace
clearvars -except U U_T Y Y_T;