% ------------------------------------------------------------------------
% Script to read in the reference data scripts

if strcmp(run,'eval')
    
    date_2extract = date_eval; 
    
elseif strcmp(run, 'hist')
    
     date_2extract = date_hist; 
     
end

% choose ref station
% possibilities: Maastricht, De Bilt, Ukkel, Heinsberg-Schleiden, Aachen
station = 'Maastricht';

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


if strcmp(station, 'Maastricht')==1
    
    % define station: Maastricht
    stat_name = '_STAID000168.txt'; 
    
    % lat en lon of station in Maastricht
    lat_st = 50.9053;
    lon_st =  5.7617;
    
    % define observational timebounds
    % Maastricht
    time_begin_obs = [1906 01 01 0  0 0]; 
    time_end_obs   = [2018 03 31 23 0 0]; 
    date_vec_obs   = datevec(datenum(time_begin_obs):1:datenum(time_end_obs)); 
    date_obs       = date_vec_obs(:,1:3); 
    
    time_begin_obs_pr = [1900 12 01 0  0 0]; 
    date_vec_obs_pr   = datevec(datenum(time_begin_obs_pr):1:datenum(time_end_obs)); 
    date_obs_pr       = date_vec_obs_pr(:,1:3); 
    
% read in data files per variable

    [date_or, PRo        ] = mf_read(stat_name, PR_name); 
    [date_or, TASo       ] = mf_read(stat_name, TAS_name); 
    [ ~     , TASMINo    ] = mf_read(stat_name, TASMIN_name); 
    [ ~     , TASMAXo    ] = mf_read(stat_name, TASMAX_name); 
    [ ~     , PSLo       ] = mf_read(stat_name, PSL_name); 
    [ ~     , HURSo      ] = mf_read(stat_name, HURS_name); 
    [ ~     , SFCWINDo   ] = mf_read(stat_name, SFCWIND_name); 
    [ ~     , SFCWINDMAXo] = mf_read(stat_name, SFCWINDMAX_name); 

    PR         = mf_extract_period(PRo, date_obs_pr, date_2extract); 
    TAS        = mf_extract_period(TASo, date_obs, date_2extract); 
    TASMIN     = mf_extract_period(TASMINo, date_obs, date_2extract); 
    TASMAX     = mf_extract_period(TASMAXo, date_obs, date_2extract); 
    PSL        = mf_extract_period(PSLo, date_obs, date_2extract); 
    HURS       = mf_extract_period(HURSo, date_obs, date_2extract); 
    SFCWIND    = mf_extract_period(SFCWINDo, date_obs, date_2extract); 
    SFCWINDMAX = mf_extract_period(SFCWINDMAXo, date_obs, date_2extract); 

    % convert temperatures from °C to Kelvin
    TAS    = TAS    + 273.15; 
    TASMIN = TASMIN + 273.15; 
    TASMAX = TASMAX + 273.15;
    HURS   = HURS *10; 
    
% -----------------------------------------------------------------------    
elseif strcmp(station, 'Heinsberg-Schleiden')==1
    
    % define station: Maastricht
    stat_name = '_STAID004207.txt'; 
    
    % lat en lon of station 
    lat_st = 51.0425;
    lon_st =  6.10472;
    
    % define observational timebounds
    time_begin_obs = [1963 01 01 0  0 0]; 
    time_end_obs   = [2018 03 31 23 0 0]; 
    date_vec_obs   = datevec(datenum(time_begin_obs):1:datenum(time_end_obs)); 
    date_obs       = date_vec_obs(:,1:3); 
    
% read in data files per variable

    [date_or, PRo        ] = mf_read(stat_name, PR_name); 
    [ ~     , TASo       ] = mf_read(stat_name, TAS_name); 
    [ ~     , TASMINo    ] = mf_read(stat_name, TASMIN_name); 
    [ ~     , TASMAXo    ] = mf_read(stat_name, TASMAX_name); 
    [ ~     , HURSo      ] = mf_read(stat_name, HURS_name); 

    PR         = mf_extract_period(PRo, date_obs, date_2extract); 
    TAS        = mf_extract_period(TASo, date_obs, date_2extract); 
    TASMIN     = mf_extract_period(TASMINo, date_obs, date_2extract); 
    TASMAX     = mf_extract_period(TASMAXo, date_obs, date_2extract); 
    HURS       = mf_extract_period(HURSo, date_obs, date_2extract); 
    SFCWIND    = mf_extract_period(SFCWINDo, date_obs, date_2extract); 
    SFCWINDMAX = mf_extract_period(SFCWINDMAXo, date_obs, date_2extract);  

    % convert temperatures from °C to Kelvin
    TAS    = TAS    + 273.15; 
    TASMIN = TASMIN + 273.15; 
    TASMAX = TASMAX + 273.15;
    HURS   = HURS *10; 


 % -----------------------------------------------------------------------    
elseif strcmp(station, 'Aachen')==1
    
    % define station: 
    stat_name = '_STAID000356.txt'; 
    
    % lat en lon of station in Aachen
    lat_st = 50.78;
    lon_st =  6.10;
    
    % define observational timebounds
    % Maastricht
    time_begin_obs = [1891 01 01 0  0 0]; 
    time_end_obs   = [2018 03 31 23 0 0]; 
    date_vec_obs   = datevec(datenum(time_begin_obs):1:datenum(time_end_obs)); 
    date_obs       = date_vec_obs(:,1:3); 
    
% read in data files per variable

    [date_or, PRo        ] = mf_read(stat_name, PR_name); 
    [ ~     , TASo       ] = mf_read(stat_name, TAS_name); 
    [ ~     , TASMINo    ] = mf_read(stat_name, TASMIN_name); 
    [ ~     , TASMAXo    ] = mf_read(stat_name, TASMAX_name); 
    [ ~     , HURSo      ] = mf_read(stat_name, HURS_name); 
    [ ~     , SFCWINDo   ] = mf_read(stat_name, SFCWIND_name); 
    [ ~     , SFCWINDMAXo] = mf_read(stat_name, SFCWINDMAX_name); 

    PR         = mf_extract_period(PRo, date_obs, date_2extract); 
    TAS        = mf_extract_period(TASo, date_obs, date_2extract); 
    TASMIN     = mf_extract_period(TASMINo, date_obs, date_2extract); 
    TASMAX     = mf_extract_period(TASMAXo, date_obs, date_2extract); 
    HURS       = mf_extract_period(HURSo, date_obs, date_2extract); 
    SFCWIND    = mf_extract_period(SFCWINDo, date_obs, date_2extract); 
    SFCWINDMAX = mf_extract_period(SFCWINDMAXo, date_obs, date_2extract); 

    % convert temperatures from °C to Kelvin
    TAS    = TAS    + 273.15; 
    TASMIN = TASMIN + 273.15; 
    TASMAX = TASMAX + 273.15;     
    HURS   = HURS *10; 

       
% -----------------------------------------------------------------------       
elseif strcmp(station,'De Bilt')==1
    
    
        % define station: Maastricht
    stat_name = '_STAID000162.txt'; 
    
    % define observational timebounds
    % Maastricht
    time_begin_obs = [1901 12 01 0  0 0]; 
    time_end_obs   = [2018 03 31 23 0 0]; 
    date_vec_obs   = datevec(datenum(time_begin_obs):1:datenum(time_end_obs)); 
    date_obs       = date_vec_obs(:,1:3); 
    
% read in data files per variable

    [date_or, PRo        ] = mf_read(stat_name, PR_name); 
    [ ~     , TASo       ] = mf_read(stat_name, TAS_name); 
    [ ~     , TASMINo    ] = mf_read(stat_name, TASMIN_name); 
    [ ~     , TASMAXo    ] = mf_read(stat_name, TASMAX_name); 
    [ ~     , PSLo       ] = mf_read(stat_name, PSL_name); 
    [ ~     , HURSo      ] = mf_read(stat_name, HURS_name); 
    [ ~     , SFCWINDo   ] = mf_read(stat_name, SFCWIND_name); 
    [ ~     , SFCWINDMAXo] = mf_read(stat_name, SFCWINDMAX_name); 

    PR         = mf_extract_period(PRo, date_obs, date_2extract); 
    TAS        = mf_extract_period(TASo, date_obs, date_2extract); 
    TASMIN     = mf_extract_period(TASMINo, date_obs, date_2extract); 
    TASMAX     = mf_extract_period(TASMAXo, date_obs, date_2extract); 
    PSL        = mf_extract_period(PSLo, date_obs, date_2extract); 
    HURS       = mf_extract_period(HURSo, date_obs, date_2extract); 
    SFCWIND    = mf_extract_period(SFCWINDo, date_obs, date_2extract); 
    SFCWINDMAX = mf_extract_period(SFCWINDMAXo, date_obs, date_2extract); 

    % convert temperatures from °C to Kelvin
    TAS    = TAS    + 273.15; 
    TASMIN = TASMIN + 273.15; 
    TASMAX = TASMAX + 273.15;   
     HURS   = HURS *10; 
   
elseif strcmp(station,'Ukkel')==1
   
    % define station name
    stat_name = '_STAID000017.txt';
   
    % define observational timebounds
    % Ukkel
    time_begin_obs = [1833 1 01 0  0 0]; 
    time_end_obs   = [2018 03 31 23 0 0]; 
    date_vec_obs   = datevec(datenum(time_begin_obs):1:datenum(time_end_obs)); 
    date_obs       = date_vec_obs(:,1:3); 
    
    time_begin_obs_pr = [1880 1 01 0  0 0]; 
    date_vec_obs_pr   = datevec(datenum(time_begin_obs_pr):1:datenum(time_end_obs)); 
    date_obs_pr       = date_vec_obs_pr(:,1:3);

    % read in data files per variable

    [date_or, PRo        ] = mf_read(stat_name, PR_name); 
    [ ~     , TASMINo    ] = mf_read(stat_name, TASMIN_name); 
    [ ~     , TASMAXo    ] = mf_read(stat_name, TASMAX_name); 

    PR         = mf_extract_period(PRo, date_obs_pr, date_2extract); 
    TASMIN     = mf_extract_period(TASMINo, date_obs, date_2extract); 
    TASMAX     = mf_extract_period(TASMAXo, date_obs, date_2extract); 

    % convert temperatures from °C to Kelvin
    TASMIN = TASMIN + 273.15; 
    TASMAX = TASMAX + 273.15;     
    
end








