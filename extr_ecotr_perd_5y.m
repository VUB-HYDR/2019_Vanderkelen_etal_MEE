% ------------------------------------------------------------------------
% Function ot extract the predefined periods for the ecotron
% Based on daily data

for i = 1:size(periods,1)
    
     extr_years = (periods(i,2):1:periods(i,3))'; 
    
     pr_extr(:,i)      = mf_extract_prd_eco_leap30y(pr, date_all(:,1), extr_years',i); 
     tas_extr(:,i)     = mf_extract_prd_eco_leap30y(tas, date_all(:,1),extr_years',i);
     tasmin_extr(:,i)  = mf_extract_prd_eco_leap30y(tasmin, date_all(:,1),extr_years',i);
     tasmax_extr(:,i)  = mf_extract_prd_eco_leap30y(tasmax, date_all(:,1),extr_years',i);
     sfcWind_extr(:,i) = mf_extract_prd_eco_leap30y(sfcWind, date_all(:,1),extr_years',i);
     rh_extr(:,i)      = mf_extract_prd_eco_leap30y(rh, date_all(:,1),extr_years',i);
     

     % calculate annual means to plot
     
     time_begin = [periods(i,2) 01 01 0  0 0]; 
     time_end   =  [periods(i,3)  12 31 23 0 0]; 
     date_vec   = datevec(datenum(time_begin):1:datenum(time_end)); 
     date       = date_vec(:,1:3); 
     
     if i == 3 
        clear date 
        date = date_vec(1:length(date_vec)-1,1:3); 
         
     end
     
     pr_ymean(:,i)      = mf_calc_ymean(pr_extr(:,i),date);
     tas_ymean(:,i)     = mf_calc_ymean(tas_extr(:,i),date);
     tasmin_ymean(:,i)  = mf_calc_ymean(tasmin_extr(:,i),date);
     tasmax_ymean(:,i)  = mf_calc_ymean(tasmax_extr(:,i),date);
     sfcWind_ymean(:,i) = mf_calc_ymean(sfcWind_extr(:,i),date);
     rh_ymean(:,i)      = mf_calc_ymean(rh_extr(:,i),date);
     
     pr_mmean(:,i)      = mf_calc_mmean(pr_extr(:,i),date);
     tas_mmean(:,i)     = mf_calc_mmean(tas_extr(:,i),date);
     tasmin_mmean(:,i)   = mf_calc_mmean(tasmin_extr(:,i),date);
     tasmax_mmean(:,i)  = mf_calc_mmean(tasmax_extr(:,i),date);
     sfcWind_mmean(:,i) = mf_calc_mmean(sfcWind_extr(:,i),date);
     rh_mmean(:,i)      = mf_calc_mmean(rh_extr(:,i),date);

end



