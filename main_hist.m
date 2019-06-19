% ------------------------------------------------------------------------
% Main script to read and calculate scores for the EUR-11 cordex models
% for the historical run


% clean up
clearvars -except flags
ms_inicon

% add matlab scripts to directory path
addpath(genpath('/home/inne/documents/sideprojects/ecotrons')); 


% initialisation
run = 'hist'; 

RCM(:,1) = [{'CCLM4-8-17'};  {'ALADIN53'};  {'RegCM4-2'};  {'HIRHAM5'}; ...
    {'WRF331F'};  {'RACMO22E'};  {'REMO2009'};  {'ALARO-0'};  {'RCA4'} ];

GCM(:,1) = [{'CNRM-CERFACS-CNRM-CM5'}; {'ICHEC-EC-EARTH'}; {'MOHC-HadGEM2-ES'};...
    {'MPI-M-MPI-ESM-LR'}; {'NCC-NorESM1-M'}; {'IPSL-IPSL-CM5A-MR'}];


RCM_all(:,1) = [{'CCLM4-8-17'};  {'CCLM4-8-17'}; {'CCLM4-8-17'}; {'CCLM4-8-17'}; ...
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



GCM_all(:,1) = [{'CNRM-CERFACS-CNRM-CM5'}; {'ICHEC-EC-EARTH'}; {'MOHC-HadGEM2-ES'}; {'MPI-M-MPI-ESM-LR'};...
{'CNRM-CERFACS-CNRM-CM5'};...
{'ICHEC-EC-EARTH'}       ;{'MOHC-HadGEM2-ES'}; {'NCC-NorESM1-M'}   ; ...
{'IPSL-IPSL-CM5A-MR'}    ;
{'ICHEC-EC-EARTH'}       ;{'MOHC-HadGEM2-ES'};
{'MPI-M-MPI-ESM-LR'}     ;
{'CNRM-CERFACS-CNRM-CM5'}; 
{'CNRM-CERFACS-CNRM-CM5'};{'ICHEC-EC-EARTH'}; {'IPSL-IPSL-CM5A-MR'}; {'MOHC-HadGEM2-ES'};{'MPI-M-MPI-ESM-LR'}];

nm = length(RCM_all); 


% define date CORDEX hist
time_begin_hist = [1970 01 01 0  0 0]; 
time_end_hist   = [2005 12 31 23 0 0]; 
date_vec_hist  = datevec(datenum(time_begin_hist):1:datenum(time_end_hist)); 
date_hist      = date_vec_hist(:,1:3); 


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


pr         = mf_get_var(pr_name  ,      RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
tas        = mf_get_var(tas_name ,      RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
tasmin     = mf_get_var(tasmin_name ,   RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
tasmax     = mf_get_var(tasmax_name ,   RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
%psl        = mf_get_var(psl_name ,      RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
hurs       = mf_get_var(hurs_name,      RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
huss       = mf_get_var(huss_name,      RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
ps         = mf_get_var(ps_name  ,      RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
%rsds       = mf_get_var(rsds_name,      RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
%rlds       = mf_get_var(rlds_name,      RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
%uas        = mf_get_var(uas_name,       RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
%vas        = mf_get_var(vas_name,       RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
sfcWind    = mf_get_var(sfcWind_name,   RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 
%sfcWindmax = mf_get_var(sfcWindmax_name,RCM_all,GCM_all,institute_all, lat_st, lon_st, date_hist,'hist'); 

% correct unit ps from hPa to Pa
ps(:,5) = ps(:,5)*100; 
ps(find(ps==0)) = mean(mean(ps(find(ps>0)))); 
tas(find(tas==0)) = mean(mean(tas(find(tas>0)))); 
huss(find(huss==0)) = mean(mean(huss(find(huss>0)))); 

pr      = pr*3600*24; % convert from  kg/m²s to mm


 % Fill in missing 
% calc hurs for models not avalaible(CCLM,WRF, REMO2009) not possible for ALARO 

rh= mf_calc_hurs(huss,tas,ps);  
rh(:,13) = NaN; 
sfcWind(:,13) = NaN; % ALARO
tasmax(:,13) = NaN;  % ALARO
tasmin(:,13) = NaN;  % ALARO

% 
% % calc abs error on RH calculation
%
diff = [mean(abs(hurs(:,5)-rh(:,5))) mean(abs(hurs(:,7:11)-rh(:,7:11)))...
    mean(abs(hurs(:,14:18)-rh(:,14:18)))]; 
rh_diff = mean(diff); 

% calc sfcWind for ALADIN (columns 2)
 
sfcWind(:,5) = NaN; 

[x,y] = find(tasmax==0); 
for i = 1:length(x)
    
tasmax(x(i),y(i))=(tasmax(x(i)+2,y(i))+tasmax(x(i)-2,y(i)))/2;
tasmin(x(i),y(i))=(tasmin(x(i)+2,y(i))+tasmin(x(i)-2,y(i)))/2;    

end


% RCM array without ALARO from UGent (not present in min and max temp)
RCM_adj(:,1) = [{'CCLM4-8-17'};  {'CCLM4-8-17'}; {'CCLM4-8-17'}; {'CCLM4-8-17'}; ...
{'ALADIN53'};...
{'HIRHAM5'} ; {'HIRHAM5'} ; {'HIRHAM5'} ; ...
{'WRF331F'} ;
{'RACMO22E'}; {'RACMO22E'};...
{'REMO2009'};...
{'RCA4'}    ;{'RCA4'}     ;{'RCA4'}     ;{'RCA4'} ; {'RCA4'} ];
    
institute_adj (:,1) = [{'CLMcom'};{'CLMcom'};{'CLMcom'};{'CLMcom'};...
    {'CNRM'};...
    {'DMI'};{'DMI'};{'DMI'};...
    {'IPSL-INERIS'};...
    {'KNMI'}; {'KNMI'}; ...
    {'MPI-CSC'}; 
    {'SMHI'}; {'SMHI'}; {'SMHI'}; {'SMHI'}; {'SMHI'}];



GCM_adj(:,1) = [{'CNRM-CERFACS-CNRM-CM5'}; {'ICHEC-EC-EARTH'}; {'MOHC-HadGEM2-ES'}; {'MPI-M-MPI-ESM-LR'};...
{'CNRM-CERFACS-CNRM-CM5'};...
{'ICHEC-EC-EARTH'}       ;{'MOHC-HadGEM2-ES'}; {'NCC-NorESM1-M'}   ; ...
{'IPSL-IPSL-CM5A-MR'}    ;
{'ICHEC-EC-EARTH'}       ;{'MOHC-HadGEM2-ES'};
{'MPI-M-MPI-ESM-LR'}     ;
{'CNRM-CERFACS-CNRM-CM5'};{'ICHEC-EC-EARTH'}; {'IPSL-IPSL-CM5A-MR'}; {'MOHC-HadGEM2-ES'};{'MPI-M-MPI-ESM-LR'}];


% for plotting purposes

RCM_text(:,1) = [{'CCLM4-8-17 '};  {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; ...
{'ALADIN53 '};...
{'HIRHAM5 '} ; {'HIRHAM5 '} ; {'HIRHAM5 '} ; ...
{'WRF331F '} ;
{'RACMO22E '}; {'RACMO22E '};...
{'REMO2009 '};...
{'ALARO-0 '} ;...
{'RCA4 '}    ;{'RCA4 '}     ;{'RCA4 '}     ;{'RCA4 '} ; {'RCA4 '} ];

RCM_adjtext(:,1) = [{'CCLM4-8-17 '};  {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; {'CCLM4-8-17 '}; ...
{'ALADIN53 '};...
{'HIRHAM5 '} ; {'HIRHAM5 '} ; {'HIRHAM5 '} ; ...
{'WRF331F '} ;
{'RACMO22E '}; {'RACMO22E '};...
{'REMO2009 '};...
{'RCA4 '}    ;{'RCA4 '}     ;{'RCA4 '}     ;{'RCA4 '} ; {'RCA4 '} ];


GCM_text(:,1) = [{'CNRM-CM5'}; {'EC-EARTH'}; {'HadGEM2-ES'}; {'MPI-ESM-LR'};...
{'CNRM-CM5'};...
{'EC-EARTH'}       ;{'HadGEM2-ES'}; {'NorESM1-M'}   ; ...
{'CM5A-MR'}    ;
{'EC-EARTH'}       ;{'HadGEM2-ES'};
{'MPI-ESM-LR'}     ;
{'CNRM-CM5'}; 
{'CNRM-CM5'};{'EC-EARTH'}; {'CM5A-MR'}; {'HadGEM2-ES'};{'MPI-ESM-LR'}];


GCM_adjtext(:,1) = [{'CNRM-CM5'}; {'EC-EARTH'}; {'HadGEM2-ES'}; {'MPI-ESM-LR'};...
{'CNRM-CM5'};...
{'EC-EARTH'}       ;{'HadGEM2-ES'}; {'NorESM1-M'}   ; ...
{'CM5A-MR'}        ;
{'EC-EARTH'}       ;{'HadGEM2-ES'};
{'MPI-M-MPI-ESM-LR'}     ;
{'CNRM-CM5'};{'EC-EARTH'}; {'CM5A-MR'}; {'HadGEM2-ES'};{'MPI-ESM-LR'}];



% calculate the scores
calc_scores_hist;
calc_corr_hist; 
calc_seas_cycle_hist; 
calc_absdiff_hist; 
