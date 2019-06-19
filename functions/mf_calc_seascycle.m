% ------------------------------------------------------------------------
% Function to calculate the seasonal cycle of given time series
% input: var and date (=period covered by var) 
% ------------------------------------------------------------------------

function [var_seas] = mf_calc_seascycle(var,date,time_res)

% check var on NaNs
nan_ind = find(~isnan(var));
var_nonan = var(nan_ind); 
date_nonan = date(nan_ind,:); 

% define one leap year
year_begin  = [2008, 1, 1, 0,0,0];
year_end   =  [2008,12,31,23,0,0];  
year_vec = datevec(datenum(year_begin):1:datenum(year_end)); 
month_day = year_vec(:,2:3); 
months = (1:12)';

% calculate mean precipitation per day of each year
if strcmp(time_res,'day') == 1
    
[~, ind_day] = ismember(date_nonan(:,2:3),month_day,'rows'); 

    for i = 1:length(month_day)
       var_seas(i) = mean(var_nonan((find(ind_day==i)))); 
    end

elseif strcmp(time_res,'month')
    
    [~, ind_month] = ismember(date_nonan(:,2),months,'rows');
    
        for i = 1:length(months)
        var_seas(i) = mean(var_nonan((find(ind_month==i)))); 
        end
    
end
end

