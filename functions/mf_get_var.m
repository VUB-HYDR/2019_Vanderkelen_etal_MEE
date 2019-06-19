% -----------------------------------------------------------------------
% Function to load and process CORDEX-EUR variables for station pixel 
% -----------------------------------------------------------------------


function [var] = mf_get_var(var_name, RCM_all, GCM_all,institute_all, lat_obs, lon_obs, date, run)


% define ndays
ndays= length(date);


% initialise var variable
var = zeros(ndays,length(RCM_all)); 

% Loop over model

for i = 1:length(RCM_all)
   
    % load in netcdf file (3D: lat, lon, time)
    
    [lat lon varR] = mf_ncload(var_name,institute_all(i),RCM_all(i),GCM_all(i),run); 
    
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

        % define main historical period 
        time_begin_hist = [1950 01 01 0  0 0]; 
        time_end_hist   = [2005 12 31 23 0 0]; 
        date_vec_hist  = datevec(datenum(time_begin_hist):1:datenum(time_end_hist)); 
        date_all      = date_vec_hist(:,1:3);
       
        
        if length(varT) == ndays 


           var(:,i) = varT;  
           
        %  simulation has different period    
        else     

          if strcmp(RCM_all(i),'REMO2009') == 1   % REMO misses 1st january 1989
 
            time_begin_hist = [1950 01 02 0  0 0]; 
            date_vec_hist  = datevec(datenum(time_begin_hist):1:datenum(time_end_hist)); 
            date_all      = date_vec_hist(:,1:3); 
         
          elseif (strcmp(RCM_all(i),'HIRHAM5') == 1 && strcmp(GCM_all(i),'NCC-NorESM1-M') == 1)...
                  || (strcmp(RCM_all(i),'HIRHAM5') == 1 && strcmp(GCM_all(i),'ICHEC-EC-EARTH') == 1 && strcmp(var_name,'pr')<1)...
                  || (strcmp(RCM_all(i),'WRF331F') == 1 && strcmp(GCM_all(i),'IPSL-IPSL-CM5A-MR') == 1)
          % HIRHAM5  NorESM and WRF CM5A start on 1 jan 1951
           
            time_begin_hist = [1951 01 01 0  0 0]; 
            date_vec_hist  = datevec(datenum(time_begin_hist):1:datenum(time_end_hist)); 
            date_all      = date_vec_hist(:,1:3);
          
          elseif strcmp(RCM_all(i),'CCLM4-8-17') == 1 && (strcmp(GCM_all(i),'ICHEC-EC-EARTH') == 1 ||...
                 strcmp(GCM_all(i),'MPI-M-MPI-ESM-LR') == 1)         
          % CCLM starts from 1 dec 1949 
           
            time_begin_hist = [1949 12 01 0  0 0]; 
            date_vec_hist  = datevec(datenum(time_begin_hist):1:datenum(time_end_hist)); 
            date_all      = date_vec_hist(:,1:3);          
            
          elseif strcmp(RCM_all(i),'RCA4') == 1 && (strcmp(GCM_all(i),'IPSL-IPSL-CM5A-MR') == 1)  
           % correct for leap years only 
              
          time_begin_hist = [1970 01 01 0  0 0]; 
          date_vec_hist  = datevec(datenum(time_begin_hist):1:datenum(time_end_hist)); 
          date_all      = date_vec_hist(:,1:3);            
              
           leap_location = locate_leapdays(date_all);
           leap_location(length(leap_location)+1)=length(varT)+1; 
           start = 1;          

            % Loop over leap locations and add leap days within new P 
            for j = 1:length(leap_location) 

                ind_lp = leap_location(j); 
                stop = ind_lp-1; 

                % add all years untill leap location
               var_temp(start+j-1:stop+j-1) = varT(start:stop); 
               
                % define start index
                start = ind_lp; 
            end
           
            % Fill in leap numbers
            for j = 1:length(leap_location) 
                ind_lp= leap_location(j); 
                var_temp(ind_lp) = (var_temp(ind_lp-1)+ var_temp(ind_lp+1))/2; 
            end 
            
            clear varT
            varT = var_temp;
            clear var_temp
          elseif strcmp(GCM_all(i),'MOHC-HadGEM2-ES') == 1 
                % define correct period for each RCM driven by HadGEM

                if strcmp(RCM_all(i),'CCLM4-8-17') == 1
                    
                       time_begin_hist = [1949 12 01 0  0 0]; 
                       
                elseif strcmp(RCM_all(i),'HIRHAM5') == 1
                       
                       time_begin_hist = [1951 01 01 0  0 0]; 
                 
                    
                elseif strcmp(RCM_all(i),'RACMO22E') == 1
                    
                        time_begin_hist = [1950 01 01 0  0 0]; 

  
                elseif strcmp(RCM_all(i),'RCA4') == 1
                        time_begin_hist = [1970 01 01 0  0 0]; 
                    
                end
                
                
                date_vec_hist  = datevec(datenum(time_begin_hist):1:datenum(time_end_hist));
                date_all      = date_vec_hist(:,1:3);  


            % correct 360 day years of British models
                xtra_location = locate_extradays(date_all);   
                xtra_location(length(xtra_location)+1) = length(varT);    

                start = 1; 

                   for j = 1:(length(xtra_location))

                       ind_xtra = xtra_location(j)+1; 
                       stop = ind_xtra-1; 

                       var_temp(start+j-1:stop+j-1) = varT(start:stop); 

                       start = ind_xtra+1; 
                   end


                   for j = 1:(length(xtra_location)-1)
                        ind_xtra = xtra_location(j)+1; 
                        var_temp(ind_xtra) = (mean(var_temp((ind_xtra-36:ind_xtra-1)))+ mean(var_temp((ind_xtra+1:ind_xtra+36))))./2; 

                   end
                   
                   % ----------- CORRECT BRITTISH MODEL FOR LEAP DAYS ----------------     
                   leap_location = locate_leapdays(date_all);
                   leap_location(length(leap_location)+1)= length(var_temp)+1;%+length(leap_location); 

                   start = 1;          

                   % Loop over leap locations and add leap days within new P 
                   for j = 1:length(leap_location) 

                            ind_lp = leap_location(j); 
                            stop = ind_lp-1; 

                            % add all years untill leap location
                           var_temp2(start+j-1:stop+j-1) = var_temp(start:stop); 

                            % define start index
                            start = ind_lp; 
                   end

                        % Fill in leap numbers
                   for j = 1:(length(leap_location)-1)
                            ind_lp= leap_location(j); 
                            var_temp2(ind_lp) = (var_temp2(ind_lp-1)+ var_temp2(ind_lp+1))/2; 
                   end
                   
                   clear var_temp varT
                   
                ndiff = length(date_all) - length(var_temp2); 
                var_temp2(length(var_temp2)+1:length(var_temp2)+ndiff) = var_temp2(length(var_temp2)); 
                
                    varT = var_temp2;  
                    
                    clear var_temp2
         
          end
                 
          
          if length(varT) == length(date_all)
              
              % cut hist period out of models
               var(:,i) = mf_extract_period(varT, date_all, date);
                
          end

        end

 
    end
    
    
end
end
