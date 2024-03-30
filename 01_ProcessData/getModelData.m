function [DataM,U,Y] = getModelData(Data, N_u, N_x)
%GETMODELDATA Summary of this function goes here
%   Detailed explanation goes here

%% Randomize cell data order
rng("default")
N = height(Data);

N_rnd = randperm(N);
DataRnd = cell(N,1);

for i = 1:N
    DataRnd{i} = Data{N_rnd(i)};
end

%% Start time array at 0
DataM = cell(N,1);
for i = 1:N
    DataM{i} = [DataRnd{i}(:,1)-DataRnd{i}(1,1),DataRnd{i}(:,2:end)];
end

%% Convert Matrices to timetables
U = cell(N, 1);
Y = cell(N, 1);

for i = 1:N
    if N_u == 1 && N_x == 1
        U{i} = timetable(seconds(DataM{i}(:,1)),DataM{i}(:,2),'VariableNames',"u");
        Y{i} = timetable(seconds(DataM{i}(:,1)),DataM{i}(:,end),'VariableNames',"y");
    elseif N_u == 2 && N_x == 1
        U{i} = timetable(seconds(DataM{i}(:,1)),DataM{i}(:,2),...
            DataM{i}(:,3),'VariableNames',["u1","u2"]);
        Y{i} = timetable(seconds(DataM{i}(:,1)),DataM{i}(:,end),'VariableNames',"y");
    elseif N_u == 2 && N_x == 2
        U{i} = timetable(seconds(DataM{i}(:,1)),DataM{i}(:,2),...
            DataM{i}(:,3),'VariableNames',["u1","u2"]);
        Y{i} = timetable(seconds(DataM{i}(:,1)),DataM{i}(:,end-1),...
            DataM{i}(:,end),'VariableNames',["y1","y2"]);
    elseif N_u == 3 && N_x == 1
        U{i} = timetable(seconds(DataM{i}(:,1)),...
            DataM{i}(:,2),...
            DataM{i}(:,3),...
            DataM{i}(:,4),'VariableNames', ["u1","u2","u3"]);
        Y{i} = timetable(seconds(DataM{i}(:,1)),DataM{i}(:,end),'VariableNames',"y");
    elseif N_u == 1 && N_x == 4
        U{i} = timetable(seconds(DataM{i}(:,1)),DataM{i}(:,2),'VariableNames',"u");
        Y{i} = timetable(seconds(DataM{i}(:,1)),...
            DataM{i}(:,3),...
            DataM{i}(:,4),...
            DataM{i}(:,5),...
            DataM{i}(:,6),'VariableNames', ["x1","x2","x3","x4"]);
    else
        U{i} = timetable(seconds(DataM{i}(:,1)),DataM{i}(:,2),'VariableNames',"u");
        Y{i} = timetable(seconds(DataM{i}(:,1)),...
            DataM{i}(:,3),...
            DataM{i}(:,4),...
            DataM{i}(:,5),'VariableNames', ["x1","x2","x3"]);
    end
end

end

