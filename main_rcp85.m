% ------------------------------------------------------------------------
% Main script to read and calculate scores for the EUR-11 cordex models


%% load simulations for RCP 8.5

% clean up
clearvars -except flags
close all
ms_inicon


RCM(:,1) = [{'CCLM4-8-17'};  {'CCLM4-8-17'}; {'CCLM4-8-17'}; {'CCLM4-8-17'}; ...
{'ALADIN53'};...
{'HIRHAM5'} ; {'HIRHAM5'} ; {'HIRHAM5'} ; ...
{'WRF331F'} ;
{'RACMO22E'}; {'RACMO22E'};...
{'REMO2009'};...
{'ALARO-0'} ;...
{'RCA4'}    ;{'RCA4'}     ;{'RCA4'}     ;{'RCA4'} ; {'RCA4'} ];
    
institute_all (:,1) = [{'CLMcom'};{'CLMcom'};{'CLMcom'};{'CLMcom'};...
    {'CNRM'};...
    {'DMI'};{'DMI'};{'DMI'};...
    {'IPSL-INERIS'};...
    {'KNMI'}; {'KNMI'}; ...
    {'MPI-CSC'}; 
    {'RMIB-UGent'};
    {'SMHI'}; {'SMHI'}; {'SMHI'}; {'SMHI'}; {'SMHI'}];



GCM(:,1) = [{'CNRM-CERFACS-CNRM-CM5'}; {'ICHEC-EC-EARTH'}; {'MOHC-HadGEM2-ES'}; {'MPI-M-MPI-ESM-LR'};...
{'CNRM-CERFACS-CNRM-CM5'};...
{'ICHEC-EC-EARTH'}       ;{'MOHC-HadGEM2-ES'}; {'NCC-NorESM1-M'}   ; ...
{'IPSL-IPSL-CM5A-MR'}    ;
{'ICHEC-EC-EARTH'}       ;{'MOHC-HadGEM2-ES'};
{'MPI-M-MPI-ESM-LR'}     ;
{'CNRM-CERFACS-CNRM-CM5'}; 
{'CNRM-CERFACS-CNRM-CM5'};{'ICHEC-EC-EARTH'}; {'IPSL-IPSL-CM5A-MR'}; {'MOHC-HadGEM2-ES'};{'MPI-M-MPI-ESM-LR'}];


% initialisation
run = 'rcp85'; 

nm = length(RCM); 


% define date CORDEX eval
time_begin_rcp = [2006 01 01 0  0 0]; 
time_end_rcp   = [2100 12 31 23 0 0]; 
date_vec_rcp  = datevec(datenum(time_begin_rcp):1:datenum(time_end_rcp)); 
date_rcp      = date_vec_rcp(:,1:3); 


% lat and lon of ecotron
lat_ecotr = 51.0018;
lon_ecotr = 5.7014;


% CORDEX variables
pr_name           = 'pr';         % kg/m²s  daily precipitation
tas_name          = 'tas';        % °C daily mean temperature
tasmin_name       = 'tasmin';     % °C daily minimum temperature
tasmax_name       = 'tasmax';     % °C daily maximum temperature
psl_name          = 'psl';        % hPa mean sea level pressure
hurs_name         = 'hurs';       % %   relative humidity
sfcWind_name      = 'sfcWind';    % m/s mean wind speed 
sfcWindmax_name   = 'sfcWindmax'; % m/s wind speed of max gust


% variables not measured by station
huss_name         = 'huss'; % hPa  near surface specific humidity
ps_name           = 'ps';   % hPa  surface air pressure                 
rlds_name         = 'rlds'; % W/m2 surface downwelling longwave radiation
rsds_name         = 'rsds'; % W/m2 surface downwelling shortwave radiation
uas_name          = 'uas';  % m/s  Eastward Near-Surface Wind 
vas_name          = 'vas';  % m/s  Northward near surface wind


pr         = mf_get_var_rcp(pr_name  ,   institute_all, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
tas        = mf_get_var_rcp(tas_name ,   institute_all, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
tasmin     = mf_get_var_rcp(tasmin_name ,institute_all, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85');  
tasmax     = mf_get_var_rcp(tasmax_name ,institute_all, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85');  
%hurs       = mf_get_var_rcp(hurs_name,   institute_all, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
huss       = mf_get_var_rcp(huss_name,   institute_all, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
ps         = mf_get_var_rcp(ps_name  ,   institute_all, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
%rsds       = mf_get_var_rcp(rsds_name,   institute_all, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
%rlds       = mf_get_var_rcp(rlds_name,   institute_all, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
%uas        = mf_get_var_rcp(uas_name,    institute_all, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
%vas        = mf_get_var_rcp(vas_name,    institute_all, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
sfcWind     = mf_get_var_rcp(sfcWind_name,institute_all, RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 
%sfcWindmax = mf_get_var_rcp(sfcWindmax_name,institute_all,RCM,GCM, lat_ecotr, lon_ecotr, date_rcp,'rcp85'); 

% correct unit ps from hPa to Pa
ps(:,5) = ps(:,5)*100; 
tas(:,5) = tas(:,5) + 273.15; 
ps(find(ps==0)) = mean(mean(ps(find(ps>0)))); 
tas(find(tas==0)) = mean(mean(tas(find(tas>0)))); 
huss(find(huss==0)) = mean(mean(huss(find(huss>0)))); 

pr      = pr*3600*24; % convert from  kg/m²s to mm

sfcWind(:,5) = NaN; 
sfcWind(:,13) = NaN; 

[x,y] = find(sfcWind==0); 
for i = 1:length(x)
sfcWind(x(i),y(i))=(sfcWind(x(i)+2,y(i))+sfcWind(x(i)-2,y(i)))/2;
sfcWind(x(i),y(i))=(sfcWind(x(i)+2,y(i))+sfcWind(x(i)-2,y(i)))/2;    

end

% Fill in missing 
% calc hurs for models not avalaible(CCLM,WRF, REMO2009) not possible for RegCM4, ALARO 
rh= mf_calc_hurs(huss,tas,ps);  
rh(:,13) = NaN;  
% calc abs error on RH calculation
%rh_diff = (mean(abs(hurs(:,2)-rh(:,2)))+mean(hurs(:,4)-rh(:,4)))+...
 %    mean(abs(hurs(:,6)-rh(:,6)))+mean(abs(hurs(:,9)-rh(:,9)))./4; 

RCM_text(:,1) = [{'CCLM4-8-17 '};  {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; ...
{'ALADIN53 '};...
{'HIRHAM5 '} ; {'HIRHAM5 '} ; {'HIRHAM5 '} ; ...
{'WRF331F '} ;
{'RACMO22E '}; {'RACMO22E '};...
{'REMO2009 '};...
{'ALARO-0 '} ;...
{'RCA4 '}    ;{'RCA4 '}     ;{'RCA4 '}     ;{'RCA4 '} ; {'RCA4 '} ];


GCM_text(:,1) = [{'CNRM-CM5'}; {'EC-EARTH'}; {'HadGEM2-ES'}; {'MPI-ESM-LR'};...
{'CNRM-CM5'};...
{'EC-EARTH'}       ;{'HadGEM2-ES'}; {'NorESM1-M'}   ; ...
{'CM5A-MR'}    ;
{'EC-EARTH'}       ;{'HadGEM2-ES'};
{'MPI-ESM-LR'}     ;
{'CNRM-CM5'}; 
{'CNRM-CM5'};{'EC-EARTH'}; {'CM5A-MR'}; {'HadGEM2-ES'};{'MPI-ESM-LR'}];



%% Load in simulations for historical periods (to be able to calculate anomalies)


time_begin_hist = [1970 01 01 0  0 0]; 
time_end_hist   = [2005 12 31 23 0 0]; 
date_vec_hist  = datevec(datenum(time_begin_hist):1:datenum(time_end_hist)); 
date_hist      = date_vec_hist(:,1:3); 


pr_hist         = mf_get_var(pr_name  ,      RCM,GCM,institute_all, lat_ecotr, lon_ecotr, date_hist,'hist'); 
tas_hist        = mf_get_var(tas_name ,      RCM,GCM,institute_all, lat_ecotr, lon_ecotr, date_hist,'hist'); 
tasmin_hist     = mf_get_var(tasmin_name ,   RCM,GCM,institute_all, lat_ecotr, lon_ecotr, date_hist,'hist'); 
tasmax_hist     = mf_get_var(tasmax_name ,   RCM,GCM,institute_all, lat_ecotr, lon_ecotr, date_hist,'hist'); 
huss_hist       = mf_get_var(huss_name,      RCM,GCM,institute_all, lat_ecotr, lon_ecotr, date_hist,'hist'); 
ps_hist         = mf_get_var(ps_name  ,      RCM,GCM,institute_all, lat_ecotr, lon_ecotr, date_hist,'hist'); 
sfcWind_hist    = mf_get_var(sfcWind_name,   RCM,GCM,institute_all, lat_ecotr, lon_ecotr, date_hist,'hist'); 

% correct unit ps from hPa to Pa
ps_hist(:,5) = ps_hist(:,5)*100; 
ps_hist(find(ps_hist==0)) = mean(mean(ps_hist(find(ps_hist>0)))); 
tas_hist(find(tas_hist==0)) = mean(mean(tas_hist(find(tas_hist>0)))); 
huss(find(huss_hist==0)) = mean(mean(huss_hist(find(huss_hist>0)))); 

pr_hist      = pr_hist*3600*24; % convert from  kg/m²s to mm


% Fill in missing 
% calc hurs for models not avalaible(CCLM,WRF, REMO2009) not possible for ALARO 

rh_hist= mf_calc_hurs(huss_hist,tas_hist,ps_hist);  
rh_hist(:,13) = NaN; 
sfcWind_hist(:,13) = NaN; % ALARO
tasmax_hist(:,13) = NaN;  % ALARO
tasmin_hist(:,13) = NaN;  % ALARO


% calc sfcWind for ALADIN (columns 2)
 
sfcWind_hist(:,5) = NaN; 

[x,y] = find(tasmax_hist==0); 
for i = 1:length(x)
tasmax_hist(x(i),y(i))=(tasmax_hist(x(i)+2,y(i))+tasmax_hist(x(i)-2,y(i)))/2;
tasmin_hist(x(i),y(i))=(tasmin_hist(x(i)+2,y(i))+tasmin_hist(x(i)-2,y(i)))/2;    
end


date_vec_all  = datevec(datenum(time_begin_hist):1:datenum(time_end_rcp)); 
date_all      = date_vec_all(:,1:3); 

