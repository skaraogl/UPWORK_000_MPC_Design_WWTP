name1 = 'Plot_SplittedDataN_3x3_over6Days';
name2 = 'Plot_CorrelationN_3x3_over7Days';
fig_width = 1600;
fig_height = 800;

close all;

%% Plot Data

fig1 = figure("Position",[100 100, fig_width fig_height]);
for i = 1:6
    
    subplot(3,2,i)
    hold on
    plot(DataCol{i}(:,1), DataCol{i}(:,2),'mo','DisplayName','DO')
    plot(DataCol{i}(:,1), DataCol{i}(:,3),'bo','DisplayName','NO')
    plot(DataCol{i}(:,1), DataCol{i}(:,4),'ko','DisplayName','NH')
    plot(DataCol{i}(:,1), DataCol{i}(:,end),'ro','DisplayName','TNout')

    plot(DataColRe{i}(:,1), DataColRe{i}(:,2),'m','DisplayName','DO (interp.)')
    plot(DataColRe{i}(:,1), DataColRe{i}(:,3),'b','DisplayName','NO (interp.)')
    plot(DataColRe{i}(:,1), DataColRe{i}(:,4),'k','DisplayName','NH (interp.)')
    plot(DataColRe{i}(:,1), DataColRe{i}(:,end),'r','DisplayName','TNout (interp.)')

    % plot(DataCol{i}(:,1), DataCol{i}(:,2),'m','DisplayName','DO')
    % plot(DataCol{i}(:,1), DataCol{i}(:,3),'b','DisplayName','NO+NH')
    % plot(DataCol{i}(:,1), DataCol{i}(:,4),'r','DisplayName','TNout')
    hold off
    legend
    
    if i >= N-2
        xlabel('Time t [d]')
    end
    title(['Day ', num2str(i/2)])
end

%% Plot Correlation
% Correlation;

%% Save figures
% Figure Data
% saveas(fig1,['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\00_Figures\',name1,'.fig'])
% saveas(fig1,['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\00_Figures\',name1,'.png'])
% Figure Correlation
% saveas(fig_corr,['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\00_Figures\',name2,'.fig'])
% saveas(fig_corr,['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\00_Figures\',name2,'.png'])

%% Clear Workspace
% clear fig1 fig_corr fig_height fig_width name1 name2