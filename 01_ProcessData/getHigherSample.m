function [DataRe] = getHigherSample(Data,N_re,method)
%GETHIGHERSAMPLE Summary of this function goes here
%   Detailed explanation goes here

% Determine Sample Rate
Ts = Data(2,1);
% Redefine new sample rate
Ts = Ts/N_re;
% Define new time array
t = (0:Ts:7-Ts)';
% Define resampled matrix
DataRe = t;

for i = 2:width(Data)
    y = interp1(Data(:,1),Data(:,i),t,method);
    DataRe(:,i) = y;
end

end

