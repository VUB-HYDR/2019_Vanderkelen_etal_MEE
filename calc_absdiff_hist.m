% -------------------------------------------------------------------------
% Script to calculate the annual absolute differences of the EURO-CORDEX
% simulations and the observations (Maastricht)
% -------------------------------------------------------------------------

years = unique(date_hist(:,1)); 

% precipitation per year
for i = 1:length(RCM_all)

    for j = 1:size(years,1)
           pry = pr(find(date_hist(:,1)==years(j)),i);
           prs(j) = sum(pry);
 
           PRy = PR(find(date_hist(:,1)==years(j)));
           PRs = sum(PRy);
           
           tasy = tas(find(date_hist(:,1)==years(j)),i);
           TASy = TAS(find(date_hist(:,1)==years(j)));
           
           tasy_diff(j,i) = mean(tasy-TASy);   
    end
    
    
    pr_diff(i) = mean(prs)- mean(PRs); 
    
    tasy_d = mean(tasy_diff,1); 
    tas_diff = mean(tas-TAS); 
    rh_diff = mean(rh - HURS);
    sfcWind_diff = mean(sfcWind - SFCWIND); 

end


%a = pr_diff'

