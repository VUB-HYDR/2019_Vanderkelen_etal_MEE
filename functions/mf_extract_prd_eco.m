
function [var_extracted] = mf_extract_prd_eco(var, date_var, date_new)


[isdate,  date_loc] = ismember(date_var,date_new);
var_extracted = var(isdate); 

% account for leap years to make years of equal length. 
% TO BE DISCUSSED for real experiment!!
 if sum(isleap(date_new)) == 2   
    var_extracted(length(var_extracted)+1) = var_extracted(length(var_extracted)); 
 end

end