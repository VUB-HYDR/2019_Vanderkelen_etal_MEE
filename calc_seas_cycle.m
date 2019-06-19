
% ------------------------------------------------------------------------
% Script to calculate and plot seasonal cycles of variables
% of reference data 
TAS_seas = mf_calc_seascycle(TAS,date_eval, 'day')';
PR_seas = mf_calc_seascycle(PR,date_eval,'day')';

SFCWIND_seas = mf_calc_seascycle(SFCWIND,date_eval, 'day')';
HURS_seas = mf_calc_seascycle(HURS,date_eval,'day')';

TASMIN_seas = mf_calc_seascycle(TASMIN,date_eval, 'day')';
TASMAX_seas = mf_calc_seascycle(TASMAX,date_eval, 'day')';


% of model data
for i = 1:nm

   tas_seas(:,i) = mf_calc_seascycle(tas(:,i),date_eval, 'day');
   
   tasmin_seas(:,i) = mf_calc_seascycle(tasmin(:,i),date_eval, 'day');
   tasmax_seas(:,i) = mf_calc_seascycle(tasmax(:,i),date_eval, 'day');

   pr_seas(:,i)  = mf_calc_seascycle(pr(:,i),date_eval,'day');
   
   sfcWind_seas(:,i)  = mf_calc_seascycle(sfcWind(:,i),date_eval,'day');

   rh_seas(:,i)  = mf_calc_seascycle(rh(:,i),date_eval,'day');

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

% calculate lag of seasonal cycle
% positive: model lags ref
% no correct calculation! 

for i = 1:nm
   
   pr_seas_lag(i) = mean(PR_seas - pr_seas(:,i)); 
   tas_seas_lag(i) = mean(TAS_seas - tas_seas(:,i));
   rh_seas_lag(i) = mean(HURS_seas - rh_seas(:,i)); 
   sfcWind_seas_lag(i) = mean(SFCWIND_seas - sfcWind_seas(:,i));
end

% calculate Diurnal temperature range

DTR = TASMAX - TASMIN; 

DTR_DJF = mf_sep_seasons(DTR,date_eval,'DJF');
DTR_MAM = mf_sep_seasons(DTR,date_eval,'MAM');
DTR_JJA = mf_sep_seasons(DTR,date_eval,'JJA');
DTR_SON = mf_sep_seasons(DTR,date_eval,'SON');

for i = 1:nm
   
    dtr(:,i) = tasmax(:,i) - tasmin(:,i); 
    dtr_diff(:,i) = dtr(:,i)-DTR; 
    dtr_mdiff(i) = mean(dtr_diff(:,i),1); 
    
end

[dtr_DJF] = mean(mf_sep_seasons(dtr_diff,date_eval,'DJF')); 
[dtr_MAM] = mean(mf_sep_seasons(dtr_diff,date_eval,'MAM')); 
[dtr_JJA] = mean(mf_sep_seasons(dtr_diff,date_eval,'JJA')); 
[dtr_SON] = mean(mf_sep_seasons(dtr_diff,date_eval,'SON')); 

% ranking

% 1. amplitude tas
r_tas_ampl = 1:length(RCM);
[~,p] = sort(abs(tas_ampl_diff),'ascend'); 
r_tas_ampl(p) = r_tas_ampl;


% 2. amplitude pr
r_pr_ampl = 1:length(RCM);
[~,p] = sort(abs(pr_ampl_diff),'ascend'); 
r_pr_ampl(p) = r_pr_ampl;

% 3. amplitude pr
r_rh_ampl = 1:length(RCM_rh);
rh_ampl_diff_cut = [rh_ampl_diff(1:2) rh_ampl_diff(4:7) rh_ampl_diff(9)];
[~,p] = sort(abs(rh_ampl_diff_cut),'ascend'); 
r_rh_ampl(p) = r_rh_ampl;
r_rh_ampl = mf_insertNaN(r_rh_ampl,3,8);

% 4. amplitude sfcWind
r_sfcWind_ampl = 1:length(RCM_rh);
sfcWind_ampl_diff_cut = [sfcWind_ampl_diff(1) sfcWind_ampl_diff(3:7) ...
    sfcWind_ampl_diff(9)];
[~,p] = sort(abs(sfcWind_ampl_diff_cut),'ascend'); 
r_sfcWind_ampl(p) = r_sfcWind_ampl;
r_sfcWind_ampl = mf_insertNaN(r_sfcWind_ampl,2,8);


% 5. DTR

r_dtr = 1:length(RCM_adj);
dtr_mdiff_cut = [dtr_mdiff(1:7) dtr_mdiff(9)];
[~,p] = sort(abs(dtr_mdiff_cut),'ascend'); 
r_dtr(p) = r_dtr;
r_dtr = mf_insertNaN(r_dtr,8,0);

r_dtr_DJF = 1:length(RCM_adj);
dtr_mdiff_cut = [dtr_DJF(1:7) dtr_DJF(9)];
[~,p] = sort(abs(dtr_mdiff_cut),'ascend'); 
r_dtr_DJF(p) = r_dtr_DJF;
r_dtr_DJF = mf_insertNaN(r_dtr_DJF,8,0);

r_dtr_MAM = 1:length(RCM_adj);
dtr_mdiff_cut = [dtr_MAM(1:7) dtr_MAM(9)];
[~,p] = sort(abs(dtr_mdiff_cut),'ascend'); 
r_dtr_MAM(p) = r_dtr_MAM;
r_dtr_MAM = mf_insertNaN(r_dtr_MAM,8,0);

r_dtr_JJA = 1:length(RCM_adj);
dtr_mdiff_cut = [dtr_JJA(1:7) dtr_JJA(9)];
[~,p] = sort(abs(dtr_mdiff_cut),'ascend'); 
r_dtr_JJA(p) = r_dtr_JJA;
r_dtr_JJA = mf_insertNaN(r_dtr_JJA,8,0);

r_dtr_SON = 1:length(RCM_adj);
dtr_mdiff_cut = [dtr_SON(1:7) dtr_SON(9)];
[~,p] = sort(abs(dtr_mdiff_cut),'ascend'); 
r_dtr_SON(p) = r_dtr_SON;
r_dtr_SON = mf_insertNaN(r_dtr_SON,8,0);

% 6. n wetdays 0

% observed wet days: 
nwdays_obs = sum(PR>0.1); 
fwdays_obs = nwdays_obs/length(PR)*100; 

for i = 1:length(RCM)
    
   nwdays_mod(:,i) = sum(pr(:,i)>0.1); 
    
end
fwdays_mod = nwdays_mod./length(pr)*100; 

fwdays_diff = fwdays_mod - fwdays_obs; 

r_wdays = 1:length(RCM);
[~,p] = sort(abs(fwdays_diff), 'ascend'); 
r_wdays(p) = r_wdays;


% 7. n wetdays 1 mm

% observed wet days: 
nwdays_obs1 = sum(PR>1); 
fwdays_obs1 = nwdays_obs1/length(PR)*100; 

for i = 1:length(RCM)
    
   nwdays_mod1(:,i) = sum(pr(:,i)>1); 
    
end

fwdays_mod1 = nwdays_mod1./length(pr)*100; 

fwdays_diff1 = fwdays_mod1 - fwdays_obs1; 

r_wdays1 = 1:length(RCM);
[~,p] = sort(abs(fwdays_diff1), 'ascend'); 
r_wdays1(p) = r_wdays1;

nowday_sum =sum(pr(find(PR==0),:))/20; 


% 8. n frost days
nfrdays_obs = sum(TASMIN<273.15); 
ffrdays_obs = nfrdays_obs/length(TASMIN)*100;
for i = 1:length(RCM)
     
   nfrdays_mod(:,i) = sum(tasmin(:,i)<273.15); 
    
end
ffrdays_mod = nfrdays_mod./length(tasmin)*100; 

ffrdays_diff = ffrdays_mod - ffrdays_obs; 

r_frdays = 1:length(RCM);
[~,p] = sort(abs(ffrdays_diff), 'ascend'); 
r_frdays(p) = r_frdays;
r_frdays(8) = nan; 

% 9. Rx1day monthly maximum 1-day precipitation
month_day = unique(date_eval(:,1:2),'rows'); 
for j = 1:length(month_day)
   [~,locb] = ismember(date_eval(:,1:2),month_day(j,:),'rows');
   
   % observations
   PR_monmax(j) = max(PR(find(locb>0))); 
   
   % model
   for i = 1:length(RCM)
    pr_monmax(j,i) = max(pr(find(locb>0),i)); 
    pr_monmax_diff(j,i) = pr_monmax(j,i) - PR_monmax(j); 
   end
   
end

pr_monmax_diffm = mean(pr_monmax_diff);

% give ranking
r_pr_monmax = 1:length(RCM);
[~,p] = sort(abs(pr_monmax_diffm), 'ascend'); 
r_pr_monmax(p) = r_pr_monmax;

    
% 10  CDD. Consecutive dry days adn 11 consecutive wet days
% Maximum length of dry spell, maximum number of consecutive days with RR <
% 1mm in a year
years = unique(date_eval(:,1));
CWD = 0; 
CDD = 0; 
cdd = 0; 
cwd = 0; 
% observations
for j = 1:length(years)
   
    PRy = PR(find(date_eval(:,1)==years(j))); 
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
for k = 1:length(RCM)
    for j = 1:length(years)

        pry = pr(find(date_eval(:,1)==years(j)),k); 
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

% cdd
r_cdd = 1:length(RCM);
[~,p] = sort(abs(cdd_mdiff), 'ascend'); 
r_cdd(p) = r_cdd;

% cwd
r_cwd = 1:length(RCM);
[~,p] = sort(abs(cwd_mdiff), 'ascend'); 
r_cwd(p) = r_cwd;


seas_rankings_eval = [r_dtr; r_dtr_DJF; r_dtr_JJA;r_wdays; r_wdays1; r_frdays; r_pr_monmax; r_cdd; r_cwd]; 
    
save seas_rankings_eval.mat seas_rankings_eval
