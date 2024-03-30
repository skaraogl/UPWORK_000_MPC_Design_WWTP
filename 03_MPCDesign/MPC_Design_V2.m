%% DESCRIPTION: This Script is for initializing the 2nd iteration of MPC: W/ on-off aeration functionality
clear;
clc;
%% Run initializer script
Init_Model;
load('C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\03_MPCDesign\OnOffTime\OnOffTimes.mat')
% Load smoothed ammonia data
load('C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\03_MPCDesign\OnOffTime\NH_simp.mat')

%% Generate state MATLAB function for nonlinear MPC
generateMATLABFunction(sys,'stateFcn')

%% Design nonlinear MPC
% Sample time / day
Ts = 15/(24*60);
p = 10;
k = 2;

% Initial states
x0 = [DataRep(1,4), DataRep(1,end)];
% Initial inputs
u0 = [DataRep(1,2), DataRep(1,3)];
% Reference
ref = [(0 - Norm.C(3))/Norm.S(3),...
    (4 - Norm.C(4))/Norm.S(4)];

% 2 states, 2 outputs, 1 MV, 1 MD
nlobj = nlmpc(2,2,'MV',1,'MD',2);
% Defining sample time
nlobj.Ts = Ts;
% Defining prediction horizon
nlobj.PredictionHorizon = p;
% Defining coontrol horizon
nlobj.ControlHorizon = k;

% Lower and upper bound of manipulated variable
nlobj.ManipulatedVariables.Min = (0 - Norm.C(1))/Norm.S(1);
nlobj.ManipulatedVariables.Max = (7 - Norm.C(1))/Norm.S(1);
% nlobj.ManipulatedVariables.MaxECR = 5;
nlobj.ManipulatedVariables.RateMax = 3;
nlobj.ManipulatedVariables.RateMin = -1*nlobj.ManipulatedVariables.RateMax;

% Lower bound of output variable
nlobj.OutputVariables(2).Min = (0 - Norm.C(4))/Norm.S(4);

% Define trained neural state space model for MPC prediction model
nlobj.Model.StateFcn = 'stateFcn';
nlobj.Model.IsContinuousTime = true;

% Set weights (-> Only TNout is controlled)
nlobj.Weights.OutputVariables = [0 1];

%% Define custom cost function
% nlobj.Optimization.CustomCostFcn = 'CostFunctionAeration';
% nlobj.Jacobian.CustomCostFcn = 'CostFunctionAerationJacobian';
% nlobj.Optimization.ReplaceStandardCost = true;
% nlobj.Model.NumberOfParameters = 1;

%% Validate nonlinear mpc
validateFcns(nlobj,x0,u0(1),u0(2))
nlobj.Jacobian.StateFcn = 'stateFcnJacobian';

%% Set up data
% Set up structures for MD
NH.time = DataRep(:,1);
NH.signals.values = DataRep(:,3);

% Set up aeration activation
OO.time = DataRep(:,1);
OO.signals.values = OnOff;

% Set up DO max. setpoint
DOMAX.time = DataRep(:,1);
DOMAX.signals.values = OO.signals.values;
DOMAX.signals.values = changem(DOMAX.signals.values,...
    nlobj.ManipulatedVariables.Max,0);
DOMAX.signals.values = changem(DOMAX.signals.values,...
    DE_NORMALIZE(0.1,Norm.C(1),Norm.S(1)),1);