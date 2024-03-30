
%% Load Training Data
dataFile = 'Model_Data_UDO&NH_XNO&TNout_N480_DataSegm.mat';
load(['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\',dataFile])
%% Load Trainig Model
modelFile = 'TrainModel_20240314_1733_UDO&NH_XNO&TNout_N480_DataSegm.mat';
load(modelFile)
%% Load Linear Regression Model
% linFile = 'LinearRegression_20240310_1617.mat';
% load(linFile)