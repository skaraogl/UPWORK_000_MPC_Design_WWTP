%% Find local maxima
[lcl_max, lcl_max_t] = findpeaks(DataRep(:,3),DataRep(:,1));
lcl_max = [DataRep(1,3); lcl_max];
lcl_max_t = [DataRep(1,1); lcl_max_t];

%% Find local minima
% [lcl_min, lcl_min_t] = findpeaks(-1.*DataRep(:,3),DataRep(:,1));
% lcl_min = -1.*lcl_min;
lcl_min_ind = islocalmin(DataRep(:,3),'FlatSelection','last');
lcl_min = DataRep(lcl_min_ind,3);
lcl_min_t = DataRep(lcl_min_ind,1);

%% Generate aeration on-off phases
OnOff = zeros(height(DataRep),1);
k_max = 1;
k_min = 1;
level = 0;
for i = 1:length(OnOff)
    if k_max >= 64
        k_max = 63;
    end

    if k_min >= 64
        k_min = 63;
    end

    if DataRep(i,1) == lcl_max_t(k_max)
        level = 0;
        OnOff(i) = level;
        k_max = k_max + 1;
    elseif DataRep(i,1) == lcl_min_t(k_min)
        level = 1;
        OnOff(i) = level;
        k_min = k_min + 1;
    else
        OnOff(i) = level;
    end
end

%% Plot peaks
close all;

figure
hold on
plot(DataRep(:,1),DataRep(:,3),'b')
plot(DataRep(:,1),OnOff,'k')
plot(lcl_max_t,lcl_max,'rx')
plot(lcl_min_t,lcl_min,'mx')
hold off

%% Save aeration on-off indices
save("OnOffTimes.mat","OnOff")