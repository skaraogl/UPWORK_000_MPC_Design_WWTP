name1 = 'Plot_SplittedData_over6Days';
name2 = 'Plot_SplittedData_Normalized_over6Days';
fig_width = 1600;
fig_height = 800;

%% Plotting ---------------------------------------
close all;

% Data (all)
% figure
% hold on
% plot(Data.t_Day, Data.DO,'b','DisplayName','DO')
% plot(Data.t_Day, Data.TNout,'r','DisplayName','TNout')
% hold off
% legend
% 
% xlabel('Time t [d]')

% Data (split)
fig1 = figure("Position",[100 100, fig_width fig_height]);
for i = 1:N-1
    
    subplot(3,2,i)
    hold on
    plot(DataCol{i}(:,1), DataCol{i}(:,2),'b','DisplayName','DO')
    plot(DataCol{i}(:,1), DataCol{i}(:,3),'r','DisplayName','TNout')
    hold off
    legend
    
    if i >= N-2
        xlabel('Time t [d]')
    end
    title(['Day ', num2str(i)])
end

% Data (split & normalized)
fig2 = figure("Position",[100 100, fig_width fig_height]);
for i = 1:N-1
    
    subplot(3,2,i)
    hold on
    plot(DataCol{i}(:,1), DataCol{i}(:,2),'b','DisplayName','DO')
    plot(DataCol{i}(:,1), DataCol{i}(:,3),'r','DisplayName','TNout')
    plot(DataColN{i}(:,1), DataColN{i}(:,2),'b--','DisplayName','DO_n')
    plot(DataColN{i}(:,1), DataColN{i}(:,3),'r--','DisplayName','TNout_n')
    hold off
    legend
    
    if i >= N-2
        xlabel('Time t [d]')
    end
    title(['Day ', num2str(i)])
end

% Correlation (split & normalized)
% figure
% for i = 1:N-1
% 
%     subplot(3,2,i)
%     hold on
%     plot(DataColN{i}(:,2), DataColN{i}(:,3),'b.','DisplayName','TNout_n')
%     plot(DataColN{i}(:,2),polyval(Corr.coeffsN{i},DataColN{i}(:,2)),'r')
%     hold off
%     legend
% 
%     if i >= N-2
%         xlabel('DO')
%     end
% 
%     if i == 1 || i == 3 || i == 5
%         ylabel('T_N_o_u_t')
%     end
% 
%     title(['Correlation Coeff. = ', num2str(Corr.coeffsN{i}(1)), ' (Day ',num2str(i),')'])
% end

% Correlation 
% figure
% hold on
% plot(Corr.U, Corr.X,'b.')
% plot(Corr.U,polyval(Corr.coeff,Corr.U),'r')
% 
% xlabel('DO')
% ylabel('T_N_o_u_t')
% title(['Correlation Coeff. = ', num2str(Corr.coeff(1))])

%% Save figures
% Figure 1
saveas(fig1,['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\00_Figures\',name1,'.fig'])
saveas(fig1,['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\00_Figures\',name1,'.png'])
% Figure 2 
saveas(fig2,['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\00_Figures\',name2,'.fig'])
saveas(fig2,['C:\Users\Selim\SK_Code\UPWORK_000_MeskJan_MPC_Design_WWTP\01_ProcessData\00_Figures\',name2,'.png'])

%% Clear Workspace
clear fig1 fig2 fig_height fig_width name1 name2