% ------------------------------------------------------------------------
% Function to calculate the seasonal means on annual scale of a dataset


function [var_seasymean] = mf_calc_seasymean(var,date,season)

year_month = unique(date(:,1:2),'rows');
years = unique(date(:,1)); 

if strcmp(season,'JJA')     % summer   
mon = [6 7 8]; 
elseif strcmp(season,'DJF') % winter
mon = [12 1 2];    
elseif strcmp(season,'SON') % autumn
mon = [9 10 11];    
elseif strcmp(season,'MAM') % spring
mon = [3 4 5];    
end

loc_seas_1 = find(year_month(:,2) == mon(1));
loc_seas_2 = find(year_month(:,2) == mon(2));
loc_seas_3 = find(year_month(:,2) == mon(3));
loc_seas = [loc_seas_1; loc_seas_2; loc_seas_3]; 
    
year_seas = year_month(loc_seas,:);  
var_seas = var(loc_seas);     

for i = 1:length(years)
   
    var_seasymean(i) = mean(var_seas(find(years(i)==year_seas(:,1))));
    
end

var_seasymean = var_seasymean'; 

end