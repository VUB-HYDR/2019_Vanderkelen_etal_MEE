% ------------------------------------------------------------------------
% Function to calculate the Perkins Skill score (PSS)
% ------------------------------------------------------------------------

function PSS = mf_calc_PSS(mod_data,ref_data,binwidth)

lower_edge = min(min(mod_data,ref_data)); 
upper_edge = max(max(mod_data,ref_data)); 

freq_m  = histcounts(mod_data,'BinLimits', [lower_edge upper_edge], ...
    'BinWidth',binwidth,'Normalization', 'probability');
freq_r  = histcounts(ref_data,'BinLimits', [lower_edge upper_edge],...
    'BinWidth',binwidth,'Normalization', 'probability');

PSS = sum(min(freq_m,freq_r)); 

end

 
