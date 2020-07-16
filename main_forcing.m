% ------------------------------------------------------------------------
% main script to extract data for the ecotrons


% clean up
clearvars -except flags
close all


% initialisation

ms_inicon

institute(:,1) = [{'CLMcom'}];
RCM(:,1) = {'CCLM4-8-17'};
GCM(:,1) = {'ICHEC-EC-EARTH'};


% lat and lon of ecotron
lat_ecotr = 51.0018;
lon_ecotr = 5.7014;


% define date CORDEX hist, rcp and total
time_begin_hist = [1950 01 01 0  0 0]; 
time_end_hist   = [2005 12 31 23 0 0]; 
date_vec_hist  = datevec(datenum(time_begin_hist):1:datenum(time_end_hist)); 
date_hist      = date_vec_hist(:,1:3); 

time_begin_rcp = [2006 01 01 0  0 0]; 
time_end_rcp   = [2100 12 31 23 0 0]; 
date_vec_rcp  = datevec(datenum(time_begin_rcp):1:datenum(time_end_rcp)); 
date_rcp      = date_vec_rcp(:,1:3); 

date_vec_all  = datevec(datenum(time_begin_hist):1:datenum(time_end_rcp)); 
date_all      = date_vec_all(:,1:3); 

% CORDEX variables
pr_name           = 'pr';         % kg/m²s  daily precipitation
tas_name          = 'tas';        % °C daily mean temperature
tasmin_name       = 'tasmin';     % °C daily minimum temperature
tasmax_name       = 'tasmax';     % °C daily maximum temperature
huss_name         = 'huss';       % %   relative humidity
sfcWind_name      = 'sfcWind';    % m/s mean wind speed 
psl_name          = 'psl';        % hPa mean sea level pressure


% load variables (hist and rcp)
pr_hist         = mf_get_var(pr_name  ,   RCM,GCM,institute, lat_ecotr, lon_ecotr, date_hist,'hist'); 
tas_hist        = mf_get_var(tas_name ,   RCM,GCM,institute, lat_ecotr, lon_ecotr, date_hist,'hist'); 
tasmin_hist     = mf_get_var(tasmin_name ,RCM,GCM,institute, lat_ecotr, lon_ecotr, date_hist,'hist'); 
tasmax_hist     = mf_get_var(tasmax_name ,RCM,GCM,institute, lat_ecotr, lon_ecotr, date_hist,'hist'); 
huss_hist       = mf_get_var(huss_name,   RCM,GCM,institute, lat_ecotr, lon_ecotr, date_hist,'hist'); 
sfcWind_hist    = mf_get_var(sfcWind_name,RCM,GCM,institute, lat_ecotr, lon_ecotr, date_hist,'hist'); 
psl_hist        = mf_get_var(psl_name,    RCM,GCM,institute, lat_ecotr, lon_ecotr, date_hist,'hist'); 

pr_rcp          = mf_get_var_rcp(pr_name  ,   institute, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
tas_rcp         = mf_get_var_rcp(tas_name ,   institute, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
tasmin_rcp      = mf_get_var_rcp(tasmin_name ,institute, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85');  
tasmax_rcp      = mf_get_var_rcp(tasmax_name ,institute, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85');  
huss_rcp        = mf_get_var_rcp(huss_name,   institute, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
sfcWind_rcp     = mf_get_var_rcp(sfcWind_name,institute, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
psl_rcp         = mf_get_var_rcp(psl_name,    institute, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 

% concatenate variables
pr      = [pr_hist;      pr_rcp     ];
tas     = [tas_hist;     tas_rcp    ];
tasmin  = [tasmin_hist;  tasmin_rcp ];
tasmax  = [tasmax_hist;  tasmax_rcp ];
huss    = [huss_hist;    huss_rcp   ];
sfcWind = [sfcWind_hist; sfcWind_rcp];
ps      = [psl_hist;     psl_rcp    ]; 


pr      = pr*3600*24; % convert from  kg/m²s to mm
rh      = mf_calc_hurs(huss,tas,ps); 


% determine global mean temperature periods


%determ_GMT_10y; 
%determ_GMT_1y; 
%determ_GMT_2y; 
%determ_GMT_20y; 

determ_GMT_5y; 


% extract ecotron periods

extr_ecotr_perd_5y; 

%extr_ecotr_perd_1y;
%extr_ecotr_perd_2y; 
%extr_ecotr_perd_10y; 
%extr_ecotr_perd_20y; 


% calculate diagnostics
calc_diag_sim



