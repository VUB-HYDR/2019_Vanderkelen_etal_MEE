% -----------------------------------------------------------------------
% Function to load and process CORDEX-EUR variables for station pixel 
% -----------------------------------------------------------------------


function [var] = mf_get_var_eval(var_name, RCM, institute, lat_obs, lon_obs, date, run)


% define ndays
ndays= length(date);


% initialise var variable
var = zeros(ndays,length(RCM)); 


% Loop over model

for i = 1:length(RCM)
   
    
    % load in netcdf file (3D: lat, lon, time)
    
    [lat lon varR] = mf_ncload(var_name,institute(i),RCM(i),0,run); 
    
    % if file doesn't exist
    if lat == 0
        var(:,i) = 0; 
    else
        
        % find station pixel values by smallest difference between lat and lon
        latlondiff = abs(lat-lat_obs) + abs(lon-lon_obs); 
        [indx indy]= find(latlondiff == min(min(latlondiff))); 


        % extract timeseries for pixel from 2D model field
        varT = zeros(length(varR),1); 
        varT(:) = varR(indx,indy,:); 


        % check time consistency

        if length(varT) == ndays 


           var(:,i) = varT;  


        % evaluation simulation has different period    
        else        

            if strcmp(RCM(i),'REMO2009') == 1   % REMO misses 1st january 1989

                var(1,i) = varT(1); 
                var(2:ndays,i) = varT; 


            % cut eval period out of other models    
            else

                % define for every model date vectors
                if strcmp(RCM(i),'ALADIN53') == 1

                time_begin = [1979 01 01 0  0 0]; 
                time_end   = [2008 12 31 23 0 0]; 
                date_vec   = datevec(datenum(time_begin):1:datenum(time_end)); 
                date_model = date_vec(:,1:3);

                elseif  strcmp(RCM(i),'HIRHAM5') == 1

                time_begin = [1989 01 01 0  0 0]; 
                time_end   = [2011 12 31 23 0 0]; 
                date_vec   = datevec(datenum(time_begin):1:datenum(time_end)); 
                date_model = date_vec(:,1:3);  

                elseif  strcmp(RCM(i),'RACMO22E') == 1

                time_begin = [1979 01 01 0  0 0]; 
                time_end   = [2012 12 31 23 0 0]; 
                date_vec   = datevec(datenum(time_begin):1:datenum(time_end)); 
                date_model = date_vec(:,1:3);

                elseif  strcmp(RCM(i),'ALARO-0') == 1 | strcmp(RCM(i),'RCA4') == 1

                time_begin = [1980 01 01 0  0 0]; 
                time_end   = [2010 12 31 23 0 0]; 
                date_vec   = datevec(datenum(time_begin):1:datenum(time_end)); 
                date_model = date_vec(:,1:3);

                end

                % extract the period
                varT_ex = mf_extract_period(varT, date_model, date);


                % make timeseries of extracted period
                var(:,i) = varT_ex;

            end
        end



        end

   
    
    
end
end