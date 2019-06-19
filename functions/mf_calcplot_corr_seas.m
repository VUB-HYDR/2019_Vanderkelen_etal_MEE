% ------------------------------------------------------------------------
% function to calcualte correlations between variables of one season
% and to plot the ranking

function mf_calcplot_corr_seas(tas,pr,sfcWind,rh,TAS,PR,SFCWIND,HURS,RCM,RCM_rh,season) 

% tas - pr (9)

[taspr_corr taspr_cb taspr_obs]  = mf_calc_corr(tas,TAS, pr, PR);
%[taspr_corr taspr_cb taspr_obs]  = mf_calc_corr(tas_s,TAS_s, pr_s, PR_s);

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


%% plot correlation ranking

% merge score rankings (opposite order)
corr_rankings = [  r_taspr_corr
                      r_tassfcWind_corr
                      r_tasrh_corr
                      r_prsfcWind_corr
                      r_prrh_corr
                      r_sfcWindrh_corr       ];
% save correlations themselves to plot on figure                  
corr         = [ taspr_corr
                      tassfcWind_corr
                      tasrh_cb
                      prsfcWind_corr
                      prrh_corr
                      sfcWindrh_corr    ];
corr(find(isnan(corr_rankings)))=NaN; 

% correlation between observed variables            
corr_obs = [          taspr_obs
                      tassfcWind_obs
                      tasrh_obs
                      prsfcWind_obs
                      prrh_obs
                      sfcWindrh_obs      ];
             
var_names = {strcat('T - P (',num2str(taspr_obs,'%.3f'), ')'), ...
   strcat( 'T - Wind (',num2str(tassfcWind_obs,'%.3f'), ')'),...
   strcat( 'T - RH (',num2str(tasrh_obs,'%.3f'), ')'),...
 strcat('P - Wind (',num2str(prsfcWind_obs,'%.3f'), ')'),...
 strcat('P - RH (',num2str(prrh_obs,'%.3f'), ')'),...
 strcat('Wind - RH (',num2str(sfcWindrh_obs,'%.3f'), ')')};   

% plotting

cmap_9 = flipud(mf_colormap_cpt('YlGn 09'));
lsize = 11; %labelsize 
tsize = 14; 
axcolor = [0.3 0.3 0.3]; 
axcolor_light = [0.8 0.8 0.8]; 

figure('rend','painters','pos',[10 10 600 300]);
ax = axes;
imagesc(ax,corr_rankings,'AlphaData',~isnan(corr_rankings))
set(ax,'XTick',[0],'XtickLabel',RCM,'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor)
set(ax,'YTick',[1:length(corr_rankings)],'YtickLabel',var_names,'ycolor', axcolor,...
    'Fontsize', lsize, 'Fontweight', 'Bold','TickLength',[0 0])
colormap(cmap_9)
c = colorbar;
colorbar('Ticks',[1.4 2.35 3.2 4.1 5 5.85 6.8 7.7 8.5], 'TickLabels', [1:9],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title([ season ],...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)
set(gca,'color',[0.8 0.8 0.8]);


for i = 1:size(corr,1)
    for j = 1:size(corr,2)
        y = i+0.25;
        x = j-0.22; 
        if ~isnan(corr(i,j))
            if corr_rankings(i,j) < 3
            text(x,y,num2str(corr(i,j),'%.2f'),'Color',axcolor_light,'Fontsize',9);  
            else
            text(x,y,num2str(corr(i,j),'%.2f'),'Color',axcolor,'Fontsize',9);  
            end
        end
    end
end
end


