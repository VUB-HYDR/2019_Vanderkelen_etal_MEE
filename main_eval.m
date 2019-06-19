% ------------------------------------------------------------------------
% Main script to read and calculate scores for the EUR-11 cordex models
% for the evaluation run


% clean up
clearvars -except flags
close all
ms_inicon

% add matlab scripts to directory path
addpath(genpath('/home/inne/documents/sideprojects/ecotrons')); 


% initialisation
run = 'eval'; 

institute(:,1) = [{'CLMcom'}; {'CNRM'};  {'DHMZ'};  {'DMI'};  {'IPSL-INERIS'};...
    {'KNMI'};  {'MPI-CSC'};  {'RMIB-UGent'};  {'SMHI'}];

RCM(:,1) = [{'CCLM4-8-17'};  {'ALADIN53'};  {'RegCM4-2'};  {'HIRHAM5'}; ...
    {'WRF331F'};  {'RACMO22E'};  {'REMO2009'};  {'ALARO-0'};  {'RCA4'} ];

nm = length(RCM); 


% define date CORDEX eval
time_begin_eval = [1989 01 01 0  0 0]; 
time_end_eval   = [2008 12 31 23 0 0]; 
date_vec_eval   = datevec(datenum(time_begin_eval):1:datenum(time_end_eval)); 
date_eval       = date_vec_eval(:,1:3); 


% lat and lon of ecotron
lat_ecotr = 51.0018;
lon_ecotr = 5.7014;


% read in refdata
read_refdata; 


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

    [lat lon varR] = mf_ncload(pr_name,institute(1),RCM(1),0,'eval'); 

pr         = mf_get_var_eval(pr_name  ,      RCM,institute, lat_st, lon_st, date_eval,'eval'); 
tas        = mf_get_var_eval(tas_name ,      RCM,institute, lat_st, lon_st, date_eval,'eval'); 
tasmin     = mf_get_var_eval(tasmin_name ,   RCM,institute, lat_st, lon_st, date_eval,'eval'); 
tasmax     = mf_get_var_eval(tasmax_name ,   RCM,institute, lat_st, lon_st, date_eval,'eval'); 
%psl        = mf_get_var_eval(psl_name ,      RCM,institute, lat_st, lon_st, date_eval,'eval'); 
hurs       = mf_get_var_eval(hurs_name,      RCM,institute, lat_st, lon_st, date_eval,'eval');
huss       = mf_get_var_eval(huss_name,      RCM,institute, lat_st, lon_st, date_eval,'eval');
ps         = mf_get_var_eval(ps_name  ,      RCM,institute, lat_st, lon_st, date_eval,'eval');
%rsds       = mf_get_var_eval(rsds_name,      RCM,institute, lat_st, lon_st, date_eval,'eval');
%rlds       = mf_get_var_eval(rlds_name,      RCM,institute, lat_st, lon_st, date_eval,'eval');
%uas        = mf_get_var_eval(uas_name,       RCM,institute, lat_st, lon_st, date_eval,'eval');
%vas        = mf_get_var_eval(vas_name,       RCM,institute, lat_st, lon_st, date_eval,'eval');
sfcWind    = mf_get_var_eval(sfcWind_name,   RCM,institute, lat_st, lon_st, date_eval,'eval');
%sfcWindmax = mf_get_var_eval(sfcWindmax_name,RCM,institute, lat_st, lon_st, date_eval,'eval');

% correct unit ps from hPa to Pa
ps(:,2) = ps(:,2)*100; 
pr      = pr*3600*24; % convert from  kg/m²s to mm


% Fill in missing 
% calc hurs for models not avalaible(CCLM,WRF, REMO2009) not possible for RegCM4, ALARO 
rh= mf_calc_hurs(huss,tas,ps);  

% calc abs error on RH calculation
rh_diff = (mean(abs(hurs(:,2)-rh(:,2)))+mean(hurs(:,4)-rh(:,4)))+...
    mean(abs(hurs(:,6)-rh(:,6)))+mean(abs(hurs(:,9)-rh(:,9)))./4; 

% calc sfcWind for ALADIN (columns 2)

%sfcWind(:,1:7) = sqrt(uas(:,1:7).^2+vas(:,1:7).^2);
%sfcWind(:,2) = NaN;
sfcWind(:,8) = NaN; % ALARO
rh(:,3)= NaN; % RegCM4
rh(:,8)=NaN; % ALARO

% RCM array without ALARO from UGent (not present in min and max temp)
RCM_adj(:,1) = [{'CCLM4-8-17'};  {'ALADIN53'};  {'RegCM4-2'};  {'HIRHAM5'}; ...
    {'WRF331F'};  {'RACMO22E'};  {'REMO2009'};  {'RCA4'} ];

RCM_rh(:,1) = [{'CCLM4-8-17'};  {'ALADIN53'};  {'HIRHAM5'}; ...
    {'WRF331F'};  {'RACMO22E'};  {'REMO2009'};  {'RCA4'} ];


% calculate the scores
calc_scores;
calc_corr; 
calc_seas_cycle; 

