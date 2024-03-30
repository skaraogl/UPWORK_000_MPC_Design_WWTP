%% Regression of NH Data
p_NH = polyfit(DataRep(:,1),DataRep(:,3),10);

%% PLOTTING
close all;

figure
hold on
plot(DataRep(:,1),DataRep(:,3),'b')
plot(DataRep(:,1),polyval(p_NH,DataRep(:,1)),'r--')
hold on

%% SAVE
NH_simpl = polyval(p_NH,DataRep(:,1));
save('NH_simp.mat','NH_simpl')