function [DataM,U,Y] = getModelData(Data)
%GETMODELDATA Summary of this function goes here
%   Detailed explanation goes here

%% Randomize cell data order
rng("default")
N = height(Data);
M = width(Data{1});

N_rnd = randperm(N);
DataRnd = cell(N,1);

for i = 1:N
    DataRnd{i} = Data{N_rnd(i)};
end

%% Start time array at 0
DataM = cell(N,1);
for i = 1:N
    DataM{i} = [DataRnd{i}(:,1)-DataRnd{i}(1,1),DataRnd{i}(:,2:M)];
end

%% Convert Matrices to timetables
U = cell(N, 1);
Y = cell(N, 1);

for i = 1:N
    if (M - 2) == 1
        U{i} = timetable(seconds(DataM{i}(:,1)),DataM{i}(:,2),'VariableNames',"u");
        % Y{i} = timetable(seconds(DataM{i}(:,1)),DataM{i}(:,3),'VariableNames',"y");
    elseif (M - 2) == 3
        U{i} = timetable(seconds(DataM{i}(:,1)),...
            DataM{i}(:,2),...
            DataM{i}(:,3),...
            DataM{i}(:,4),'VariableNames', ["u1","u2","u3"]);
    end
    Y{i} = timetable(seconds(DataM{i}(:,1)),DataM{i}(:,end),'VariableNames',"y");
end

end

