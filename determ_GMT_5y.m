% -----------------------------------------------------------------------
% Script to read and manipulate MPI-ESM-LR fieldmean timeseries. 

 % define file name
%filename = 'tas_ann_MPI-ESM-LR_rcp85_r1i1p1_fldmean.nc'; 
filename = 'tas_ann_EC-EARTH_rcp85_r1i1p1_fldmean.nc'; 

Tmean_temp = ncread(filename,'tas'); 

for i = 1:length(Tmean_temp)
Tmean(i) = Tmean_temp(:,:,i); 
end

% define date CORDEX eval
years_GCM      = 1870:2100; 

% determining the reference period
% 1896 - 1905
% 1870 - 1879
% 2011 - 2020 (weird choice)
low_bound = 1951; 
up_bound = 1955; 

T_ref = mean(Tmean(find(years_GCM>=low_bound & years_GCM<=up_bound))); 
period_line = nan(length(Tmean),1); 
period_line(find(years_GCM>=low_bound & years_GCM<=up_bound)) = 0; 

T_anom = Tmean - T_ref; 
T_anom_30ym = movmean(T_anom,30);

%T_anom_2018 = T_anom(find( years_mpi == 2018))
%T_anom_2000 = T_anom(find( years_mpi == 2000))


period_pi = low_bound:1:up_bound; 
period_05 = mf_GMTperiod(T_anom_30ym, years_GCM, 0.5); 
period_1 = mf_GMTperiod(T_anom_30ym, years_GCM, 1); 
period_15 = mf_GMTperiod(T_anom_30ym, years_GCM, 1.5);
period_2 = mf_GMTperiod(T_anom_30ym, years_GCM, 2);
period_25 = mf_GMTperiod(T_anom_30ym, years_GCM, 2.5);
period_3 = mf_GMTperiod(T_anom_30ym, years_GCM, 3); 
period_35 = mf_GMTperiod(T_anom_30ym, years_GCM, 3.5); 
period_4 = mf_GMTperiod(T_anom_30ym, years_GCM, 4);
period_45 = mf_GMTperiod(T_anom_30ym, years_GCM, 4.5);

periods = [ 0, min(period_pi),max(period_pi);
            1, min(period_1),max(period_1); 
            1.5,min(period_15),max(period_15);
            2,min(period_2),max(period_2);
            3, min(period_3),max(period_3); 
            4, min(period_4),max(period_4)];
 
 filename = strcat('period_', num2str(low_bound), '-',num2str(up_bound), '_30ymean_5y.dat');
csvwrite(filename,periods)
