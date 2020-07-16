% ------------------------------------------------------------------------
% Script to calcualte correlations between variables 
% 


% tas - pr (9)
[taspr_corr taspr_cb taspr_obs]= mf_calc_corr(tas,TAS, pr, PR);

r_taspr_corr = 1:length(RCM_all);
[~,p] = sort(abs(taspr_cb)); 
r_taspr_corr(p) = r_taspr_corr;


% tas - sfcWind (8)

[tassfcWind_corr tassfcWind_cb tassfcWind_obs]= mf_calc_corr(tas,TAS,sfcWind,SFCWIND);

r_tassfcWind_corr = 1:length(RCM_adj)-1;
tassfcWind_cb_cut = [tassfcWind_cb(1:4) tassfcWind_cb(6:12)  tassfcWind_cb(14:18)];
[~,p] = sort(abs(tassfcWind_cb_cut)); 
r_tassfcWind_corr(p) = r_tassfcWind_corr;
r_tassfcWind_corr = mf_insertNaN(r_tassfcWind_corr, 5, 13);


% tas - rh (7)
[tasrh_corr tasrh_cb  tasrh_obs]= mf_calc_corr(tas,TAS, rh, HURS);

r_tasrh_corr = 1:length(RCM_adj);
tasrh_cb_cut = [tasrh_cb(1:12) tasrh_cb(14:18)];
[~,p] = sort(abs(tasrh_cb_cut)); 
r_tasrh_corr(p) = r_tasrh_corr;
r_tasrh_corr = mf_insertNaN(r_tasrh_corr, 13, 0);


% pr-sfcWind (8)
[prsfcWind_corr prsfcWind_cb prsfcWind_obs ]= mf_calc_corr( pr, PR,sfcWind,SFCWIND);

prsfcWind_cb_cut = [prsfcWind_cb(1:4) prsfcWind_cb(6:12) prsfcWind_cb(14:18)];
r_prsfcWind_corr = 1:length(RCM_adj)-1;
[~,p] = sort(abs(prsfcWind_cb_cut)); 
r_prsfcWind_corr(p) = r_prsfcWind_corr;
r_prsfcWind_corr = mf_insertNaN(r_prsfcWind_corr, 5, 13);


% pr - rh (7)
[prrh_corr prrh_cb prrh_obs] = mf_calc_corr(pr, PR, rh, HURS);

prrh_cb_cut = [prrh_cb(1:12) prrh_cb(14:18)];
r_prrh_corr = 1:length(RCM_adj);
[~,p] = sort(abs(prrh_cb_cut)); 
r_prrh_corr(p) = r_prrh_corr;
r_prrh_corr = mf_insertNaN(r_prrh_corr, 13, 0);


% sfcWind - rh (7)
[sfcWindrh_corr sfcWindrh_cb sfcWindrh_obs] = mf_calc_corr(sfcWind,SFCWIND, rh, HURS);

sfcWindrh_cb_cut = [sfcWindrh_cb(1:4) sfcWindrh_cb(6:12) sfcWindrh_cb(14:18)];
r_sfcWindrh_corr = 1:length(RCM_adj)-1;
[~,p] = sort(abs(sfcWindrh_cb_cut)); 
r_sfcWindrh_corr(p) = r_sfcWindrh_corr;
r_sfcWindrh_corr = mf_insertNaN(r_sfcWindrh_corr, 5, 13);


