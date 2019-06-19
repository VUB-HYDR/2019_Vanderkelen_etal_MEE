% ------------------------------------------------------------------------
% Function to determine 10 year period around certain threshold value

function period = mf_GMT_period(Tanom, years, threshold)

mid_year = years(min(find(Tanom>threshold))); 
period = mid_year-2:mid_year+2; 

    if Tanom(length(Tanom))<threshold
        period = zeros(5,1); 
    end
end