% for monthly means


function [var_monmean] = mf_calc_mmean(var,date)

 year_month = unique(date(:,1:2),'rows');
 
 for i = 1:length(year_month)
     
 [ ~, loc] = ismember(year_month(i,:),date(:,1:2),'rows');
     
 var_monmean(i) = mean(var(loc));
 
end