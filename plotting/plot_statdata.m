% ------------------------------------------------------------------------
% Script to make seas cycle plots of different obs stations




% choose ref station
% possibilities: Maastricht (MS), Heinsberg-Schleiden (HS), Aachen (AA)
% variables
PR_name           = 'RR'; % mm  daily precipitation
TAS_name          = 'TG'; % °C  daily mean    temperature
TASMIN_name       = 'TN'; % °C  daily minimum temperature
TASMAX_name       = 'TX'; % °C  daily maximum temperature
PSL_name          = 'PP'; % hPa pressure at sea level
HURS_name         = 'HU'; % %   relative humidity
SFCWIND_name      = 'FG'; % m/s mean wind speed
SFCWINDMAX_name   = 'FX'; % m/s speed wind gust

% variables provided by station but not yet included: 
% DD: wind direction in degrees
% CC: cloud cover on oktas
% SS: hours of daily sunshine


    
    % define station: Maastricht
    stat_name_ms  = '_STAID000168.txt'; 
 
 % define date CORDEX eval
time_begin_eval = [1989 01 01 0  0 0]; 
time_end_eval   = [2008 12 31 23 0 0]; 
date_vec_eval   = datevec(datenum(time_begin_eval):1:datenum(time_end_eval)); 
date_eval       = date_vec_eval(:,1:3);    
    
    % define observational timebounds
    % Maastricht
    time_begin_obs = [1906 01 01 0  0 0]; 
    time_end_obs   = [2018 03 31 23 0 0]; 
    date_vec_obs_ms    = datevec(datenum(time_begin_obs):1:datenum(time_end_obs)); 
    date_obs_ms        = date_vec_obs_ms(:,1:3); 
    
    time_begin_obs_pr = [1900 12 01 0  0 0]; 
    date_vec_obs_pr   = datevec(datenum(time_begin_obs_pr):1:datenum(time_end_obs)); 
    date_obs_pr       = date_vec_obs_pr(:,1:3); 
    
% read in data files per variable

    [date_or, PRo_ms        ] = mf_read(stat_name_ms , PR_name); 
    [date_or, TASo_ms       ] = mf_read(stat_name_ms , TAS_name); 
    [ ~     , TASMINo_ms    ] = mf_read(stat_name_ms , TASMIN_name); 
    [ ~     , TASMAXo_ms    ] = mf_read(stat_name_ms , TASMAX_name); 
    [ ~     , PSLo_ms       ] = mf_read(stat_name_ms , PSL_name); 
    [ ~     , HURSo_ms      ] = mf_read(stat_name_ms , HURS_name); 
    [ ~     , SFCWINDo_ms   ] = mf_read(stat_name_ms , SFCWIND_name); 
    [ ~     , SFCWINDMAXo_ms] = mf_read(stat_name_ms , SFCWINDMAX_name); 

    PR_ms         = mf_extract_period(PRo_ms, date_obs_pr, date_eval); 
    TAS_ms         = mf_extract_period(TASo_ms, date_obs_ms , date_eval); 
    TASMIN_ms      = mf_extract_period(TASMINo_ms, date_obs_ms , date_eval); 
    TASMAX_ms     = mf_extract_period(TASMAXo_ms, date_obs_ms , date_eval); 
    PSL_ms         = mf_extract_period(PSLo_ms, date_obs_ms , date_eval); 
    HURS_ms        = mf_extract_period(HURSo_ms, date_obs_ms , date_eval); 
    SFCWIND_ms     = mf_extract_period(SFCWINDo_ms, date_obs_ms , date_eval); 
    SFCWINDMAX_ms  = mf_extract_period(SFCWINDMAXo_ms, date_obs_ms , date_eval); 

    % convert temperatures from °C to Kelvin
    TAS_ms     = TAS_ms     + 273.15; 
    TASMIN_ms  = TASMIN_ms  + 273.15; 
    TASMAX_ms  = TASMAX_ms  + 273.15;
    HURS_ms    = HURS_ms  *10; 
    
% -----------------------------------------------------------------------    
    
    % define station: Heinsberg-Schleiden
    stat_name_hs = '_STAID004207.txt'; 
    
    
    % define observational timebounds
    time_begin_obs = [1963 01 01 0  0 0]; 
    time_end_obs   = [2018 03 31 23 0 0]; 
    date_vec_obs_hs   = datevec(datenum(time_begin_obs):1:datenum(time_end_obs)); 
    date_obs_hs       = date_vec_obs_hs(:,1:3); 
    
% read in data files per variable

    [date_or, PRo_hs        ] = mf_read(stat_name_hs, PR_name); 
    [ ~     , TASo_hs       ] = mf_read(stat_name_hs, TAS_name); 
    [ ~     , TASMINo_hs    ] = mf_read(stat_name_hs, TASMIN_name); 
    [ ~     , TASMAXo_hs    ] = mf_read(stat_name_hs, TASMAX_name); 
    [ ~     , HURSo_hs      ] = mf_read(stat_name_hs, HURS_name); 

    PR_hs         = mf_extract_period(PRo_hs, date_obs_hs, date_eval); 
    TAS_hs        = mf_extract_period(TASo_hs, date_obs_hs, date_eval); 
    TASMIN_hs     = mf_extract_period(TASMINo_hs, date_obs_hs, date_eval); 
    TASMAX_hs     = mf_extract_period(TASMAXo_hs, date_obs_hs, date_eval); 
    HURS_hs       = mf_extract_period(HURSo_hs, date_obs_hs, date_eval); 
 
    % convert temperatures from °C to Kelvin
    TAS_hs    = TAS_hs    + 273.15; 
    TASMIN_hs = TASMIN_hs + 273.15; 
    TASMAX_hs = TASMAX_hs + 273.15;
    HURS_hs   = HURS_hs *10; 


 % -----------------------------------------------------------------------    
    
    % define station: Aachen
    stat_name_aa = '_STAID000356.txt'; 
    
    % lat en lon of station in Aachen
    lat_st = 50.78;
    lon_st =  6.10;
    
    % define observational timebounds
    % Maastricht
    time_begin_obs = [1891 01 01 0  0 0]; 
    time_end_obs   = [2018 03 31 23 0 0]; 
    date_vec_obs_aa   = datevec(datenum(time_begin_obs):1:datenum(time_end_obs)); 
    date_obs_aa       = date_vec_obs_aa(:,1:3); 
    
% read in data files per variable

    [date_or, PRo_aa        ] = mf_read(stat_name_aa, PR_name); 
    [ ~     , TASo_aa       ] = mf_read(stat_name_aa, TAS_name); 
    [ ~     , TASMINo_aa    ] = mf_read(stat_name_aa, TASMIN_name); 
    [ ~     , TASMAXo_aa    ] = mf_read(stat_name_aa, TASMAX_name); 
    [ ~     , HURSo_aa      ] = mf_read(stat_name_aa, HURS_name); 
    [ ~     , SFCWINDo_aa   ] = mf_read(stat_name_aa, SFCWIND_name); 
    [ ~     , SFCWINDMAXo_aa] = mf_read(stat_name_aa, SFCWINDMAX_name); 

    PR_aa         = mf_extract_period(PRo_aa, date_obs_aa, date_eval); 
    TAS_aa        = mf_extract_period(TASo_aa, date_obs_aa, date_eval); 
    TASMIN_aa     = mf_extract_period(TASMINo_aa, date_obs_aa, date_eval); 
    TASMAX_aa     = mf_extract_period(TASMAXo_aa, date_obs_aa, date_eval); 
    HURS_aa      = mf_extract_period(HURSo_aa, date_obs_aa, date_eval); 
    SFCWIND_aa    = mf_extract_period(SFCWINDo_aa, date_obs_aa, date_eval); 
    SFCWINDMAX_aa = mf_extract_period(SFCWINDMAXo_aa, date_obs_aa, date_eval); 

    % convert temperatures from °C to Kelvin
    TAS_aa    = TAS_aa    + 273.15; 
    TASMIN_aa = TASMIN_aa + 273.15; 
    TASMAX_aa = TASMAX_aa + 273.15;     
    HURS_aa   = HURS_aa *10;        


%% calculate seasonal cycles for different stations

% maastricht
TAS_seas_month_ms = mf_calc_seascycle(TAS_ms,date_eval,'month')';
TASMIN_seas_month_ms = mf_calc_seascycle(TASMIN_ms,date_eval,'month')';
TASMAX_seas_month_ms = mf_calc_seascycle(TASMAX_ms,date_eval,'month')';
PR_seas_month_ms = mf_calc_seascycle(PR_ms,date_eval,'month')';
SFCWIND_seas_month_ms = mf_calc_seascycle(SFCWIND_ms,date_eval,'month')';
HURS_seas_month_ms = mf_calc_seascycle(HURS_ms,date_eval,'month')';

% aachen
TAS_seas_month_aa = mf_calc_seascycle(TAS_aa,date_eval,'month')';
TASMIN_seas_month_aa = mf_calc_seascycle(TASMIN_aa,date_eval,'month')';
TASMAX_seas_month_aa = mf_calc_seascycle(TASMAX_aa,date_eval,'month')';
PR_seas_month_aa = mf_calc_seascycle(PR_aa,date_eval,'month')';
SFCWIND_seas_month_aa = mf_calc_seascycle(SFCWIND_aa,date_eval,'month')';
HURS_seas_month_aa = mf_calc_seascycle(HURS_aa,date_eval,'month')';

% heidelberg
TAS_seas_month_hs = mf_calc_seascycle(TAS_hs,date_eval,'month')';
TASMIN_seas_month_hs = mf_calc_seascycle(TASMIN_hs,date_eval,'month')';
TASMAX_seas_month_hs = mf_calc_seascycle(TASMAX_hs,date_eval,'month')';
PR_seas_month_hs = mf_calc_seascycle(PR_hs,date_eval,'month')';
HURS_seas_month_hs = mf_calc_seascycle(HURS_hs,date_eval,'month')';


%% plot
figure('rend','painters','pos',[10 10 900 600]);
ax = mf_subtightplot(2,2,1,[0.1,0.1],[0.05,0.05],[0.08,0.08])
mf_plot_seascycle_stdata(TAS_seas_month_ms-273.16,TAS_seas_month_aa-273.16,TAS_seas_month_hs-273.16,' ','month','Air Temperature (^\circC)',0)

ax = mf_subtightplot(2,2,2,[0.1,0.1],[0.05,0.05],[0.08,0.08] )
mf_plot_seascycle_stdata(PR_seas_month_ms,PR_seas_month_aa,PR_seas_month_hs,' ','month','Precipitation (mm/day)',1)
ylim([1 4.5])

ax = mf_subtightplot(2,2,3,[0.1,0.1],[0.05,0.05],[0.08,0.08])
mf_plot_seascycle_stdata(HURS_seas_month_ms,HURS_seas_month_aa,HURS_seas_month_hs,' ','month','Relative Humidity (%)',0)
ylim([60 95])

ax = mf_subtightplot(2,2,4,[0.1,0.1],[0.05,0.05],[0.08,0.08])
mf_plot_seascycle_stdata(SFCWIND_seas_month_ms,SFCWIND_seas_month_aa,0,' ','month','Surface Wind (m/s)',0)
ylim([1 7])

% save figure
filename = strcat('stat_data');
pathname = 'C:\Users\ivand\Documents\ecotrons\scripts\matlab\plots\paper\'; 
print(fullfile(pathname, filename),'-djpeg','-r1000')