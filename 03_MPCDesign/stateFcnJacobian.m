function [A, B] = stateFcnJacobian(x,u)
%% auto-generated state Jacobian function of neural state space system
%# codegen
persistent StateNetwork
MATname = 'stateFcnData';
if isempty(StateNetwork)
    StateNetwork = coder.load(MATname);
end
out = [x;u];
J = eye(length(out));
% hidden layer #1
Jfc = StateNetwork.fc1.Weights;
out = StateNetwork.fc1.Weights*out + StateNetwork.fc1.Bias;
Jac = deep.internal.coder.jacobian.tanh(out);
out = deep.internal.coder.tanh(out);
J = Jac*Jfc*J;
% hidden layer #2
Jfc = StateNetwork.fc2.Weights;
out = StateNetwork.fc2.Weights*out + StateNetwork.fc2.Bias;
Jac = deep.internal.coder.jacobian.tanh(out);
out = deep.internal.coder.tanh(out);
J = Jac*Jfc*J;
% output layer
J = StateNetwork.output.Weights*J;
% generate Jacobian matrices
A = J(:,1:2);
B = J(:,3:4);
