%% DESCRIPTION: This Script is for initializing the first iteration of MPC: No on-off aeration functionality
clear;
clc;
%% Run initializer script
Init_Model;

%% Generate state MATLAB function for nonlinear MPC
generateMATLABFunction(sys,'stateFcn','outputFcn')

%% Design nonlinear MPC
% Sample time / day
Ts = 15/(24*60);

% Initial states
x0 = [0, 0];
% Reference
ref = [0, 0];

% 2 states, 2 outputs, 1 MV, 1 MD
nlobj = nlmpc(2,2,'MV',1,'MD',2);
% Defining sample time
nlobj.Ts = Ts;
% Lower and upper bound of manipulated variable
nlobj.ManipulatedVariables.Min = (1 - Norm.C(2))/Norm.S(2);
nlobj.ManipulatedVariables.Max = (4 - Norm.C(2))/Norm.S(2);
nlobj.ManipulatedVariables.RateMax = 0.05;
nlobj.ManipulatedVariables.RateMin = -1*nlobj.ManipulatedVariables.RateMax;
% nlobj.ManipulatedVariables.Min = (4 - Norm.C(1))/Norm.S(1);

% Define trained neural state space model for MPC prediction model
nlobj.Model.StateFcn = 'stateFcn';
nlobj.Jacobian.StateFcn = 'stateFcnJacobian';

% Set weights
nlobj.Weights.OutputVariables = [0 1];
