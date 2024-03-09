clear;
close all;
clc;
%% Check if Model Training Data exists
if isfile('C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\Model_Data.mat')
    load('C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\Model_Data.mat')
else
    run('C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\ProcessData.m')
end

%% Designing Neural State Space Model
% Number of training experiments
N = length(Y) - 1;
% Number of inputs
N_u = 1;

% NSS system
sys = idNeuralStateSpace(1,"NumInputs",N_u);
rng('default')

% Define state network
sys.StateNetwork = createMLPNetwork(sys,'state',...
    LayerSize = [128 128],...
    Activations = "tanh",...
    WeightsInitializer = "glorot",...
    BiasInitializer = "zeros");

%% Training of NSSM
options = nssTrainingOptions('sgdm');
options.MaxEpochs = 200;
options.MiniBatchSize = N;

tic
sys = nlssest(U,Y,sys,options,UseLastExperimentForValidation=true);
toc