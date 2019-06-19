
function [var_extracted] = mf_extract_prd_eco_leap30y(var, date_var, date_new, nperiod)

% var = pr; 
% date_var = date_all(:,1); 
% date_new = extr_years; 
% nperiod = 2;

[isdate,  date_loc] = ismember(date_var(:,1),date_new);
var_temp = var(isdate); 

var_extracted = zeros(size(var_temp)); 


leap_years = [1952, 1956 1960 1964 1968 1972 1976 1980 1984 1988 1992 1996 2000 2004 2008 2012, ...
2016 20202024 2028 2032 2036 2040 2044 2048 2052 2056 2060 2064 2068 2072 2076 2080 2084 2088 2092 2096]; 

% periods with correct leap year
if nperiod ~=3    
    var_extracted = var_temp; 
else
    var_extracted = var_temp(1:length(var_temp)-1); 
end


% 
%  if sum(isleap(date_new')) == 2
%    
%     var_extracted(length(var_extracted)+1) = var_extracted(length(var_extracted)); 
%  end

end