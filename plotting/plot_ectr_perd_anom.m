% ------------------------------------------------------------------------
% script to plot ecotron variable anomalies in different periods

% initalise 
close all
axcolor = [0.3 0.3 0.3];

cmap_temperature = flipud(mf_colormap_cpt('temperature'));
cmap_tas = flipud(cmap_temperature(1:6,:));
cmap_pr = flipud(mf_colormap_cpt('YlGnBu 07'));

% xticks and labels
time_begin_5y = [periods(6,2) 01 01 0  0 0]; 
time_end_5y   = [periods(6,3) 12 31 23 0 0]; 
date_vec_5y = datevec(datenum(time_begin_5y):1:datenum(time_end_5y)); 
date_5y     = date_vec_5y(:,1:3); 
years = periods(6,2):1:periods(6,3);

for i=1:5
[locs, xtick(i)] = ismember([years(i) 1 1],date_5y(:,1:3),'rows'); 

end


% filtering of data
perf_smoothing

figure('rend','painters','pos',[10 10 950 800]);

% temperature
ax = mf_subtightplot(3,2,1,[0.08 0.08]);

for i = length(periods):-1:1
    plot(tas_smoothed(:,i)-276.13,'LineWidth',1,'Color',cmap_tas(i,:))
    hold on
end
hold off

% plot specifics
xlim([1 length(tas_extr)])
ylim([-6 25])
grid on
set(gca,'Fontsize', 12, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 12, 'Fontweight', 'Bold','ycolor', axcolor)
set(gca,'XTick',xtick, 'XTickLabel', 1:5,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
%legend('+ 4 ^{\circ}C','+ 3 ^{\circ}C','+ 2 ^{\circ}C', '+ 1.5 ^{\circ}C','+ 1 ^{\circ}C', '+ 0 ^{\circ}C')
%set(legend, 'TextColor', axcolor, 'location','westoutside', 'Box', 'off')
title(' ', 'Color',axcolor)
ylabel('Mean Air Temperature (^{\circ}C)')


% precipitation 
ax = mf_subtightplot(3,2,2,[0.08 0.08]);

for i = 1:length(periods)
    plot(pr_smoothed(:,i),'LineWidth',1,'Color',cmap_tas(i,:))
    hold on
end
hold off

% plot specifics
xlim([1 length(tas_extr)])
grid on
set(gca,'Fontsize', 12, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 12, 'Fontweight', 'Bold','ycolor', axcolor)
set(gca,'XTick',xtick, 'XTickLabel', 1:5,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
title(' ', 'Color',axcolor)
ylabel('Precipitation (mm/day)')


% rh
ax = mf_subtightplot(3,2,3,[0.08 0.08]);

for i = 1:length(periods)
    plot(rh_smoothed(:,i),'LineWidth',1,'Color',cmap_tas(i,:))
    hold on
end
hold off

% plot specifics
xlim([1 length(tas_extr)])
%ylim([-25 25])

grid on
set(gca,'Fontsize', 12, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 12, 'Fontweight', 'Bold','ycolor', axcolor)
set(gca,'XTick',xtick, 'XTickLabel', 1:5,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
title(' ', 'Color',axcolor)
ylabel('Relative Humidity (%)')



% wind
ax = mf_subtightplot(3,2,4,[0.08 0.08]);

for i = 1:length(periods)
    plot(sfcWind_smoothed(:,i),'LineWidth',1,'Color',cmap_tas(i,:))
    hold on
end
hold off

% plot specifics
xlim([1 length(tas_extr)])
%ylim([-1.3 1.3])

grid on
set(gca,'Fontsize', 12, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 12, 'Fontweight', 'Bold','ycolor', axcolor)
set(gca,'XTick',xtick, 'XTickLabel', 1:5,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
title(' ', 'Color',axcolor)
ylabel('Surface Wind (m/s)')


% maxtemperature
ax = mf_subtightplot(3,2,5,[0.08 0.08]);

for i = 1:length(periods)
    plot(tasmax_smoothed(:,i)-276.13,'LineWidth',1,'Color',cmap_tas(i,:))
    hold on
end
hold off

%plot specifics
xlim([1 length(tas_extr)])
ylim([-6 25])
grid on
set(gca,'Fontsize', 12, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 12, 'Fontweight', 'Bold','ycolor', axcolor)
set(gca,'XTick',xtick, 'XTickLabel', 1:5,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
xlabel('Years')
title(' ', 'Color',axcolor)
ylabel('Max Air Temperature (^{\circ}C)')
%ylim([-14 14])



% mintemperature
ax = mf_subtightplot(3,2,6,[0.08 0.08]);

for i = 1:length(periods)
    plot(tasmin_smoothed(:,i)-276.13,'LineWidth',1,'Color',cmap_tas(i,:))
    hold on
end
hold off

%plot specifics
xlim([1 length(tas_extr)])
ylim([-6 25])
grid on
set(gca,'Fontsize', 12, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 12, 'Fontweight', 'Bold','ycolor', axcolor)
set(gca,'XTick',xtick, 'XTickLabel', 1:5,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
xlabel('Years')
title(' ','Color',axcolor)
ylabel('Min Air Temperature (^{\circ}C)')
%ylim([-14 14])

filename = strcat('var_per_ectr_anom2_legend');
pathname = 'C:\Users\ivand\Documents\ecotrons\scripts\matlab\plots\paper'; 
print(fullfile(pathname, filename),'-dtiff','-r1000')

