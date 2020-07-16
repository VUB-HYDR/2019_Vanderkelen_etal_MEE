% ------------------------------------------------------------------------
% Script to calcualte correlations between variables 
% and to plot the ranking


% tas - pr (9)

[taspr_corr taspr_cb taspr_obs]  = mf_calc_corr(tas,TAS, pr, PR);

r_taspr_corr = 1:length(RCM);
[test,p] = sort(abs(taspr_cb),'ascend'); 
r_taspr_corr(p) = r_taspr_corr;

% tas - sfcWind (8)

[tassfcWind_corr tassfcWind_cb tassfcWind_obs] = mf_calc_corr(tas,TAS,sfcWind,SFCWIND);

r_tassfcWind_corr = 1:length(RCM_rh);
tassfcWind_cb_cut = [ tassfcWind_cb(1) tassfcWind_cb(3:7) tassfcWind_cb(9)];
[~,p] = sort(abs(tassfcWind_cb_cut),'ascend'); 
r_tassfcWind_corr(p) = r_tassfcWind_corr;
r_tassfcWind_corr = mf_insertNaN(r_tassfcWind_corr, 2,8);


% tas - rh (7)
[tasrh_corr tasrh_cb tasrh_obs] = mf_calc_corr(tas,TAS, rh, HURS);

r_tasrh_corr = 1:length(RCM_rh);
tasrh_cb_cut = [tasrh_cb(1:2) tasrh_cb(4:7) tasrh_cb(9)];
[~,p] = sort(abs(tasrh_cb_cut),'ascend'); 
r_tasrh_corr(p) = r_tasrh_corr;
r_tasrh_corr = mf_insertNaN(r_tasrh_corr, 3, 8);


% pr-sfcWind (8)
[prsfcWind_corr prsfcWind_cb prsfcWind_obs]= mf_calc_corr( pr, PR,sfcWind,SFCWIND);

prsfcWind_cb_cut = [prsfcWind_cb(1) prsfcWind_cb(3:7) prsfcWind_cb(9)];
r_prsfcWind_corr = 1:length(RCM_rh);
[~,p] = sort(abs(prsfcWind_cb_cut),'ascend'); 
r_prsfcWind_corr(p) = r_prsfcWind_corr;
r_prsfcWind_corr = mf_insertNaN(r_prsfcWind_corr, 2,8);


% pr - rh (7)
[prrh_corr prrh_cb prrh_obs]= mf_calc_corr(pr, PR, rh, HURS);

prrh_cb_cut = [prrh_cb(1:2) prrh_cb(4:7) prrh_cb(9)];
r_prrh_corr = 1:length(RCM_rh);
[~,p] = sort(abs(prrh_cb_cut),'ascend'); 
r_prrh_corr(p) = r_prrh_corr;
r_prrh_corr = mf_insertNaN(r_prrh_corr, 3, 8);


% sfcWind - rh (7)
[sfcWindrh_corr sfcWindrh_cb sfcWindrh_obs]= mf_calc_corr(sfcWind,SFCWIND, rh, HURS);

sfcWindrh_cb_cut = [sfcWindrh_cb(1) sfcWindrh_cb(4:7) sfcWindrh_cb(9)];
r_sfcWindrh_corr = 1:length(RCM_rh)-1;
[~,p] = sort(abs(sfcWindrh_cb_cut),'ascend'); 
r_sfcWindrh_corr(p) = r_sfcWindrh_corr;
r_sfcWindrh_corr = mf_insertNaN(r_sfcWindrh_corr, 2, 3);
r_sfcWindrh_corr = mf_insertNaN(r_sfcWindrh_corr, 8, 0);





