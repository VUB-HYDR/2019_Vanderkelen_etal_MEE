% -----------------------------------------------------------------------
% Script to perform Savitzky-Golay filtering on data to smooth them

% extract more than 5 years (7) to perform smoothing and avoid borders in
% plot

% define time of 7 years
time_begin_7y = [periods(6,2)-1 01 01 0  0 0]; 
time_end_7y   = [periods(6,3)+1 12 31 23 0 0]; 
date_vec_7y = datevec(datenum(time_begin_7y):1:datenum(time_end_7y)); 
date_7y     = date_vec_7y(:,1:3); 

ndays = 2558; % number of days in 7 years if maximum leap years


for i = 1:length(periods)
    extr_years = (periods(i,2)-1:1:periods(i,3)+1)'; 
    
    pr_temp      = mf_extract_prd_eco_leap(pr, date_all(:,1), extr_years,i); 
    tas_temp     = mf_extract_prd_eco_leap(tas, date_all(:,1),extr_years,i);
    tasmin_temp  = mf_extract_prd_eco_leap(tasmin, date_all(:,1),extr_years,i);
    tasmax_temp  = mf_extract_prd_eco_leap(tasmax, date_all(:,1),extr_years,i);
    sfcWind_temp = mf_extract_prd_eco_leap(sfcWind, date_all(:,1),extr_years,i);
    rh_temp      = mf_extract_prd_eco_leap(rh, date_all(:,1),extr_years,i);

% account for leap years

    if length(pr_temp)<ndays

        while length(pr_temp)< ndays
            pr_temp(length(pr_temp)+1) = pr_temp(length(pr_temp)); 
            tas_temp(length(tas_temp)+1) = tas_temp(length(tas_temp)); 
            tasmin_temp(length(tasmin_temp)+1) = tasmin_temp(length(tasmin_temp)); 
            tasmax_temp(length(tasmax_temp)+1) = tasmax_temp(length(tasmax_temp)); 
            sfcWind_temp(length(sfcWind_temp)+1) = sfcWind_temp(length(sfcWind_temp)); 
            rh_temp(length(rh_temp)+1) = rh_temp(length(rh_temp)); 

        end

    end

    pr_extr_l(:,i)      = pr_temp; 
    tas_extr_l(:,i)     = tas_temp;
    tasmin_extr_l(:,i)  = tasmin_temp;
    tasmax_extr_l(:,i)  = tasmax_temp;
    sfcWind_extr_l(:,i) = sfcWind_temp;
    rh_extr_l(:,i)      = rh_temp;
end




% calculate anomalies

tas_anom     = tas_extr_l(:,2:6)     - mean(tas_extr_l(:,1));
pr_anom      = pr_extr_l(:,2:6)      - mean(pr_extr_l(:,1)); 
sfcWind_anom = sfcWind_extr_l(:,2:6) - mean(sfcWind_extr_l(:,1)); 
rh_anom      = rh_extr_l(:,2:6)      - mean(rh_extr_l(:,1)); 
tasmin_anom  = tasmin_extr_l(:,2:6)  - mean(tasmin_extr_l(:,1)); 
tasmax_anom  = tas_extr_l(:,2:6)     - mean(tasmax_extr_l(:,1)); 


frame = 301; 
order = 2; 

tas_smoothed_l     = savitzkyGolayFilt(tas_extr_l  ,order,0,frame);
pr_smoothed_l      = savitzkyGolayFilt(pr_extr_l   ,order,0,frame);
sfcWind_smoothed_l = savitzkyGolayFilt(sfcWind_extr_l,order,0,frame);
rh_smoothed_l      = savitzkyGolayFilt(rh_extr_l    ,order,0,frame);
tasmax_smoothed_l  = savitzkyGolayFilt(tasmax_extr_l,order,0,frame);
tasmin_smoothed_l  = savitzkyGolayFilt(tasmin_extr_l ,order,0,frame);


% extract wanted 5 years out of smoothed data
for i = 1:length(periods)
    
    time_begin_5y = [periods(i,2) 01 01 0  0 0]; 
    time_end_5y   = [periods(i,3) 12 31 23 0 0]; 
    date_vec_5y = datevec(datenum(time_begin_5y):1:datenum(time_end_5y)); 
    date_5y     = date_vec_5y(:,1:3); 
    
    time_begin_7y = [periods(i,2)-1 01 01 0  0 0]; 
    time_end_7y   = [periods(i,3)+1 12 31 23 0 0]; 
    date_vec_7y = datevec(datenum(time_begin_7y):1:datenum(time_end_7y)); 
    date_7y_long     = date_vec_7y(:,1:3); 
    date_7y = date_7y_long; 
    date_7y(length(date_7y)+1,:)=date_7y_long(length(date_7y_long),:); 

    if i == 3
       date_5y([60],:) = []; 
    end
        
    
    tas_smoothed(:,i)     = mf_extract_period(tas_smoothed_l(:,i),    date_7y,date_5y); 
    pr_smoothed(:,i)      = mf_extract_period(pr_smoothed_l(:,i),     date_7y,date_5y); 
    sfcWind_smoothed(:,i) = mf_extract_period(sfcWind_smoothed_l(:,i),date_7y,date_5y); 
    rh_smoothed(:,i)      = mf_extract_period(rh_smoothed_l(:,i),     date_7y,date_5y); 
    tasmax_smoothed(:,i)  = mf_extract_period(tasmax_smoothed_l(:,i), date_7y,date_5y); 
    tasmin_smoothed(:,i)  = mf_extract_period(tasmin_smoothed_l(:,i), date_7y,date_5y); 
end