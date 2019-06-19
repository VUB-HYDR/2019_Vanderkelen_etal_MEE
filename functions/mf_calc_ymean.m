% ------------------------------------------------------------------------
% Function to calculate the annual means of a dataset



function [var_ymean var_mmean] = mf_calc_ymean(var,date)

years = unique(date(:,1));
months = unique(date(:,1:2),'rows'); 

for i = 1:length(years)
    var_ymean(i) = mean(var(find(years(i)==date(:,1))));
    
    
end


for i = 1:length(months)
    
    [~,  date_loc] = ismember(months(i,1:2), date(:,1:2), 'rows');

    var_mmean(i) = mean(var(date_loc));

end

end

