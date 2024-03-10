%% DESCRIPTION
% By investigating the correlation between NO+NH and TNout it was found,
% that both features have corr. coefficient of +0.98, which allows to
% develop a simple linear regression model. The model will be a polynomial
% regression model.

%% Define data
u = DataRep(:,end);
y = DataRep(:,3);
x = -3:0.1:5;

%% Calculate polynomial coefficient
p_reg = polyfit(u,y,1);

%% Plot Regression
fig_reg = figure("Position",[100 100, fig_width fig_height]);

hold on
plot(u,y,'b.','DisplayName','Data')
plot(x,polyval(p_reg,x),'r-','DisplayName','Linear Regression')
hold off
legend

title('Linear Regression')

%% Plot Data
fig_valid = figure("Position",[100 100, fig_width fig_height]);

for i = 1:N-1
    
    subplot(3,2,i)
    hold on
    plot(DataCol{i}(:,1), DataCol{i}(:,3),'b','DisplayName','measured')
    plot(DataCol{i}(:,1), polyval(p_reg,DataCol{i}(:,end)),'r--','DisplayName','predicted')
    hold off
    legend

    if i == 1 || i == 3 || i == 5
        ylabel('NO+NH')
    end
        
    if i >= N-2
        xlabel('Time t [d]')
    end

    % MAE = mean(abs(DataCol{i}(:,3) - polyval(p_reg,DataCol{i}(:,end))));
    % nMAE = MAE./mean(DataCol{i}(:,3))*100;
    % title(['Day ', num2str(i), ' (nMAE: ',num2str(nMAE),' %)'])

    title(['Day ', num2str(i)])
end

sgtitle('Validation of Lin. Regression Model')