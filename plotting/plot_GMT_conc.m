% ----------------------------------------------------------------------
% Script to plot figures for conceptual figure opinion paper
close all

% determine for which period is plotted 
% 1: 2086 - 2090 4°C
% 2: 2063 - 2067 3°C
% 3: 2042 - 2046 2°C
% 4: 2026 - 2030 1.5°C
% 5: 2009 - 2013 1°C
% 6: 1951 - 1955 0°C (reference period)
ind_per = 3; 
ind_ref = 6; 
deltaT= periods(ind_per,1); 



%% plot GMT following EC-EARTH for conceptual plot opinion paper

figure()

% initialisation
axcolor = [0.3 0.3 0.3]; 

line_deltaT = ones(size(years_GCM))*deltaT; 
% determine year in which deltaT is reached for first time
deltaT_year = periods(ind_per,2)+2; 

line_deltaT(find(years_GCM>deltaT_year)) = nan; 

% vertical lines to indicate the years. 

% temperature anomaly
plot(years_GCM,T_anom,'r',  'LineWidth', 2)
hold on
plot(years_GCM,line_deltaT,'Color',[0.5 0.5 0.5],  'LineWidth', 1.5)
line([periods(ind_per,2) periods(ind_per,2)],[-1 T_anom(find(years_GCM==periods(ind_per,2)))],'Color',[0.5 0.5 0.5],  'LineWidth', 1.5)
line([periods(ind_per,3) periods(ind_per,3)],[-1 T_anom(find(years_GCM==periods(ind_per,3)))],'Color',[0.5 0.5 0.5],  'LineWidth', 1.5)

hold off

%title('Select time window from driving GCM', 'Fontsize', 14, 'Fontweight', 'Bold','Color', axcolor)
ylabel('Global mean temperature anomaly (°C)')
xlim([1870 2100])
ylim([-0.7 4.6])
set(gca,'Fontsize', 14, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 14, 'Fontweight', 'Bold','ycolor', axcolor)

set(gca,'XTick',[1900,1950,2000,2050,2100],...
    'XTickLabel', {'1900','1950','2000','2050','2100'},...
    'Fontsize', 11, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'YTick',[0, 1,1.5,2,3,4], 'YTickLabel', {'+ 0°','+ 1°','+ 1.5°','+ 2°','+ 3°','+ 4°'},'Fontsize', 11, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Color','none')

grid on
export_fig GCM2.PNG -transparent
%% plot Temperature at ecotron site voor selected period

figure()

% plot annual means, not monthly means
flag_year = 1; 

% initialisation
axcolor = [0.3 0.3 0.3]; 

months = unique(date(:,1:2),'rows'); 

ind_ref = 2; 

% precipitation
rh_15 = rh_extr(:,ind_ref); 



    xticks = 1:365:(5*365)+1;
    xlabels = {num2str(periods(ind_per,2)),num2str(periods(ind_per,2)+1),...
                 num2str(periods(ind_per,2)+2),num2str(periods(ind_per,3)-1), ...
                 num2str(periods(ind_per,3)), num2str(periods(ind_per,3)+1)};     
   
     
   % yticks = [-10, -5, 0, 5,10];
    %ylabels = {'- 10°','- 5° ','+ 0° ','+ 5° ','+ 10°'};
    
% vertical lines to indicate the years. 

% temperature anomaly
plot(rh_15,  'LineWidth', 1)

hold off

%title('Extract timeseries from RCM at ecotron site', 'Fontsize', 14, 'Fontweight', 'Bold','Color', axcolor)
ylabel('Relative humidity (%)')
set(gca,'Fontsize', 14, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 14, 'Fontweight', 'Bold','ycolor', axcolor)
set(gca,'XTick',xticks,...
   'XTickLabel', xlabels,...
    'Fontsize', 11, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'color','none')
%set(gca,'YTick',yticks, 'YTickLabel', ylabels,'Fontsize', 11, 'Fontweight', 'Bold','xcolor', axcolor)
xlim([0 length(rh_15)])
ylim([30  102])
grid on

export_fig RCM.PNG -transparent

