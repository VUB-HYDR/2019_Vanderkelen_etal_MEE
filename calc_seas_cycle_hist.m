
% ------------------------------------------------------------------------
% Script to calculate and plot seasonal cycles of variables
% of reference data for the historical cycle

TAS_seas = mf_calc_seascycle(TAS,date_hist, 'day')';
PR_seas = mf_calc_seascycle(PR,date_hist,'day')';

SFCWIND_seas = mf_calc_seascycle(SFCWIND,date_hist, 'day')';
HURS_seas = mf_calc_seascycle(HURS,date_hist,'day')';

TASMIN_seas = mf_calc_seascycle(TASMIN,date_hist, 'day')';
TASMAX_seas = mf_calc_seascycle(TASMAX,date_hist, 'day')';


% of model data
for i = 1:nm

   tas_seas(:,i) = mf_calc_seascycle(tas(:,i),date_hist, 'day');
   
   tasmin_seas(:,i) = mf_calc_seascycle(tasmin(:,i),date_hist, 'day');
   tasmax_seas(:,i) = mf_calc_seascycle(tasmax(:,i),date_hist, 'day');

   pr_seas(:,i)  = mf_calc_seascycle(pr(:,i),date_hist,'day');
   
   sfcWind_seas(:,i)  = mf_calc_seascycle(sfcWind(:,i),date_hist,'day');

   rh_seas(:,i)  = mf_calc_seascycle(rh(:,i),date_hist,'day');


    
end


%% calculate seasonal cycle scores
% difference with observed: 
%                           - amplitude
%                           - lag
%                           - diurnal temperature range (DTR) 

% calculate amplitude of seasonal cycle

% ref data
PR_seas_ampl = max(PR_seas) - min(PR_seas);
TAS_seas_ampl = max(TAS_seas) - min(TAS_seas); 
HURS_seas_ampl = max(HURS_seas) - min(HURS_seas); 
SFCWIND_seas_ampl = max(SFCWIND_seas) - min(SFCWIND_seas); 

% model data

for i = 1:nm

   pr_seas_ampl(i)  = max(pr_seas(:,i)) - min(pr_seas(:,i)); 
   tas_seas_ampl(i) = max(tas_seas(:,i)) - min(tas_seas(:,i)); 
   rh_seas_ampl(i)  = max(rh_seas(:,i)) - min(rh_seas(:,i)); 
   sfcWind_seas_ampl(i) = max(sfcWind_seas(:,i)) - min(sfcWind_seas(:,i)); 
   
   pr_ampl_diff(i) = pr_seas_ampl(i)-PR_seas_ampl; 
   tas_ampl_diff(i) = tas_seas_ampl(i)-TAS_seas_ampl; 
   rh_ampl_diff(i) = rh_seas_ampl(i)-HURS_seas_ampl; 
   sfcWind_ampl_diff(i) = sfcWind_seas_ampl(i)-SFCWIND_seas_ampl; 

end


% calculate Diurnal temperature range

DTR = TASMAX - TASMIN;

DTR_DJF = mf_sep_seasons(DTR,date_hist,'DJF');
DTR_MAM = mf_sep_seasons(DTR,date_hist,'MAM');
DTR_JJA = mf_sep_seasons(DTR,date_hist,'JJA');
DTR_SON = mf_sep_seasons(DTR,date_hist,'SON');

for i = 1:nm
   
    dtr(:,i) = tasmax(:,i) - tasmin(:,i); 
    dtr_diff(:,i) = dtr(:,i)-DTR; 
    dtr_mdiff(i) = mean(dtr_diff(:,i),1);  

end

% DTR per season

[dtr_DJF] = mean(mf_sep_seasons(dtr_diff,date_hist,'DJF')); 
[dtr_MAM] = mean(mf_sep_seasons(dtr_diff,date_hist,'MAM')); 
[dtr_JJA] = mean(mf_sep_seasons(dtr_diff,date_hist,'JJA')); 
[dtr_SON] = mean(mf_sep_seasons(dtr_diff,date_hist,'SON')); 

% 6. wet day frequency  0.1 mm 
% observed wet days: 
nwdays_obs = sum(PR>0.1); 
fwdays_obs = nwdays_obs/length(PR)*100; 

for i = 1:length(RCM_all)
    
   nwdays_mod(:,i) = sum(pr(:,i)>0.1); 
    
end

fwdays_mod = nwdays_mod./length(pr)*100; 
fwdays_diff = fwdays_mod - fwdays_obs; 


% 7. wet day frequency 1 mm
nwdays_obs1 = sum(PR>1); 
fwdays_obs1 = nwdays_obs1/length(PR)*100; 

% n wetdays
for i = 1:length(RCM_all)
    
   nwdays_mod1(:,i) = sum(pr(:,i)>1); 
    
end
fwdays_mod1 = nwdays_mod1./length(pr)*100; 
fwdays_diff1 = fwdays_mod1 - fwdays_obs1; 

% 8. n frost days
nfrdays_obs = sum(TASMIN<273.15); 
ffrdays_obs = nfrdays_obs/length(TASMIN)*100;

for i = 1:length(RCM_all)
     
   nfrdays_mod(:,i) = sum(tasmin(:,i)<273.15); 
    
end
ffrdays_mod = nfrdays_mod./length(tasmin)*100; 

ffrdays_diff = ffrdays_mod - ffrdays_obs; 

% 9. Rx1day monthly maximum 1-day precipitation

month_day = unique(date_hist(:,1:2),'rows'); 
for j = 1:length(month_day)
   [~,locb] = ismember(date_hist(:,1:2),month_day(j,:),'rows');
   
   % observations
   PR_monmax(j) = max(PR(find(locb>0))); 
   
   % model
   for i = 1:length(RCM_all)
    pr_monmax(j,i) = max(pr(find(locb>0),i)); 
    pr_monmax_diff(j,i) = pr_monmax(j,i) - PR_monmax(j); 
   end
   
end

pr_monmax_diffm = mean(pr_monmax_diff);

% 10  CDD. Consecutive dry days adn 11 consecutive wet days
% Maximum length of dry spell, maximum number of consecutive days with RR <
% 1mm in a year
years = unique(date_hist(:,1));
CWD = 0; 
CDD = 0; 
cdd = 0; 
cwd = 0; 
% observations
for j = 1:length(years)
   
    PRy = PR(find(date_hist(:,1)==years(j))); 
    PRy_cdd = PRy<1; 
    PRy_cwd = PRy>=1;
    
        % loop over all days
    for i = 2:length(PRy_cdd)
       
        % CDD
        if PRy_cdd(i) ==1
            CDD(i) = CDD(i-1)+PRy_cdd(i); 
        else
            CDD(i) = 0; 
        end
        
        %CWD
        if PRy_cwd(i) == 1
            CWD(i) = CWD(i-1)+PRy_cwd(i); 
        else
            CWD(i) = 0; 
        end
    end
    CDD_max(j) = max(CDD); 
    CWD_max(j) = max(CWD); 
    
end
    
% models
for k = 1:length(RCM_all)
    for j = 1:length(years)

        pry = pr(find(date_hist(:,1)==years(j)),k); 
        pry_cdd = pry<1; 
        pry_cwd = pry>=1;

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

    end
    cdd_diff(:,k) = cdd_max(:,k) - CDD_max'; 
    cwd_diff(:,k) = cwd_max(:,k) - CWD_max';
end

cdd_mdiff = mean(cdd_diff); 
cwd_mdiff = mean(cwd_diff);



% ranking

% 1. amplitude tas
r_tas_ampl = 1:length(RCM_all);
[~,p] = sort(abs(tas_ampl_diff)); 
r_tas_ampl(p) = r_tas_ampl;


% 2. amplitude pr
r_pr_ampl = 1:length(RCM_all);
[~,p] = sort(abs(pr_ampl_diff)); 
r_pr_ampl(p) = r_pr_ampl;

% 3. amplitude rh
r_rh_ampl = 1:length(RCM_adj);
rh_ampl_diff_cut = [rh_ampl_diff(1:12) rh_ampl_diff(14:18) ];
[~,p] = sort(abs(rh_ampl_diff_cut)); 
r_rh_ampl(p) = r_rh_ampl;
r_rh_ampl = mf_insertNaN(r_rh_ampl,13,0);

% 4. amplitude pr
r_sfcWind_ampl = 1:length(RCM_adj)-1;
sfcWind_ampl_diff_cut = [sfcWind_ampl_diff(1:4) sfcWind_ampl_diff(6:12) sfcWind_ampl_diff(14:18)];
[~,p] = sort(abs(sfcWind_ampl_diff_cut)); 
r_sfcWind_ampl(p) = r_sfcWind_ampl;
r_sfcWind_ampl = mf_insertNaN(r_sfcWind_ampl,5,13);


% 5. DTR

r_dtr = 1:length(RCM_adj);
dtr_mdiff_cut = [dtr_mdiff(1:12) dtr_mdiff(14:18)];
[~,p] = sort(abs(dtr_mdiff_cut)); 
r_dtr(p) = r_dtr;
r_dtr = mf_insertNaN(r_dtr,13,0);

r_dtr_DJF = 1:length(RCM_adj);
dtr_mdiff_cut = [dtr_DJF(1:12) dtr_DJF(14:18)];
[~,p] = sort(abs(dtr_mdiff_cut),'ascend'); 
r_dtr_DJF(p) = r_dtr_DJF;
r_dtr_DJF = mf_insertNaN(r_dtr_DJF,13,0);

r_dtr_MAM = 1:length(RCM_adj);
dtr_mdiff_cut = [dtr_MAM(1:12) dtr_MAM(14:18)];
[~,p] = sort(abs(dtr_mdiff_cut),'ascend'); 
r_dtr_MAM(p) = r_dtr_MAM;
r_dtr_MAM = mf_insertNaN(r_dtr_MAM,13,0);

r_dtr_JJA = 1:length(RCM_adj);
dtr_mdiff_cut = [dtr_JJA(1:12) dtr_JJA(14:18)];
[~,p] = sort(abs(dtr_mdiff_cut),'ascend'); 
r_dtr_JJA(p) = r_dtr_JJA;
r_dtr_JJA = mf_insertNaN(r_dtr_JJA,13,0);

r_dtr_SON = 1:length(RCM_adj);
dtr_mdiff_cut = [dtr_SON(1:12) dtr_SON(14:18)];
[~,p] = sort(abs(dtr_mdiff_cut),'ascend'); 
r_dtr_SON(p) = r_dtr_SON;
r_dtr_SON = mf_insertNaN(r_dtr_SON,13,0);


% 6. Wet day frequency 0mm

r_wdays = 1:length(RCM_all);
[~,p] = sort(abs(fwdays_diff), 'ascend'); 
r_wdays(p) = r_wdays;

% 7. Wet day frequency 1mm

r_wdays1 = 1:length(RCM_all);
[~,p] = sort(abs(fwdays_diff1), 'ascend'); 
r_wdays1(p) = r_wdays1;


% 8. Frost days

r_frdays = 1:length(RCM_all);
[~,p] = sort(abs(ffrdays_diff), 'ascend'); 
r_frdays(p) = r_frdays;
r_frdays(13) = nan; 


% 9. Rx1day monthly maximum 1-day precipitation

r_pr_monmax = 1:length(RCM_all);
[~,p] = sort(abs(pr_monmax_diffm), 'ascend'); 
r_pr_monmax(p) = r_pr_monmax;

% 10. Annual consecutive Dry days 
r_cdd = 1:length(RCM_all);
[~,p] = sort(abs(cdd_mdiff), 'ascend'); 
r_cdd(p) = r_cdd;

% 11. Annual consecutive wet days 
r_cwd = 1:length(RCM_all);
[~,p] = sort(abs(cwd_mdiff), 'ascend'); 
r_cwd(p) = r_cwd;

seas_rankings_hist= [r_dtr; r_dtr_DJF; r_dtr_JJA;r_wdays; r_wdays1; r_frdays; r_pr_monmax; r_cdd; r_cwd]; 
    
save seas_rankings_hist.mat seas_rankings_hist

load seasvar_names_eval

seasvar_names{1,4} = 'Wet days 0.1mm (50.3 %)'; 

save seasvar_names_eval.mat seasvar_names