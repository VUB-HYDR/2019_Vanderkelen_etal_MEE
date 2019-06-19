% -------------------------------------------------------------------------
% script to plot the seasonal cycle and scores for different variables

% initialisation
close all

% for plotting purposes
TAS_seas_month = mf_calc_seascycle(TAS,date_eval,'month')';
TASMIN_seas_month = mf_calc_seascycle(TASMIN,date_eval,'month')';
TASMAX_seas_month = mf_calc_seascycle(TASMAX,date_eval,'month')';
PR_seas_month = mf_calc_seascycle(PR,date_eval,'month')';
SFCWIND_seas_month = mf_calc_seascycle(SFCWIND,date_eval,'month')';
HURS_seas_month = mf_calc_seascycle(HURS,date_eval,'month')';


% of model data
for i = 1:nm
    
   % for plotting purposes
   tas_seas_month(:,i)  = mf_calc_seascycle(tas(:,i),date_eval,'month');
   tasmin_seas_month(:,i)  = mf_calc_seascycle(tasmin(:,i),date_eval,'month');
   tasmax_seas_month(:,i)  = mf_calc_seascycle(tasmax(:,i),date_eval,'month');
   pr_seas_month(:,i)  = mf_calc_seascycle(pr(:,i),date_eval,'month');
   rh_seas_month(:,i)  = mf_calc_seascycle(rh(:,i),date_eval,'month');
   sfcWind_seas_month(:,i)  = mf_calc_seascycle(sfcWind(:,i),date_eval,'month'); 

end

rh_seas_month(find(rh_seas_month==0))=NaN; 
sfcWind_seas_month(find(sfcWind_seas_month==0))=NaN; 
tasmin_seas_month(find(tasmin_seas_month==0))=NaN; 
tasmax_seas_month(find(tasmax_seas_month==0))=NaN; 

figure('rend','painters','pos',[10 10 900 600]);
ax = mf_subtightplot(2,2,1,[0.1,0.1],[0.05,0.05],[0.08,0.15])
mf_plot_seascycle(tas_seas_month,TAS_seas_month,'Mean temperature ', nm, RCM, 'month', 'Temperature (K)','eval',0,'south')

ax = mf_subtightplot(2,2,2,[0.1,0.1],[0.05,0.05],[0.08,0.18] )
mf_plot_seascycle(pr_seas_month ,PR_seas_month,'Precipitation',nm,  RCM, 'month', 'Precipiation (mm/day)','eval',0,'northeastoutside')

ax = mf_subtightplot(2,2,3,[0.1,0.1],[0.05,0.05],[0.08,0.15])
mf_plot_seascycle(rh_seas_month,HURS_seas_month,'Relative humidity', nm, RCM, 'month', 'Relative humidity (%)','eval',0,'southeast')
ylim([60 95])

ax = mf_subtightplot(2,2,4,[0.1,0.1],[0.05,0.05],[0.08,0.18])
mf_plot_seascycle(sfcWind_seas_month,SFCWIND_seas_month,'Mean Surface Wind', nm, RCM, 'month', 'Wind (mm/s)','eval',1,'northeast')
ylim([2 7])


%%
figure()
subplot(1,2,1)
mf_plot_seascycle(tasmin_seas_month,TASMIN_seas_month,'Minimum daily temperature', nm, RCM, 'month', 'Temperature (K)','eval',1,'south')
ylim([272 290])

subplot(1,2,2)
mf_plot_seascycle(tasmax_seas_month,TASMAX_seas_month,'Maximum daily temperature', nm, RCM, 'month', 'Temperature (K)','eval',0,'northeast')


%% plot scores seasonal cycles

figure()
subplot(3,2,1)
bar(tas_ampl_diff)
title('Annual temperature range bias')
ylabel('mean temperature (k)')
set(gca,'XTick',[1:9],'XtickLabel',RCM,'XTickLabelRotation',45)
ylim([-2.5 2.5])

grid on


subplot(3,2,2)
rh_ampl_diff_cut = [rh_ampl_diff(1:2) rh_ampl_diff(4:7) rh_ampl_diff(9)]; 
bar(rh_ampl_diff_cut)
title('Annual relative humidity range bias')
ylabel('RH (%)')
set(gca,'XTick',[1:length(RCM_rh)],'XtickLabel',RCM_rh,'XTickLabelRotation',45)
ylim([-15 15])
grid on


subplot(3,2,3)
bar(pr_ampl_diff)
title('Annual precipitation range bias')
ylabel('precipitation (mm/day)')
set(gca,'XTick',[1:9],'XtickLabel',RCM,'XTickLabelRotation',45)
ylim([-3 3])
grid on

subplot(3,2,4)
sfcWind_ampl_diff_cut = [sfcWind_ampl_diff(1:7) sfcWind_ampl_diff(9)]; 
bar(sfcWind_ampl_diff_cut)
title('Annual mean surface wind range bias')
ylabel('mean wind (m/s)')
set(gca,'XTick',[1:length(RCM_adj)],'XtickLabel',RCM_adj,'XTickLabelRotation',45)
ylim([-2 2])
grid on

subplot(3,2,5)
bar(dtr_mdiff_cut)
title('Diurnal temperature range mean bias ')
ylabel('temperature (k)')
set(gca,'XTick',[1:7],'XtickLabel',RCM_rh,'XTickLabelRotation',45)
grid on
ylim([-2.5 2.5])

