% ------------------------------------------------------------------------
% Function to determine 10 year period around certain threshold value

function period = mf_GMTperiod_20y(Tanom, years, threshold)

mid_year = years(min(find(Tanom>threshold))); 
period = mid_year-9:mid_year+10;

if threshold == 4
    period = mid_year-13:mid_year+6;

    if Tanom(length(Tanom))<threshold
        period = zeros(5,1); 
    end
end