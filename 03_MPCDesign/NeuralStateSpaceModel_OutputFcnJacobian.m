function [C, D] = NeuralStateSpaceModel_OutputFcnJacobian(x,u)
%% auto-generated output Jacobian function of neural state space system
%# codegen
C = eye(2);
D = zeros(2,2);
