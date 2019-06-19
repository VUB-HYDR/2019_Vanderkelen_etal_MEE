% ------------------------------------------------------------------------
% Script to calculate delta ETCCDI diagnostics for CCLM-EC-EARTH rcp 85
% simulation and to store them in a table
% ------------------------------------------------------------------------

% determine month year combinations for days of every period
for i = 1:length(periods)
    
    time_begin = [periods(i,2) 01 01 0  0 0]; 
    time_end  = [periods(i,3) 12 31 23 0 0]; 
    date_vec = datevec(datenum(time_begin):1:datenum(time_end)); 
   
    % exceptions
    if i == 5 && periods(i,3) - periods(i,2) ==9
       date_vec(length(date_vec)+1,:) = date_vec(length(date_vec),:);
       
    elseif i == 3 && periods(i,2) == 2028
        temp = date_vec(1:length(date_vec)-1,:);
        clear date_vec
        date_vec = temp; 
    elseif (i == 2 || i == 5 || i == 6) && periods(i,3)-periods(i,2) == 1
       date_vec(length(date_vec)+1,:) = date_vec(length(date_vec),:);
    %elseif (i == 6) && periods(i,3)-periods(i,2) == 19
     %  date_vec(length(date_vec)+1,:) = date_vec(length(date_vec),:);
    end
    
    date_per(:,:,i) = date_vec(:,1:2); 
    month_day(:,:,i) = unique(date_per(:,:,i),'rows'); 
    years(:,i) = unique(date_per(:,1,i)); 

end


%% temperature diagnostics

% 1. TXx (monthly maximum value of daily maximum temperature)
% 2. TNn (monthly minimum value of daily minimum temperature)
% 3. GSL (Growing Season Length)
%    annual count between first span of at least 6 days with daily mean
%    temperature TG>5°C and first span after July 1st of 6 daus with TH<5°C 
%    (TG = daily mean temperature))
% 4. SU number of summer days 
%    Annual count of days when TX> 25°
% 5. FD number of frost days
%    Annual count of days when Tn < 0° 
for k = 1:length(periods)
    
    % loop over all months
    for j = 1:length(month_day)
        
        [~,locb] = ismember(date_per(:,1:2,k),month_day(j,:,k),'rows');

       % TXx
       tasmax_monmax(j,k) = max(tasmax_extr(find(locb>0),k)); 
       TXx = mean(tasmax_monmax);
       
       
       % TNn
       tasmin_monmax(j,k) = min(tasmin_extr(find(locb>0),k)); 
       TNn = mean(tasmin_monmax);
       
       if k==1
           deltaTXx(k) = TXx(k);
           deltaTNn(k) = TNn(k); 
       else
           deltaTXx(k) = TXx(k) - TXx(1);
           deltaTNn(k) = TNn(k) - TNn(1); 
       end
    end
    

    % loop over all years
    for j = 1:size(years,1)
            july1 = 182; 
            tas_y = tas_extr(find(date_per(:,1,k)==years(j,k)),k); 
            tasminy = tasmin_extr(find(date_per(:,1,k)==years(j,k)),k); 
            tasmaxy = tasmax_extr(find(date_per(:,1,k)==years(j,k)),k); 
            tas_gd = tas_y>5+274.16; 
            tas_ngd = tas_y<5+274.16;
            
            % SU and FD
            tasmax_25 = tasmax_extr(find(date_per(:,1,k)==years(j,k)),k)>25+274.16; 
            tasmin_0 = tasmin_extr(find(date_per(:,1,k)==years(j,k)),k)<0+274.16; 
            
            su_y(j,k) = sum(tasmax_25); 
            fd_y(j,k) = sum(tasmin_0); 
            tas_mean(j,k) = mean(tas_y);
            
            % TXx
           tasmax_ymax(j,k) = max(tasmaxy); 
           TXxy = mean(tasmax_ymax);


           % TNn
           tasmin_ymin(j,k) = min(tasminy); 
           TNny = mean(tasmin_ymin);


        % cumsum both conditions
        gd = 0; 
        ngd = 0 ;  
        
        % loop over all days
        for i = 2:length(tas_gd)
            if tas_gd(i) ==1
                gd(i) = gd(i-1)+tas_gd(i); 
            else
                gd(i) = 0; 
            end        

            if tas_ngd(i) ==1
                ngd(i) = ngd(i-1)+tas_ngd(i); 
            else
                ngd(i) = 0; 
            end 
        end
        
        % calculate first span of 6 days above 5°
        gd_start(j,k) = min(find(gd==6)); 
        gd_end_pos= min(find(ngd(july1:length(ngd))==6))+july1; 
        if isempty(gd_end_pos)
            gd_end(j,k) = 365; 
        else
            gd_end(j,k) = gd_end_pos; 
        end
        
        
       if k==1
           deltaTXxy(k) = TXxy(k);
           deltaTNny(k) = TNny(k); 
       else
           deltaTXxy(k) = TXxy(k) - TXxy(1);
           deltaTNny(k) = TNny(k) - TNny(1); 
       end

    end
    
    % calculate number of growing days (grow season length)
    gsl_all = gd_end-gd_start; 
    
    GSL = mean(gsl_all);
    SU = mean(su_y); 
    FD = mean(fd_y); 
    TASM = mean(tas_mean); 
    
    if k == 1
        deltaGSL(1)   = GSL(1); 
        deltaSU(1)   = SU(1);
        deltaFD(1)   = FD(1); 
        deltaTASM(1) = TASM(1); 
    else
        deltaGSL(k)   = GSL(k) -GSL(1); 
        deltaSU(k)   = SU(k) -SU(1); 
        deltaFD(k)   = FD(k) -   FD(1);
        deltaTASM(k) = TASM(k) - TASM(1); 

    end
      
end



%% precipitation diagnostics

% 1. Rx1d
% 3. CDD (annual consecutive dry days)
% 4. CWD (annual consecutive wet days)
% 5. SDII (Simple precipitation intensity index)
%    annual precipitation amount divided by the amount of wet days (PR>
%    1mm)
% 6. R20mm (annual count of days when PRCP >20 mm) 
cdd = 0; 
cwd = 0; 

for k = 1:length(periods)
    
    for j = 1:length(month_day)
       [~,locb] = ismember(date_per(:,1:2,k),month_day(j,:,k),'rows');
       % model
       rx1day(j,k) = max(pr_extr(find(locb>0),k)); 
    end
   
   Rx1day = mean(rx1day); 
   if k == 1
       deltaRx1day = Rx1day(1); 
   else
       deltaRx1day(k) = Rx1day(k) - Rx1day(1); 
   end
   
   
    for j = 1:size(years,1)

        pry = pr_extr(find(date_per(:,1,k)==years(j,k)),k); 
        pry_cdd = pry<1; 
        pry_cwd = pry>=1;
        nwetdays = sum(pry>1); 
 
        pr_20 = pry>10; 

        % loop over all days
        for i = 2:length(pry_cdd)

            if pry_cdd(i) ==1
                cdd(i) = cdd(i-1)+pry_cdd(i); 
            else
                cdd(i) = 0; 
            end
            if pry_cwd(i) ==1
                cwd(i) = cwd(i-1)+pry_cwd(i); 
            else
                cwd(i) = 0;  
            end
        end
        cdd_max(j,k) = max(cdd); 
        cwd_max(j,k) = max(cwd); 
        
        sum_pr_20(j,k) = sum(pr_20);
        pr_tot(j,k) = sum(pry);
        sdii(j,k) = pr_tot(j,k) /nwetdays; 

    end
    
    % calculate mean over 5 years
    CDD = mean(cdd_max); 
    CWD = mean(cwd_max); 
    
    R20mm = mean(sum_pr_20); 
    PRCTOT = mean(pr_tot); 
    
    SDII = mean(sdii); 
    
    if k ==1
       deltaCDD(1) = CDD(1); 
       deltaCWD(1) = CWD(1); 
       deltaPRCTOT(1) = PRCTOT(1); 
       deltaR20mm(1) = R20mm(1); 
       deltaSDII(1) = SDII(1); 
    else
        deltaCDD(k) = CDD(k)-CDD(1); 
        deltaCWD(k) = CWD(k)-CWD(1);
        
        deltaPRCTOT(k) = PRCTOT(k)-PRCTOT(1); 
       deltaR20mm(k) = R20mm(k) -R20mm(1);
       deltaSDII(k) = SDII(k) - SDII(1); 

    end    
    
end




%% table

diagnostics_temp = [deltaTASM; deltaTXxy; deltaTNny; deltaGSL; deltaFD; deltaSU]

% diag_temp_30 = diagnostics_temp; 
% csvwrite('diag_temp_30.dat' ,diag_temp_30)

%diag_temp_30 = diagnostics_temp; 
%csvwrite('diag_temp_30.dat' ,diag_temp_10)
%diag_temp_10 = diagnostics_pr; 
%csvwrite('diag_temp_10.dat' ,diag_temp_10)


%diag_temp_1 = diagnostics_temp; 
%csvwrite('diag_temp_1.dat' ,diag_temp_1)

%diag_temp_2 = diagnostics_temp; 
%csvwrite('diag_temp_2.dat' ,diag_temp_2)

%diag_temp_20 = diagnostics_temp; 
%csvwrite('diag_temp_20.dat' ,diag_temp_20)

diagnostics_pr = [ deltaPRCTOT; deltaRx1day; deltaR20mm; deltaCDD; deltaCWD ]
%diagnostics_pr_5 = diagnostics_pr; 
%diag_pr_30 = diagnostics_pr; 
%csvwrite('diag_pr_30.dat' ,diag_pr_30 )

%diag_pr_5 = diagnostics_pr; 
%csvwrite('diag_pr_5.dat' ,diag_pr_5 )

%diag_pr_10 = diagnostics_pr; 
%csvwrite('diag_pr_10.dat' ,diag_pr_10 )

%diag_pr_1 = diagnostics_pr; 
%csvwrite('diag_pr_1.dat' ,diag_pr_1)

%diag_pr_2 = diagnostics_pr; 
%csvwrite('diag_pr_2.dat' ,diag_pr_2)

%diag_pr_20 = diagnostics_pr; 
%csvwrite('diag_pr_20.dat' ,diag_pr_20)
