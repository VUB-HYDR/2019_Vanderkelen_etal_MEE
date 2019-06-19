% ------------------------------------------------------------------------
% Script to plot delta changes of anomalies different variables 

% defenition of reference period   
ref_per = 1977:1:2006; 


% initialise
years = unique(date_rcp(:,1));

axcolor = [0.3 0.3 0.3]; 
colors = mf_histcolors; 
colors(1,:) = [1 0 0]; 
gray = [0.7 0.7 0.7]; 
gray_range = [0.8 0.8 0.8]; 

% time variable and labels
clear label_loc
label_loc = 5:5:90; 
label_loc(length(label_loc)+1) = 94; 
label_loc(2:length(label_loc)+1) = label_loc; 
label_loc(1) = 1; 

year_labels = {'2006','2010','2015','2020','2025','2030','2035',...
    '2040','2045', '2050','2055','2060', '2065','2070','2075','2080',...
    '2085','2090','2095','2100'};

label_loc10 =5:10:94; 
label_loc10(length(label_loc10)+1) = 94; 
 
year_labels10 = {'2010','2020','2030','2040','2050','2060','2070',...
    '2080','2090','2100'};



% % historical climatology
% 
% load mean_HURS 
% load mean_PR 
% load mean_TAS 
% load mean_SFCWIND
% 
% PR_hist = (1:length(tas_ymean))'; 
% PR_hist(:) = mean_PR; 
% 
% RH_hist = (1:length(tas_ymean))'; 
% RH_hist(:) = mean_HURS; 
% 
% SFCWIND_hist = (1:length(tas_ymean))'; 
% SFCWIND_hist(:) = mean_SFCWIND; 
% 
% TAS_hist = (1:length(tas_ymean))'; 
% TAS_hist(:) = mean_TAS -273.15; 

    
% extract reference period  form historical variables
tas_extr(:,i) = mf_extract_prd_eco(tas_hist, date_hist(:,1), ref_per); 
tasmin_extr(:,i) = mf_extract_prd_eco(tasmin_hist, date_hist(:,1), ref_per); 
tasmax_extr(:,i) = mf_extract_prd_eco(tasmax_hist, date_hist(:,1), ref_per); 
sfcWind_extr(:,i) = mf_extract_prd_eco(sfcWind_hist, date_hist(:,1), ref_per); 
rh_extr(:,i) = mf_extract_prd_eco(rh_hist, date_hist(:,1), ref_per); 

% calculate anomalies
for i = 1:nm
    
    pr_extr(:,i) = mf_extract_prd_eco(pr_hist(:,i), date_hist(:,1), ref_per); 
    tas_extr(:,i) = mf_extract_prd_eco(tas_hist(:,i), date_hist(:,1), ref_per); 
    tasmin_extr(:,i) = mf_extract_prd_eco(tasmin_hist(:,i), date_hist(:,1), ref_per); 
    tasmax_extr(:,i) = mf_extract_prd_eco(tasmax_hist(:,i), date_hist(:,1), ref_per); 
    sfcWind_extr(:,i) = mf_extract_prd_eco(sfcWind_hist(:,i), date_hist(:,1), ref_per); 
    rh_extr(:,i) = mf_extract_prd_eco(rh_hist(:,i), date_hist(:,1), ref_per);  
    
    pr_anom(:,i) = pr(:,i)-mean(pr_extr(:,i));
    tas_anom(:,i) = tas(:,i)-mean(tas_extr(:,i));
    tasmin_anom(:,i) = tasmin(:,i)-mean(tasmin_extr(:,i));
    tasmax_anom(:,i) = tasmax(:,i)-mean(tasmax_extr(:,i));
    sfcWind_anom(:,i) = sfcWind(:,i)-mean(sfcWind_extr(:,i));
    rh_anom(:,i) = rh(:,i)-mean(rh_extr(:,i));
end
   


% calculate annual means of anomalies   
for i = 1:nm  
    
    % calculate annual mean
    tas_ymean(:,i) = mf_calc_ymean(tas_anom(:,i),date_rcp);
    pr_ymean(:,i) = mf_calc_ymean(pr_anom(:,i),date_rcp);
    sfcWind_ymean(:,i) = mf_calc_ymean(sfcWind_anom(:,i),date_rcp);
    rh_ymean(:,i) = mf_calc_ymean(rh_anom(:,i),date_rcp);
end


% calculate anmoalies for historical period
for i = 1:nm
    pr_anom_hist(:,i) = pr_hist(:,i)-mean(pr_extr(:,i));
    tas_anom_hist(:,i) = tas_hist(:,i)-mean(tas_extr(:,i));
    tasmin_anom_hist(:,i) = tasmin_hist(:,i)-mean(tasmin_extr(:,i));
    tasmax_anom_hist(:,i) = tasmax_hist(:,i)-mean(tasmax_extr(:,i));
    sfcWind_anom_hist(:,i) = sfcWind_hist(:,i)-mean(sfcWind_extr(:,i));
    rh_anom_hist(:,i) = rh_hist(:,i)-mean(rh_extr(:,i));
    
% annual means of anomalies
    tas_ymean_hist(:,i) = mf_calc_ymean(tas_anom_hist(:,i),date_hist);
    pr_ymean_hist(:,i) = mf_calc_ymean(pr_anom_hist(:,i),date_hist);
    sfcWind_ymean_hist(:,i) = mf_calc_ymean(sfcWind_anom_hist(:,i),date_hist);
    rh_ymean_hist(:,i) = mf_calc_ymean(rh_anom_hist(:,i),date_hist);

end

pr_anom_all = [pr_ymean_hist; pr_ymean];

rh_anom_all = [rh_ymean_hist; rh_ymean];


plot(pr_anom_all(:,11))

% calculate percentiles of anomalies
mean_tas = mean(tas_ymean)'
mean_pr = mean(pr_ymean)'
mean_rh = mean(rh_ymean)'
mean_sfcWind = mean(sfcWind_ymean)'

median(mean_tas)
    

prctile_tas = prctile(mean_tas',[30 50 90])
prctile_pr = prctile(mean_pr',[25 50 80])
prctile_rh = prctile(mean_rh',[25 50 75])
prctile_sfcWind = prctile(mean_sfcWind',[25 50 75])



%% Plotting

close all

% define model to plot
sel  = [11]; 
lsize = 11; 
tsize = 16; 

figure1 = figure('rend','painters','pos',[10 10 1000 600]);


% tas figure with range and one highlighted model


subplot(2,2,1)

tas_ymean_mod= tas_ymean(:,sel); 

min_tas_ymean = min(tas_ymean,[],2);
max_tas_ymean = max(tas_ymean,[],2);


pr_clim = (1:length(years)); 
x2 = [pr_clim, fliplr(pr_clim)];

range_tas = [min_tas_ymean' , fliplr(max_tas_ymean' )];
for i = 1:length(sel)
    plot(tas_ymean_mod(:,i), 'Color', colors(i,:),'LineWidth',1.5)
     hold on
end

plot(mean(tas_ymean,2),'k','LineWidth',2)


f1 = fill(x2, range_tas, gray_range);
set(f1,'facealpha',.5)
plot(min_tas_ymean,'Color',gray,'LineWidth',1)
plot(max_tas_ymean,'Color',gray,'LineWidth',1)
hold off

for i = 1:length(sel)
    model(i) = strcat(RCM_text(sel(i)),GCM_text(sel(i))); 
end
model{length(sel)+1} = 'Multi-model mean';
legend(model,'Box','off')

set(legend,'Fontweight', 'Bold','Fontsize', lsize, 'TextColor', axcolor,'Location','northwest');
xlim([1 94]) 
ylabel('Temperature anomaly (K)','Fontsize', lsize, 'Fontweight', 'Bold', 'color', axcolor)
title('Mean temperature anomaly ','Fontsize', tsize, 'Fontweight', 'Bold', 'color', axcolor)
set(gca, 'Fontsize', lsize, 'Fontweight', 'Bold','Xcolor', axcolor,...
   'Ycolor', axcolor,'xtick',label_loc10,'xticklabel',year_labels10,'xticklabelrotation',45); 
grid on



% precipitation

subplot(2,2,2)
pr_ymean_mod = pr_ymean(:,sel); 

min_pr_ymean = min(pr_ymean,[],2);
max_pr_ymean = max(pr_ymean,[],2);

pr_clim = (1:length(years)); 
x2 = [pr_clim, fliplr(pr_clim)];

range_pr = [min_pr_ymean' , fliplr(max_pr_ymean' )];

for i = 1:length(sel)
    plot(pr_ymean_mod(:,i), 'Color', colors(i,:),'LineWidth',1.5)
     hold on
end
plot(mean(pr_ymean,2),'k','LineWidth',2)

f1 = fill(x2, range_pr, gray_range);
set(f1,'facealpha',.5)
plot(min_pr_ymean,'Color',gray,'LineWidth',1)
plot(max_pr_ymean,'Color',gray,'LineWidth',1)
hold off


%legend(strcat(RCM_text(selection),GCM_text(selection)),'Multimodel mean')
%set(legend,'Fontweight', 'Bold','Fontsize', 16, 'TextColor', axcolor,'Location','best');
xlim([1 94]) 
%ylim([1 5])
ylabel('Precipitation anomaly (mm/day)','Fontsize', lsize, 'Fontweight', 'Bold', 'color', axcolor)
title('Precipitation anomaly','Fontsize', tsize, 'Fontweight', 'Bold', 'color', axcolor)
set(gca, 'Fontsize', lsize, 'Fontweight', 'Bold','Xcolor', axcolor,...
   'Ycolor', axcolor,'xtick',label_loc10,'xticklabel',year_labels10,'xticklabelrotation',45); 
grid on

% rh 
subplot(2,2,3)

rh_ymean_mod = rh_ymean(:,sel); 

min_rh_ymean = min(rh_ymean,[],2);
max_rh_ymean = max(rh_ymean,[],2);

pr_clim = (1:length(years)); 
x2 = [pr_clim, fliplr(pr_clim)];

range_rh = [min_rh_ymean' , fliplr(max_rh_ymean' )];
for i = 1:length(sel)
    plot(rh_ymean_mod(:,i), 'Color', colors(i,:),'LineWidth',1.5)
     hold on
end
mean_rh = mean(rh_ymean,2, 'omitnan');
plot(mean_rh,'k','LineWidth',2)

f1 = fill(x2, range_rh, gray_range);
set(f1,'facealpha',.5)
plot(min_rh_ymean,'Color',gray,'LineWidth',1)
plot(max_rh_ymean,'Color',gray,'LineWidth',1)
hold off


%legend(strcat(RCM_text(selection),GCM_text(selection)),'Multimodel mean')
%set(legend,'Fontweight', 'Bold','Fontsize', 16, 'TextColor', axcolor,'Location','best');
xlim([1 94]) 
%ylim([65 95])
ylabel('Relative humidity anomaly (%)','Fontsize', lsize, 'Fontweight', 'Bold', 'color', axcolor)
title('Relative humidity anomaly ','Fontsize', tsize, 'Fontweight', 'Bold', 'color', axcolor)
set(gca, 'Fontsize', lsize, 'Fontweight', 'Bold','Xcolor', axcolor,...
   'Ycolor', axcolor,'xtick',label_loc10,'xticklabel',year_labels10,'xticklabelrotation',45); 
grid on


% sfcWind 
subplot(2,2,4)

sfcWind_ymean_mod = sfcWind_ymean(:,sel); 

min_sfcWind_ymean = min(sfcWind_ymean,[],2);
max_sfcWind_ymean = max(sfcWind_ymean,[],2);

pr_clim = (1:length(years)); 
x2 = [pr_clim, fliplr(pr_clim)];

range_sfcWind = [min_sfcWind_ymean' , fliplr(max_sfcWind_ymean' )];
for i = 1:length(sel)
    plot(sfcWind_ymean_mod(:,i), 'Color', colors(i,:),'LineWidth',1.5)
     hold on
end

mean_sfcWind = mean(sfcWind_ymean,2, 'omitnan');
plot(mean_sfcWind,'k','LineWidth',2)

f1 = fill(x2, range_sfcWind, gray_range);
set(f1,'facealpha',.5)
plot(min_sfcWind_ymean,'Color',gray,'LineWidth',1)
plot(max_sfcWind_ymean,'Color',gray,'LineWidth',1)
hold off


%legend(strcat(RCM_text(selection),GCM_text(selection)),'Multimodel mean')
%set(legend,'Fontweight', 'Bold','Fontsize', 16, 'TextColor'(, axcolor,'Location','best');
xlim([1 94]) 
ylabel('Wind anomaly (m/s)','Fontsize', lsize, 'Fontweight', 'Bold', 'color', axcolor)
title('Surface wind speed anomaly','Fontsize', tsize, 'Fontweight', 'Bold', 'color', axcolor)
set(gca, 'Fontsize', lsize, 'Fontweight', 'Bold','Xcolor', axcolor,...
   'Ycolor', axcolor,'xtick',label_loc10,'xticklabel',year_labels10,'xticklabelrotation',45); 
grid on

% save figure
filename = strcat('rcp85_',RCM(sel(i)),'_',GCM_text(sel(i)),'_anom.png');
pathname = '/home/inne/documents/sideprojects/ecotrons/paper/Copernicus_LaTeX_Package/figures'; 
saveas(figure1,fullfile(pathname, filename{1}))