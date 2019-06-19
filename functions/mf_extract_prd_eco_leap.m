
function [var_extracted] = mf_extract_prd_eco(var, date_var, date_new, nperiod)

% var = pr; 
% date_var = date_all(:,1); 
% date_new = extr_years; 
% nperiod = 2;

[isdate,  date_loc] = ismember(date_var(:,1),date_new);
var_temp = var(isdate); 

% account for leap years to make years of equal length. 
% second yearof the period needs to be a leap year. (not the case for periods 2,3,4 and
% 6)
loc_leap_2nd = 425; 
loc_leap_3rd = 790; 
loc_leap_4th = 1155; 

var_temp2 = zeros(size(var_temp)-1); 
var_extracted = zeros(size(var_temp)); 


% periods with correct leap year
if nperiod ==1 || nperiod == 5
    var_extracted = var_temp; 
    
    
% periods with leap year not in the correct year    
elseif  nperiod == 2 % leap year is on 4th year

    % remove 4th year leap day
    var_temp2(1:loc_leap_4th-1,1) = var_temp(1:loc_leap_4th-1,1); 
    var_temp2(loc_leap_4th:length(var_temp2),1) = var_temp(loc_leap_4th+1:length(var_temp),1); 
    
   
    % add 2nd year leap day
    var_extracted(1:loc_leap_2nd-1,1) = var_temp2(1:loc_leap_2nd-1,1); 
    var_extracted(loc_leap_2nd,1) = var_temp2(loc_leap_2nd-1,1); 
    var_extracted(loc_leap_2nd+1:length(var_extracted),1) = var_temp2(loc_leap_2nd:length(var_temp2),1); 

    
elseif nperiod ==3 || nperiod == 4 || nperiod == 6 % leap year is on 3th year
    
    
    % remove 3th year leap day
    var_temp2(1:loc_leap_3rd-1,1) = var_temp(1:loc_leap_3rd-1,1); 
    var_temp2(loc_leap_3rd:length(var_temp2),1) = var_temp(loc_leap_3rd+1:length(var_temp),1); 
    
   
    % add 2nd year leap day
    var_extracted(1:loc_leap_2nd-1,1) = var_temp2(1:loc_leap_2nd-1,1); 
    var_extracted(loc_leap_2nd,1) = var_temp2(loc_leap_2nd-1,1); 
    var_extracted(loc_leap_2nd+1:length(var_extracted),1) = var_temp2(loc_leap_2nd:length(var_temp2),1); 

     
end


% 
%  if sum(isleap(date_new')) == 2
%    
%     var_extracted(length(var_extracted)+1) = var_extracted(length(var_extracted)); 
%  end

end