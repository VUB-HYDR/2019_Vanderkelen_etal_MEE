% -------------------------------------------------------------------------
% script to plot the seasonal cycle and scores for different variables



% for plotting purposes
TAS_seas_month = mf_calc_seascycle(TAS,date_hist,'month')';
TASMIN_seas_month = mf_calc_seascycle(TASMIN,date_hist,'month')';
TASMAX_seas_month = mf_calc_seascycle(TASMAX,date_hist,'month')';
PR_seas_month = mf_calc_seascycle(PR,date_hist,'month')';
SFCWIND_seas_month = mf_calc_seascycle(SFCWIND,date_hist,'month')';
HURS_seas_month = mf_calc_seascycle(HURS,date_hist,'month')';


% of model data
for i = 1:nm
    
   % for plotting purposes
   tas_seas_month(:,i)  = mf_calc_seascycle(tas(:,i),date_hist,'month');
   tasmin_seas_month(:,i)  = mf_calc_seascycle(tasmin(:,i),date_hist,'month');
   tasmax_seas_month(:,i)  = mf_calc_seascycle(tasmax(:,i),date_hist,'month');
   pr_seas_month(:,i)  = mf_calc_seascycle(pr(:,i),date_hist,'month');
   rh_seas_month(:,i)  = mf_calc_seascycle(rh(:,i),date_hist,'month');
   sfcWind_seas_month(:,i)  = mf_calc_seascycle(sfcWind(:,i),date_hist,'month'); 

end
rh_seas_month(find(rh_seas_month==0))=NaN; 
sfcWind_seas_month(find(sfcWind_seas_month==0))=NaN; 
tasmin_seas_month(find(tasmin_seas_month==0))=NaN; 
tasmax_seas_month(find(tasmax_seas_month==0))=NaN; 


figure('rend','painters','pos',[10 10 900 600]);
ax = mf_subtightplot(2,2,1,[0.1,0.1],[0.05,0.05],[0.08,0.25]);
mf_plot_seascycle(tas_seas_month-273.16,TAS_seas_month-273.16,' ', length(RCM_all), strcat(RCM_text,GCM_text), 'month', 'Air Temperature (^{\circ}C)','hist',0,'south')
ax = mf_subtightplot(2,2,2,[0.1,0.1],[0.05,0.05],[0.02,0.27] );
mf_plot_seascycle(pr_seas_month ,PR_seas_month,' ',length(RCM_all),  strcat(RCM_text,GCM_text), 'month', 'Precipitation (mm)','hist',0,'northeastoutside')


ax = mf_subtightplot(2,2,3,[0.1,0.1],[0.05,0.05],[0.08,0.25]);
mf_plot_seascycle(rh_seas_month,HURS_seas_month,'  ', length(RCM_all), strcat(RCM_text,GCM_text), 'month', 'Relative Humidity (%)','hist',0,'southwest')
ax = mf_subtightplot(2,2,4,[0.1,0.1],[0.05,0.05],[0.02,0.27]);
mf_plot_seascycle(sfcWind_seas_month,SFCWIND_seas_month,' ', length(RCM_all), strcat(RCM_text,GCM_text), 'month', 'Surface Wind (m/s)','hist',0,'eastoutside')


% save figure
filename = strcat('seascycle_hist');
pathname = 'C:\Users\ivand\Documents\ecotrons\scripts\matlab\plots\paper'; 
print(fullfile(pathname, filename),'-dtiff','-r1000')


figure()
subplot(1,2,1)
mf_plot_seascycle(tasmin_seas_month,TASMIN_seas_month,'Minimum daily temperature', length(RCM_all), strcat(RCM_text,GCM_text), 'month', 'Temperature (K)','hist',0,'south')
subplot(1,2,2)
mf_plot_seascycle(tasmax_seas_month,TASMAX_seas_month,'Maximum daily temperature',length(RCM_all), strcat(RCM_text,GCM_text), 'month', 'Temperature (K)','hist',1,'eastoutside')

figure()
mf_plot_seascycle(tasmax_seas_month,TASMAX_seas_month,'Maximum daily temperature',length(RCM_all), strcat(RCM_text,GCM_text), 'month', 'Temperature (K)','hist',1,'eastoutside')
filename = strcat('legend');
pathname = 'C:\Users\ivand\Documents\ecotrons\scripts\matlab\plots\paper'; 
print(fullfile(pathname, filename),'-dtiff','-r1000')



