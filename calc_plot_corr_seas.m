% ------------------------------------------------------------------------
% Script to calculate and plot correlations per season for evaluation
% simulations

% Calculate correlations per season
seasons = {'DJF','MAM','JJA','SON'}; 

    for i = 1:length(seasons)
      date = date_eval; 
      [tas_s] = mf_sep_seasons(tas,date,seasons{i}); 
        [TAS_s] = mf_sep_seasons(TAS,date,seasons(i)); 
        [pr_s] = mf_sep_seasons(pr,date,seasons{i}); 
        [PR_s] = mf_sep_seasons(PR,date,seasons{i}); 
        [sfcWind_s] = mf_sep_seasons(sfcWind,date,seasons{i}); 
        [SFCWIND_s] = mf_sep_seasons(SFCWIND,date,seasons{i}); 
        [rh_s] = mf_sep_seasons(rh,date,seasons{i}); 
        [HURS_s] = mf_sep_seasons(HURS,date,seasons{i}); 

        mf_calcplot_corr_seas(tas_s,pr_s,sfcWind_s,rh_s,TAS_s,PR_s,SFCWIND_s,HURS_s,RCM,RCM_rh,seasons{i}) 

    end

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
lsize = 11; 
tsize = 14; 
cmap_9 = flipud(mf_colormap_cpt('YlGn 09'));
axcolor = [0.3 0.3 0.3]; 
axcolor_light = [0.8 0.8 0.8]; 

figure('rend','painters','pos',[10 10 600 300]);ax = axes;
imagesc(ax,corr_rankings,'AlphaData',~isnan(corr_rankings))
set(ax,'XTick',[0],'XtickLabel',RCM,'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor)
set(ax,'YTick',[1:length(corr_rankings)],'YtickLabel',var_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_9)
c = colorbar;
colorbar('Ticks',[1.4 2.35 3.2 4.1 5 5.85 6.8 7.7 8.5], 'TickLabels', [1:9],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Annual correlation',...
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
