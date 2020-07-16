% --------------------------------------------------------------------------
% Script to calculate scores for EURcordex model data for each ecotron pixel
% and calculatea scores

% for variables: 
%               - tas
%               - pr
%               - rh
%               - sfcWind

% index gives all observations without NaNs
pr_ind =find(~isnan(PR));
tas_ind = find(~isnan(TAS));
rh_ind =find(~isnan(HURS));
sfcWind_ind = find(~isnan(SFCWIND));

% calculate seasonal cycle for MAE calculation
% of model data
for i = 1:nm

   tas_seas(:,i) = mf_calc_seascycle(tas(:,i),date_eval, 'day');
   pr_seas(:,i)  = mf_calc_seascycle(pr(:,i),date_eval,'day');
   
   sfcWind_seas(:,i)  = mf_calc_seascycle(sfcWind(:,i),date_eval,'day');

   rh_seas(:,i)  = mf_calc_seascycle(rh(:,i),date_eval,'day');

end

% of observations
TAS_seas = mf_calc_seascycle(TAS,date_eval, 'day')';
PR_seas = mf_calc_seascycle(PR,date_eval,'day')';
SFCWIND_seas = mf_calc_seascycle(SFCWIND,date_eval, 'day')';
HURS_seas = mf_calc_seascycle(HURS,date_eval,'day')';



% tas and pr for all RCMs
for i = 1:length(RCM)
   
   % 1. Bias (mean, systematic error) 
   tas_bias(i) = mean(tas(tas_ind,i))- mean(TAS(tas_ind)); 
   pr_bias(i) =  mean(pr(pr_ind,i))- mean(PR(pr_ind)); 
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

   % 3. Root Mean Square Error (RMSE)
   tas_RMSE(i) =sqrt(mean((tas(tas_ind,i)-TAS(tas_ind)).^2)); 
   pr_RMSE(i)  =sqrt(mean( (pr(pr_ind,i)- PR(pr_ind)).^2));
   sfcWind_RMSE(i) =sqrt(mean((sfcWind(sfcWind_ind,i)-SFCWIND(sfcWind_ind)).^2)); 
   rh_RMSE(i)  =sqrt(mean( (rh(rh_ind,i)- HURS(rh_ind)).^2));
   
   
   % 4. Perkins skill score: measuring similarity of pdfs
   tas_PSS(i) = mf_calc_PSS(tas(tas_ind,i),TAS(tas_ind),0.5);
   pr_PSS(i) = mf_calc_PSS(pr(pr_ind,i),PR(pr_ind),0.1);
   sfcWind_PSS(i) = mf_calc_PSS(sfcWind(sfcWind_ind,i),SFCWIND(sfcWind_ind),0.5);
   rh_PSS(i) = mf_calc_PSS(rh(rh_ind,i),HURS(rh_ind),0.1);
    
   
   % 5. linear correlation coefficient 
   tas_corrcoef(i) = spear(TAS(tas_ind),tas(tas_ind,i));

   pr_corrcoef(i) = spear(PR(pr_ind),pr(pr_ind,i));
   
   sfcWind_corrcoef(i) = spear(SFCWIND(sfcWind_ind),sfcWind(sfcWind_ind,i));

   rh_corrcoef(i) = spear(HURS(rh_ind),rh(rh_ind,i));

       
   % 6. Brier score (Reduction of Variance; Nash Sutcliffe efficiency)
   tas_SS(i) = 1-((mean((tas(tas_ind,i)-TAS(tas_ind)).^2))/(var(TAS(tas_ind))).^2); 
   pr_SS(i) = 1-((mean((pr(pr_ind,i)-PR(pr_ind)).^2))/(var(PR(pr_ind))).^2); 
   sfcWind_SS(i) = 1-((mean((sfcWind(sfcWind_ind,i)-SFCWIND(sfcWind_ind)).^2))/(var(SFCWIND(sfcWind_ind))).^2); 
   rh_SS(i) = 1-((mean((rh(rh_ind,i)-HURS(rh_ind)).^2))/(var(HURS(rh_ind))).^2); 


   % extra  
   
   % covariance
   tas_cov_matrix(:,:,i) = cov(TAS(tas_ind),tas(tas_ind,i)); 
   tas_cov(i) =  tas_cov_matrix(1,2,i); 
   
   pr_cov_matrix(:,:,i) = cov(PR(pr_ind),pr(pr_ind,i)); 
   pr_cov(i) =  pr_cov_matrix(1,2,i); 
   
   sfcWind_cov_matrix(:,:,i) = cov(SFCWIND(sfcWind_ind),sfcWind(sfcWind_ind,i)); 
   sfcWind_cov(i) =  sfcWind_cov_matrix(1,2,i); 
   
   rh_cov_matrix(:,:,i) = cov(HURS(rh_ind),rh(rh_ind,i)); 
   rh_cov(i) =  rh_cov_matrix(1,2,i); 
   

end


% rank skill scores (best = 1 = first)

ind_no_rh = [3 8]; 
ind_no_sfcWind = [8]; 

% 1. bias
r_tas_bias = 1:length(RCM);
[~,p] = sort(abs(tas_bias)); 
r_tas_bias(p) = r_tas_bias;

r_pr_bias = 1:length(RCM);
[~,p] = sort(abs(pr_bias)); 
r_pr_bias(p) = r_pr_bias;

r_sfcWind_bias = 1:length(RCM_rh);
sfcWind_bias_cut = [sfcWind_bias(1) sfcWind_bias(3:7) sfcWind_bias(9)];
[~,p] = sort(abs(sfcWind_bias_cut)); 
r_sfcWind_bias(p) = r_sfcWind_bias;
r_sfcWind_bias = mf_insertNaN(r_sfcWind_bias,  2, 8);

r_rh_bias = 1:length(RCM_rh);
rh_bias_cut = [rh_bias(1:2) rh_bias(4:7) rh_bias(9)];
[~,p] = sort(abs(rh_bias_cut)); 
r_rh_bias(p) = r_rh_bias;
r_rh_bias = mf_insertNaN(r_rh_bias, 3, 8);


% 2. Mean Absolute Error
r_tas_MAE = 1:length(RCM);
[~,p] = sort(tas_MAE); 
r_tas_MAE(p) = r_tas_MAE;

r_pr_MAE = 1:length(RCM);
[~,p] = sort(pr_MAE); 
r_pr_MAE(p) = r_pr_MAE;

r_sfcWind_MAE = 1:length(RCM_rh);
sfcWind_MAE_cut = [sfcWind_MAE(1) sfcWind_MAE(3:7) sfcWind_MAE(9)];
[~,p] = sort(sfcWind_MAE_cut); 
r_sfcWind_MAE(p) = r_sfcWind_MAE;
r_sfcWind_MAE = mf_insertNaN(r_sfcWind_MAE, 2, 8);


r_rh_MAE = 1:length(RCM_rh);
rh_MAE_cut = [rh_MAE(1:2) rh_MAE(4:7) rh_MAE(9)];
[~,p] = sort(rh_MAE_cut); 
r_rh_MAE(p) = r_rh_MAE;
r_rh_MAE = mf_insertNaN(r_rh_MAE, 3, 8);

% percentiles
r_tas_MAE_1 = 1:length(RCM);
[~,p] = sort(tas_MAE_1); 
r_tas_MAE_1(p) = r_tas_MAE_1;

r_tas_MAE_10 = 1:length(RCM);
[~,p] = sort(tas_MAE_10); 
r_tas_MAE_10(p) = r_tas_MAE_10;

r_tas_MAE_90 = 1:length(RCM);
[~,p] = sort(tas_MAE_90); 
r_tas_MAE_90(p) = r_tas_MAE_90;

r_tas_MAE_99 = 1:length(RCM);
[~,p] = sort(tas_MAE_99); 
r_tas_MAE_99(p) = r_tas_MAE_99;

r_pr_MAE_1 = 1:length(RCM);
[~,p] = sort(pr_MAE_1); 
r_pr_MAE_1(p) = r_pr_MAE_1;

r_pr_MAE_10 = 1:length(RCM);
[~,p] = sort(pr_MAE_10); 
r_pr_MAE_10(p) = r_pr_MAE_10;

r_pr_MAE_90 = 1:length(RCM);
[~,p] = sort(pr_MAE_90); 
r_pr_MAE_90(p) = r_pr_MAE_90;

r_pr_MAE_99 = 1:length(RCM);
[~,p] = sort(pr_MAE_99); 
r_pr_MAE_99(p) = r_pr_MAE_99;

r_sfcWind_MAE_1 = 1:length(RCM_rh);
sfcWind_MAE_cut_1 = [sfcWind_MAE_1(1) sfcWind_MAE_1(3:7) sfcWind_MAE_1(9)];
[~,p] = sort(sfcWind_MAE_cut_1); 
r_sfcWind_MAE_1(p) = r_sfcWind_MAE_1;
r_sfcWind_MAE_1 = mf_insertNaN(r_sfcWind_MAE_1,  2, 8);

r_sfcWind_MAE_10 = 1:length(RCM_rh);
sfcWind_MAE_cut_10 = [sfcWind_MAE_10(1) sfcWind_MAE_10(3:7) sfcWind_MAE_10(9)];
[~,p] = sort(sfcWind_MAE_cut_10); 
r_sfcWind_MAE_10(p) = r_sfcWind_MAE_10;
r_sfcWind_MAE_10 = mf_insertNaN(r_sfcWind_MAE_10,  2, 8);


r_sfcWind_MAE_90 = 1:length(RCM_rh);
sfcWind_MAE_cut_90 = [sfcWind_MAE_90(1) sfcWind_MAE_90(3:7) sfcWind_MAE_90(9)];
[~,p] = sort(sfcWind_MAE_cut_90); 
r_sfcWind_MAE_90(p) = r_sfcWind_MAE_90;
r_sfcWind_MAE_90 = mf_insertNaN(r_sfcWind_MAE_90, 2, 8);


r_sfcWind_MAE_99 = 1:length(RCM_rh);
sfcWind_MAE_cut_99 = [sfcWind_MAE_99(1) sfcWind_MAE_99(3:7) sfcWind_MAE_99(9)];
[~,p] = sort(sfcWind_MAE_cut_99); 
r_sfcWind_MAE_99(p) = r_sfcWind_MAE_99;
r_sfcWind_MAE_99 = mf_insertNaN(r_sfcWind_MAE_99, 2, 8);



r_rh_MAE_1 = 1:length(RCM_rh);
rh_MAE_cut_1 = [rh_MAE_1(1:2) rh_MAE_1(4:7) rh_MAE_1(9)];
[~,p] = sort(rh_MAE_cut_1); 
r_rh_MAE_1(p) = r_rh_MAE_1;
r_rh_MAE_1 = mf_insertNaN(r_rh_MAE_1, 3, 8);

r_rh_MAE_10 = 1:length(RCM_rh);
rh_MAE_cut_10 = [rh_MAE_10(1:2) rh_MAE_10(4:7) rh_MAE_10(9)];
[~,p] = sort(rh_MAE_cut_10); 
r_rh_MAE_10(p) = r_rh_MAE_10;
r_rh_MAE_10 = mf_insertNaN(r_rh_MAE_10, 3, 8);

r_rh_MAE_90 = 1:length(RCM_rh);
rh_MAE_cut_90 = [rh_MAE_90(1:2) rh_MAE_90(4:7) rh_MAE_90(9)];
[~,p] = sort(rh_MAE_cut_90); 
r_rh_MAE_90(p) = r_rh_MAE_90;
r_rh_MAE_90 = mf_insertNaN(r_rh_MAE_90, 3, 8);

r_rh_MAE_99 = 1:length(RCM_rh);
rh_MAE_cut_99 = [rh_MAE_99(1:2) rh_MAE_99(4:7) rh_MAE_99(9)];
[~,p] = sort(rh_MAE_cut_99); 
r_rh_MAE_99(p) = r_rh_MAE_99;
r_rh_MAE_99 = mf_insertNaN(r_rh_MAE_99, 3, 8);



% 3. RMSE
r_tas_RMSE = 1:length(RCM);
[~,p] = sort(tas_RMSE); 
r_tas_RMSE(p) = r_tas_RMSE;

r_pr_RMSE = 1:length(RCM);
[~,p] = sort(pr_RMSE); 
r_pr_RMSE(p) = r_pr_RMSE;

r_sfcWind_RMSE = 1:length(RCM_rh);
sfcWind_RMSE_cut = [sfcWind_RMSE(1) sfcWind_RMSE(3:7) sfcWind_RMSE(9)];
[~,p] = sort(sfcWind_RMSE_cut); 
r_sfcWind_RMSE(p) = r_sfcWind_RMSE;
r_sfcWind_RMSE = mf_insertNaN(r_sfcWind_RMSE, 2, 8);

r_rh_RMSE = 1:length(RCM_rh);
rh_RMSE_cut = [rh_RMSE(1:2) rh_RMSE(4:7) rh_RMSE(9)];
[~,p] = sort(rh_RMSE_cut); 
r_rh_RMSE(p) = r_rh_RMSE;
r_rh_RMSE = mf_insertNaN(r_rh_RMSE, 3, 8);


% 4. Perkins skill score
r_tas_PSS = 1:length(RCM);
[~,p] = sort(tas_PSS,'descend'); 
r_tas_PSS(p) = r_tas_PSS;

r_pr_PSS = 1:length(RCM);
[~,p] = sort(pr_PSS,'descend'); 
r_pr_PSS(p) = r_pr_PSS;

r_sfcWind_PSS = 1:length(RCM_rh);
sfcWind_PSS_cut = [sfcWind_PSS(1) sfcWind_PSS(3:7) sfcWind_PSS(9)];
[~,p] = sort(sfcWind_PSS_cut,'descend'); 
r_sfcWind_PSS(p) = r_sfcWind_PSS;
r_sfcWind_PSS= mf_insertNaN(r_sfcWind_PSS,  2, 8);

r_rh_PSS = 1:length(RCM_rh);
rh_PSS_cut = [rh_PSS(1:2) rh_PSS(4:7) rh_PSS(9)];
[~,p] = sort(rh_PSS_cut,'descend'); 
r_rh_PSS(p) = r_rh_PSS;
r_rh_PSS = mf_insertNaN(r_rh_PSS, 3, 8);

% 5. Linear correlation coefficient
r_tas_corrcoef = 1:length(RCM);
[~,p] = sort(tas_corrcoef,'descend'); 
r_tas_corrcoef(p) = r_tas_corrcoef;

r_pr_corrcoef = 1:length(RCM);
[~,p] = sort(pr_corrcoef,'descend'); 
r_pr_corrcoef(p) = r_pr_corrcoef;

r_sfcWind_corrcoef = 1:length(RCM_rh);
sfcWind_corrcoef_cut = [sfcWind_corrcoef(1) sfcWind_corrcoef(3:7) sfcWind_corrcoef(9)];
[~,p] = sort(sfcWind_corrcoef_cut,'descend'); 
r_sfcWind_corrcoef(p) = r_sfcWind_corrcoef;
r_sfcWind_corrcoef = mf_insertNaN(r_sfcWind_corrcoef, 2, 8);

r_rh_corrcoef = 1:length(RCM_rh);
rh_corrcoef_cut = [rh_corrcoef(1:2) rh_corrcoef(4:7) rh_corrcoef(9)];
[~,p] = sort(rh_corrcoef_cut,'descend'); 
r_rh_corrcoef(p) = r_rh_corrcoef;
r_rh_corrcoef = mf_insertNaN(r_rh_corrcoef, 3, 8);


% 6. Brier score 
r_tas_SS = 1:length(RCM);
[~,p] = sort(tas_SS,'descend'); 
r_tas_SS(p) = r_tas_SS;

r_pr_SS = 1:length(RCM);
[~,p] = sort(pr_SS,'descend'); 
r_pr_SS(p) = r_pr_SS;

r_sfcWind_SS = 1:length(RCM_rh);
sfcWind_SS_cut = [sfcWind_SS(1) sfcWind_SS(3:7) sfcWind_SS(9)];
[~,p] = sort(sfcWind_SS_cut,'descend'); 
r_sfcWind_SS(p) = r_sfcWind_SS;
r_sfcWind_SS = mf_insertNaN(r_sfcWind_SS, 2, 8);

r_rh_SS = 1:length(RCM_rh);
rh_SS_cut = [rh_SS(1:2) rh_SS(4:7) rh_SS(9)];
[~,p] = sort(rh_SS_cut,'descend'); 
r_rh_SS(p) = r_rh_SS;
r_rh_SS = mf_insertNaN(r_rh_SS, 3, 8);


