% --------------------------------------------------------------------------
% Script to calculate scores for EURcordex model data for each ecotron pixel
% and calculatea scores

% for variables: 
%               - tas
%               - pr
%               - rh
%               - sfcWind

% elaborate later to sfcWind and hurs (not for every model available)
% filter nans from obs 
% index gives all observations without NaNs

pr_ind =find(~isnan(PR));
tas_ind = find(~isnan(TAS));
rh_ind =find(~isnan(HURS));
sfcWind_ind = find(~isnan(SFCWIND));

% calc seasonal cycle for MAE calculation
TAS_seas = mf_calc_seascycle(TAS,date_hist, 'day')';
PR_seas = mf_calc_seascycle(PR,date_hist,'day')';
SFCWIND_seas = mf_calc_seascycle(SFCWIND,date_hist, 'day')';
HURS_seas = mf_calc_seascycle(HURS,date_hist,'day')';


% of model data
for i = 1:nm
   tas_seas(:,i) = mf_calc_seascycle(tas(:,i),date_hist, 'day');
   pr_seas(:,i)  = mf_calc_seascycle(pr(:,i),date_hist,'day');
   sfcWind_seas(:,i)  = mf_calc_seascycle(sfcWind(:,i),date_hist,'day');
   rh_seas(:,i)  = mf_calc_seascycle(rh(:,i),date_hist,'day');   
end


% tas and pr for all RCMs
for i = 1:length(RCM_all)
   
   % 1. Bias (mean, systematic error) 
   tas_bias(i) = mean(tas(tas_ind,i))- mean(TAS(tas_ind)); 
   pr_bias(i) =  mean(pr(:,i))- mean(PR); 
   sfcWind_bias(i) = mean(sfcWind(sfcWind_ind,i))- mean(SFCWIND(sfcWind_ind)); 
   rh_bias(i) =  mean(rh(rh_ind,i))- mean(HURS(rh_ind)); 
   
   
   % 2. Mean Absolute Error (MAE) - calculate at certain percentile? 
   tas_MAE(i) = mean(abs(TAS_seas)-tas_seas(:,i)); 
   pr_MAE(i)  = mean(abs(PR_seas-pr_seas(:,i)));
   sfcWind_MAE(i) = mean(abs(SFCWIND_seas-sfcWind_seas(:,i))); 
   rh_MAE(i)  = mean(abs(HURS_seas-pr_seas(:,i)));

   tas_MAE_1(i)  = mean(abs(prctile(TAS(tas_ind),1)-prctile(tas(tas_ind,i),1)));
   tas_MAE_10(i) = mean(abs(prctile(TAS(tas_ind),10)-prctile(tas(tas_ind,i),10)));
   tas_MAE_90(i) = mean(abs(prctile(TAS(tas_ind),90)-prctile(tas(tas_ind,i),90)));
   tas_MAE_99(i) = mean(abs(prctile(TAS(tas_ind),99)-prctile(tas(tas_ind,i),99)));
   
   pr_MAE_1(i)  = mean(abs(prctile(PR(pr_ind),1)-prctile(pr(pr_ind,i),1)));
   pr_MAE_10(i) = mean(abs(prctile(PR(pr_ind),10)-prctile(pr(pr_ind,i),10)));
   pr_MAE_90(i) = mean(abs(prctile(PR(pr_ind),90)-prctile(pr(pr_ind,i),90)));
   pr_MAE_99(i) = mean(abs(prctile(PR(pr_ind),99)-prctile(pr(pr_ind,i),99)));  
   
   rh_MAE_1(i)  = mean(abs(prctile(HURS(rh_ind),1)-prctile(rh(rh_ind,i),1)));
   rh_MAE_10(i) = mean(abs(prctile(HURS(rh_ind),10)-prctile(rh(rh_ind,i),10)));
   rh_MAE_90(i) = mean(abs(prctile(HURS(rh_ind),90)-prctile(rh(rh_ind,i),90)));
   rh_MAE_99(i) = mean(abs(prctile(HURS(rh_ind),99)-prctile(rh(rh_ind,i),99)));
   
   sfcWind_MAE_1(i)  = mean(abs(prctile(SFCWIND(sfcWind_ind),1)-prctile(sfcWind(sfcWind_ind,i),1)));
   sfcWind_MAE_10(i) = mean(abs(prctile(SFCWIND(sfcWind_ind),10)-prctile(sfcWind(sfcWind_ind,i),10)));
   sfcWind_MAE_90(i) = mean(abs(prctile(SFCWIND(sfcWind_ind),90)-prctile(sfcWind(sfcWind_ind,i),90)));
   sfcWind_MAE_99(i) = mean(abs(prctile(SFCWIND(sfcWind_ind),99)-prctile(sfcWind(sfcWind_ind,i),99)));


   
   % 4. Perkins skill score: measuring similarity of pdfs
   tas_PSS(i) = mf_calc_PSS(tas(tas_ind,i),TAS(tas_ind),0.5);
   pr_PSS(i) = mf_calc_PSS(pr(pr_ind,i),PR(pr_ind),0.1);
   sfcWind_PSS(i) = mf_calc_PSS(sfcWind(sfcWind_ind,i),SFCWIND(sfcWind_ind),0.5);
   rh_PSS(i) = mf_calc_PSS(rh(rh_ind,i),HURS(rh_ind),0.1);
    
  

end


% rank skill scores (best = 1 = first)

ind_no_rh = [3 8]; 
ind_no_sfcWind = [8]; 

% 1. bias
r_tas_bias = 1:nm;
[~,p] = sort(abs(tas_bias)); 
r_tas_bias(p) = r_tas_bias;

r_pr_bias = 1:length(RCM_all);
[~,p] = sort(abs(pr_bias)); 
r_pr_bias(p) = r_pr_bias;

r_sfcWind_bias = 1:length(RCM_adj)-1;
sfcWind_bias_cut = [sfcWind_bias(1:4) sfcWind_bias(6:12) sfcWind_bias(14:18)];
[~,p] = sort(abs(sfcWind_bias_cut)); 
r_sfcWind_bias(p) = r_sfcWind_bias;
r_sfcWind_bias= mf_insertNaN(r_sfcWind_bias, 5,13);

r_rh_bias = 1:length(RCM_adj);
rh_bias_cut = [rh_bias(1:12) rh_bias(14:18)];
[~,p] = sort(abs(rh_bias_cut)); 
r_rh_bias(p) = r_rh_bias;
r_rh_bias = mf_insertNaN(r_rh_bias, 13, 0);


% 2. Mean Absolute Error
r_tas_MAE = 1:nm;
[~,p] = sort(tas_MAE); 
r_tas_MAE(p) = r_tas_MAE;

r_pr_MAE = 1:nm;
[~,p] = sort(pr_MAE); 
r_pr_MAE(p) = r_pr_MAE;

r_sfcWind_MAE = 1:length(RCM_adj)-1;
sfcWind_MAE_cut = [sfcWind_MAE(1:4) sfcWind_MAE(6:12) sfcWind_MAE(14:18)];
[~,p] = sort(sfcWind_MAE_cut); 
r_sfcWind_MAE(p) = r_sfcWind_MAE;
r_sfcWind_MAE= mf_insertNaN(r_sfcWind_MAE, 5,13);

r_rh_MAE = 1:length(RCM_adj);
rh_MAE_cut = [rh_MAE(1:12) rh_MAE(14:18)];
[~,p] = sort(rh_MAE_cut); 
r_rh_MAE(p) = r_rh_MAE;
r_rh_MAE = mf_insertNaN(r_rh_MAE, 13, 0);

% percentiles
r_tas_MAE_1 = 1:nm;
[~,p] = sort(tas_MAE_1); 
r_tas_MAE_1(p) = r_tas_MAE_1;

r_tas_MAE_10 = 1:nm;
[~,p] = sort(tas_MAE_10); 
r_tas_MAE_10(p) = r_tas_MAE_10;

r_tas_MAE_90 = 1:nm;
[~,p] = sort(tas_MAE_90); 
r_tas_MAE_90(p) = r_tas_MAE_90;

r_tas_MAE_99 = 1:nm;
[~,p] = sort(tas_MAE_99); 
r_tas_MAE_99(p) = r_tas_MAE_99;

r_pr_MAE_1 = 1:nm;
[~,p] = sort(pr_MAE_1); 
r_pr_MAE_1(p) = r_pr_MAE_1;

r_pr_MAE_10 = 1:nm;
[~,p] = sort(pr_MAE_10); 
r_pr_MAE_10(p) = r_pr_MAE_10;

r_pr_MAE_90 = 1:nm;
[~,p] = sort(pr_MAE_90); 
r_pr_MAE_90(p) = r_pr_MAE_90;

r_pr_MAE_99 = 1:nm;
[~,p] = sort(pr_MAE_99); 
r_pr_MAE_99(p) = r_pr_MAE_99;

r_sfcWind_MAE_1 = 1:length(RCM_adj)-1;
sfcWind_MAE_cut_1 = [sfcWind_MAE_1(1:4)  sfcWind_MAE_1(6:12) sfcWind_MAE_1(14:18)];
[~,p] = sort(sfcWind_MAE_cut_1); 
r_sfcWind_MAE_1(p) = r_sfcWind_MAE_1;
r_sfcWind_MAE_1= mf_insertNaN(r_sfcWind_MAE_1, 5,13);

r_sfcWind_MAE_10 = 1:length(RCM_adj)-1;
sfcWind_MAE_cut_10 = [sfcWind_MAE_10(1:4) sfcWind_MAE_10(6:12) sfcWind_MAE_10(14:18)];
[~,p] = sort(sfcWind_MAE_cut_10); 
r_sfcWind_MAE_10(p) = r_sfcWind_MAE_10;
r_sfcWind_MAE_10= mf_insertNaN(r_sfcWind_MAE_10, 5,13);


r_sfcWind_MAE_90 = 1:length(RCM_adj)-1;
sfcWind_MAE_cut_90 = [sfcWind_MAE_90(1:4) sfcWind_MAE_90(6:12) sfcWind_MAE_90(14:18)];
[~,p] = sort(sfcWind_MAE_cut_90); 
r_sfcWind_MAE_90(p) = r_sfcWind_MAE_90;
r_sfcWind_MAE_90= mf_insertNaN(r_sfcWind_MAE_90, 5,13);


r_sfcWind_MAE_99 = 1:length(RCM_adj)-1;
sfcWind_MAE_cut_99 = [sfcWind_MAE_99(1:4) sfcWind_MAE_99(6:12) sfcWind_MAE_99(14:18)];
[~,p] = sort(sfcWind_MAE_cut_99); 
r_sfcWind_MAE_99(p) = r_sfcWind_MAE_99;
r_sfcWind_MAE_99= mf_insertNaN(r_sfcWind_MAE_99, 5,13);


r_rh_MAE_1 = 1:length(RCM_adj);
rh_MAE_cut_1 = [rh_MAE_1(1:12) rh_MAE_1(14:18)];
[~,p] = sort(rh_MAE_cut_1); 
r_rh_MAE_1(p) = r_rh_MAE_1;
r_rh_MAE_1 = mf_insertNaN(r_rh_MAE_1, 13, 0);

r_rh_MAE_10 = 1:length(RCM_adj);
rh_MAE_cut_10 = [rh_MAE_10(1:12) rh_MAE_10(14:18) ];
[~,p] = sort(rh_MAE_cut_10); 
r_rh_MAE_10(p) = r_rh_MAE_10;
r_rh_MAE_10 = mf_insertNaN(r_rh_MAE_10, 13, 0);

r_rh_MAE_90 = 1:length(RCM_adj);
rh_MAE_cut_90 = [rh_MAE_90(1:12) rh_MAE_90(14:18)];
[~,p] = sort(rh_MAE_cut_90); 
r_rh_MAE_90(p) = r_rh_MAE_90;
r_rh_MAE_90 = mf_insertNaN(r_rh_MAE_90, 13, 0);

r_rh_MAE_99 = 1:length(RCM_adj);
rh_MAE_cut_99 = [rh_MAE_99(1:12) rh_MAE_99(14:18)];
[~,p] = sort(rh_MAE_cut_99); 
r_rh_MAE_99(p) = r_rh_MAE_99;
r_rh_MAE_99 = mf_insertNaN(r_rh_MAE_99, 13, 0);


% 4. Perkins skill score
r_tas_PSS = 1:nm;
[~,p] = sort(tas_PSS,'descend'); 
r_tas_PSS(p) = r_tas_PSS;

r_pr_PSS = 1:nm;
[~,p] = sort(pr_PSS,'descend'); 
r_pr_PSS(p) = r_pr_PSS;

r_sfcWind_PSS = 1:length(RCM_adj)-1;
sfcWind_PSS_cut = [sfcWind_PSS(1:4)  sfcWind_PSS(6:12) sfcWind_PSS(14:18)];
[~,p] = sort(sfcWind_PSS_cut,'descend'); 
r_sfcWind_PSS(p) = r_sfcWind_PSS;
r_sfcWind_PSS= mf_insertNaN(r_sfcWind_PSS, 5,13);

r_rh_PSS = 1:length(RCM_adj);
rh_PSS_cut = [rh_PSS(1:12) rh_PSS(14:18)];
[~,p] = sort(rh_PSS_cut,'descend'); 
r_rh_PSS(p) = r_rh_PSS;
r_rh_PSS= mf_insertNaN(r_rh_PSS, 13, 0);



