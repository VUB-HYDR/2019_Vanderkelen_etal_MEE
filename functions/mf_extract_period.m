% ------------------------------------------------------------------------
% Function to extract a certain time period from a variable
% 
% INPUT:    
%       var:      original variable
%       date_var: date vector corresponding to original variable
%       date_new: date vector corresponding with the period to extract


function [var_extracted] = mf_extract_period(var, date_var, date_new)

[~,  date_loc] = ismember(date_new, date_var, 'rows');
var_extracted = var(date_loc); 

end