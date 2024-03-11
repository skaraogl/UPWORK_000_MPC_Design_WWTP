clear;
clc;
%% Load Data
load('C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\00_RawData\Data_2024_03_08.mat')

%% INPUTS
% Number of inputs to be used
N_u = 1;
% Number of states to be used
N_x = 3;
% Number of experiments/ days
N = 7*2; 
% Use normalized data set / boolean
I_n = 1;

%% Collect Data
% Put all the desired data in one matrix
if N_u == 1 && N_x == 0
    DataRep = [Data.t_Day,...
            Data.DO,...
            Data.TNout];
elseif N_u == 1 || N_u == 3
    DataRep = [Data.t_Day,...
        Data.DO,...
        Data.NO,...
        Data.NH,...
        Data.TNout];
elseif N_u == 2
    DataRep = [Data.t_Day,...
        Data.DO,...
        Data.NO + Data.NH,...
        Data.TNout];
else
    DataRep = [Data.t_Day,...
        Data.DO,...
        Data.NO,...
        Data.NH,...
        Data.TSS,...
        Data.TNout];
end

%% Normalize Data
% Calculate normalized data values and centering and scaling parameter C &
% S
if I_n == 1
    [DataRepN, Norm.C, Norm.S] = normalize(DataRep(:,2:end));
    DataRepN = [DataRep(:,1), DataRepN];
    DataRepSave = DataRep;
    DataRep = DataRepN;
end

%% Slice Data
% Number of columns
Num_Col = height(Data)/N;

ind1 = 0;
ind2 = Num_Col;
DataCol = cell(N,1);
% For loop for splitting of data
for i = 1:N
    DataCol{i} = DataRep(1+ind1:ind2,:);
    ind1 = ind2;
    ind2 = ind1 + Num_Col;
end

%% Get Model Training Data
[~,U,Y] = getModelData(DataCol, N_u, N_x);

%% Split Data into Training and Testing Data
% if ~exist('U_T','var') 
%     U_T = U{end};
%     Y_T = Y{end};
% 
%     U = {U{1:end-1}}';
%     Y = {Y{1:end-1}}';
% 
%     save(['Model_Data_U',num2str(N_u),'_X',num2str(N_x),'.mat'],'U','Y','U_T','Y_T','Norm')
% end

save(['Model_Data_U',num2str(N_u),'_X',num2str(N_x),'_N',num2str(N),'.mat'],'U','Y','DataRep','Norm')

%% Clear Workspace
clearvars -except U Y;