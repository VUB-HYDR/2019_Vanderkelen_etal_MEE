
function [var_extracted] = mf_extract_prd_eco_leap10y(var, date_var, date_new, nperiod)

% var = pr; 
% date_var = date_all(:,1); 
% date_new = extr_years; 
% nperiod = 2;

[isdate,  date_loc] = ismember(date_var(:,1),date_new);
var_temp = var(isdate); 

%var_extracted = zeros(size(var_temp)); 


% periods with correct leap year
if  nperiod == 4  || nperiod == 6
   
        var_extracted = var_temp(1:length(var_temp)-1); 

else
    
        var_extracted = var_temp; 

end




% 
%  if sum(isleap(date_new')) == 2
%    
%     var_extracted(length(var_extracted)+1) = var_extracted(length(var_extracted)); 
%  end

end