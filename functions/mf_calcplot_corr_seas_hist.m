% ------------------------------------------------------------------------
% function to calcualte correlations between variables of one season
% and to plot the ranking

function mf_calcplot_corr_seas_hist(tas,pr,sfcWind,rh,TAS,PR,SFCWIND,HURS,RCM_all,RCM_adj,RCM_text,GCM_text,season) 

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

cmap_17 = flipud(mf_colormap_cpt('YlGn 09'));
lsize = 11; %labelsize 
tsize = 14; 
axcolor = [0.3 0.3 0.3]; 
axcolor_light = [0.8 0.8 0.8]; 

figure1 = figure('pos',[10 10 900 400]);
ax = axes;
imagesc(ax,corr_rankings,'AlphaData',~isnan(corr_rankings))
set(ax,'XTick',[0],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor)
set(ax,'YTick',[1:length(corr_rankings)],'YtickLabel',var_names,'ycolor', axcolor,...
    'Fontsize', lsize, 'Fontweight', 'Bold','TickLength',[0 0])
colormap(cmap_17)
c = colorbar;
colorbar('Ticks',[2.2 4.15 6.1 8 9.9 11.9 13.8 15.7 17.7], 'TickLabels', [2:2:18],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title([ season],...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)
set(gca,'color',[0.8 0.8 0.8]);


for i = 1:size(corr,1)
    for j = 1:size(corr,2)
        y = i+0.3;
        x = j-0.3; 
        
        if ~isnan(corr(i,j))
            if corr_rankings(i,j) < 6
            text(x,y,num2str(corr(i,j),'%.2f'),'Color',axcolor_light,'Fontsize',9);  
            else
            text(x,y,num2str(corr(i,j),'%.2f'),'Color',axcolor,'Fontsize',9);  
            end
        end
    end
end

end


