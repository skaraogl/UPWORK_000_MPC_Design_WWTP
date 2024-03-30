clear;
clc;
%% Load Data
load('C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\00_RawData\Data_2024_03_08.mat')

%% INPUTS
% Number of inputs to be used
N_u = 2;
% Number of states to be used
N_x = 2;
% Number of experiments/ days
% N = 7*8; 
% Data Prediction Step
N = 480;
% Use normalized data set / boolean
I_n = 1;
% Order of resampling data
N_re = 10;
% Interpolation method
method = 'pchip';

% Input names
Char_In = 'DO&NH';
% Output names
Char_Out = 'NO&TNout';
% Additional remarks
Char_add = 'DataSegm';

%% Collect Data
% Put all the desired data in one matrix
if N_u == 1
    DataRep = [Data.t_Day,...
            Data.DO,...
            Data.TNout];
elseif N_u == 3
    DataRep = [Data.t_Day,...
        Data.DO,...
        Data.NO,...
        Data.NH,...
        Data.TNout];
elseif N_u == 2 && N_x == 1
    if contains(Char_In,'DO') && contains(Char_In,'NH')
        DataRep = [Data.t_Day,...
        Data.DO,...
        Data.NH,...
        Data.TNout];
    else
        DataRep = [Data.t_Day,...
            Data.DO,...
            Data.NO + Data.NH,...
            Data.TNout];
    end
elseif N_u == 2 && N_x == 2
    DataRep = [Data.t_Day,...
        Data.DO,...
        Data.NH,...
        Data.NO,...
        Data.TNout];
else
    DataRep = [Data.t_Day,...
        Data.DO,...
        Data.NO,...
        Data.NH,...
        Data.TSS,...
        Data.TNout];
end

%% Increase Sample Rate of Data
DataRep = getHigherSample(DataRep,10,method);

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
% DataCol = getSplittedDataComplex(DataRep,N);
DataCol = getSplittedDataSegments(DataRep,N);
% Plot;

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

% save(['Model_Data_U',num2str(N_u),'_X',num2str(N_x),'_N',num2str(N),'.mat'],'U','Y','DataRep','Norm')
save(['Model_Data_U',Char_In,'_X',Char_Out,'_N',num2str(N),'_',Char_add,'.mat'],'U','Y','DataRep','Norm')

%% Clear Workspace
clearvars -except U Y;