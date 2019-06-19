% ------------------------------------------------------------------------
% Function to determine 10 year period around certain threshold value

function period = mf_GMTperiod_2y(Tanom, years, threshold)

mid_year = years(min(find(Tanom>threshold))); 
period = mid_year:mid_year+1;

    if Tanom(length(Tanom))<threshold
        period = zeros(5,1); 
    end
end