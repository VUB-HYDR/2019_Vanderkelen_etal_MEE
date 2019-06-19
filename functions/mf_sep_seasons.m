% -------------------------------------------------------------------------
% Function to separate seasons

function [var_seas] = mf_sep_seasons(var,date,season)


if strcmp(season,'JJA')     % summer   
mon = [6 7 8]; 
elseif strcmp(season,'DJF') % winter
mon = [12 1 2]  ;  
elseif strcmp(season,'SON') % autumn
mon = [9 10 11];    
elseif strcmp(season,'MAM') % spring
mon = [3 4 5];    
end

loc_seas_1 = find(date(:,2) == mon(1));
loc_seas_2 = find(date(:,2) == mon(2));
loc_seas_3 = find(date (:,2) == mon(3));
loc_seas = [loc_seas_1; loc_seas_2; loc_seas_3];
var_seas = var(loc_seas,:);     

end