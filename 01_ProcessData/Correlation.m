% close all;

%% Create timetable for correlation plot
% CorrTbl = timetable(days(DataRep(:,1)),...
%     DataRep(:,2),...
%     DataRep(:,3),...
%     DataRep(:,4),...
%     DataRep(:,5),...
%     DataRep(:,6),'VariableNames',["DO","NO","NH","TSS","TNout"]);
CorrTbl = timetable(days(DataRep(:,1)),...
    DataRep(:,2),...
    DataRep(:,3),...
    DataRep(:,4),'VariableNames',["DO","TNin","TNout"]);

%% Plot correlation plot
fig_corr = figure("Position",[100 100, fig_width fig_height]);
corrplot(CorrTbl)

%% Correlation
% Corr.U = (Data.TNout);
% Corr.X = (Data.TNout);
% Corr.coeff = polyfit(Corr.U, Corr.X,1);

%% Determine correlation coefficient of splitted data
% Corr.coeffs = cell(N,1);
% Corr.coeffsN = cell(N,1);
% for i = 1:N
%     Corr.coeffs{i} = polyfit(DataCol{i}(:,2),DataCol{i}(:,3),1);
% end
% 
% clear ind1 ind2