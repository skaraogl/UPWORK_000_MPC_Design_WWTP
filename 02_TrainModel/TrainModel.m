clear;
close all;
clc;
%% Check if 
% Model Training Data exists
dataFile = 'Model_Data_U2_X1_N14.mat';

if isfile(['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\',dataFile])
    load(['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\',dataFile])
else
    run('C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\ProcessData.m')
end

%% Designing Neural State Space Model
% Number of training experiments
N = length(Y) - 1;
% Number of inputs
N_u = 2;
% Number of states
N_x = 1;

% NSS system
sys = idNeuralStateSpace(N_x,"NumInputs",N_u,"NumOutputs",N_x);
rng('default')

% Define state network
sys.StateNetwork = createMLPNetwork(sys,'state',...
    LayerSize = [128 128],...
    Activations = "tanh",...
    WeightsInitializer = "glorot",...
    BiasInitializer = "zeros");

% % Define output network
% sys.OutputNetwork(2) = createMLPNetwork(sys,'output', ...
%    LayerSizes=[128 128], ...
%    Activations="tanh", ...
%    WeightsInitializer="glorot", ...
%    BiasInitializer="zeros");

%% Training of NSSM
options = nssTrainingOptions('sgdm');
options.MaxEpochs = 400;
options.MiniBatchSize = N;

tic
sys = nlssest(U,Y,sys,options,UseLastExperimentForValidation=true);
toc

%% Save NSSM
save(['TrainModel_',char(datetime('now','Format','yyyyMMdd_HHmm')),...
    dataFile(11:end)],"sys","options")

%% Compare
if exist('fig_comp','var')
    close(fig_comp);
end

fig_width = 1600;
fig_height = 800;

if N_u == 2 && N_x == 1
    U_all = timetable(seconds(DataRep(:,1)),...
        DataRep(:,2),...
        DataRep(:,3),'VariableNames',["u1","u2"]);
    
    Y_all = timetable(seconds(DataRep(:,1)),...
        DataRep(:,end),'VariableNames',"y");
elseif N_u == 1 && N_x == 3
    U_all = timetable(seconds(DataRep(:,1)),...
        DataRep(:,2),'VariableNames',"u");
    
    Y_all = timetable(seconds(DataRep(:,1)),...
        DataRep(:,3),...
        DataRep(:,4),...
        DataRep(:,end),'VariableNames',["y1","y2","y3"]);
end

fig_comp = figure("Position",[100 100, fig_width fig_height],"Name",'Model Validation');
compare([U_all,Y_all],sys)

if ~isfile(['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\00_Figures\Valid',...
    dataFile(11:end),'.fig'])
    saveas(fig_comp, ['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\00_Figures\Valid',...
        dataFile(11:end),'.fig'])
    saveas(fig_comp, ['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\00_Figures\Valid',...
        dataFile(11:end),'.png'])
end
clear fig_comp