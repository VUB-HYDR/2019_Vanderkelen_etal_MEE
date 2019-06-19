% -----------------------------------------------------------------------
% Script to calculate and plot correlations per season for historical
% period
% -----------------------------------------------------------------------
close all

% Calculate correlations per season
seasons = {'DJF','JJA',}; 

date = date_hist; 
for i = 1:length(seasons)
    [tas_s] = mf_sep_seasons(tas,date,seasons{i}); 
    [TAS_s] = mf_sep_seasons(TAS,date,seasons(i)); 
    [pr_s] = mf_sep_seasons(pr,date,seasons{i}); 
    [PR_s] = mf_sep_seasons(PR,date,seasons{i}); 
    [sfcWind_s] = mf_sep_seasons(sfcWind,date,seasons{i}); 
    [SFCWIND_s] = mf_sep_seasons(SFCWIND,date,seasons{i}); 
    [rh_s] = mf_sep_seasons(rh,date,seasons{i}); 
    [HURS_s] = mf_sep_seasons(HURS,date,seasons{i}); 
   
    mf_calcplot_corr_seas_hist(tas_s,pr_s,sfcWind_s,rh_s,TAS_s,PR_s,SFCWIND_s,HURS_s,RCM_all,RCM_adj,RCM_text,GCM_text,seasons{i}) 

end

%% plot annual correlation ranking

% merge score rankings (opposite order)
corr_rankings = [  r_taspr_corr
                      r_tassfcWind_corr
                      r_tasrh_corr
                      r_prsfcWind_corr
                      r_prrh_corr
                      r_sfcWindrh_corr       ];
                  
corr         = [ taspr_corr
                      tassfcWind_corr
                      tasrh_corr
                      prsfcWind_corr
                      prrh_corr
                      sfcWindrh_corr      ];
                  
corr(find(isnan(corr_rankings))) = NaN;   

% correlation between observed variables            
corr_obs = [          taspr_obs
                      tassfcWind_obs
                      tasrh_obs
                      prsfcWind_obs
                      prrh_obs
                      sfcWindrh_obs      ];
             
var_names = {strcat('T - P (',num2str(taspr_obs,'%.4f'), ')'), ...
   strcat( 'T - Wind (',num2str(tassfcWind_obs,'%.4f'), ')'),...
   strcat( 'T - RH (',num2str(tasrh_obs,'%.4f'), ')'),...
 strcat('P - Wind (',num2str(prsfcWind_obs,'%.4f'), ')'),...
 strcat('P - RH (',num2str(prrh_obs,'%.4f'), ')'),...
 strcat('Wind - RH (',num2str(sfcWindrh_obs,'%.4f'), ')')};   

% plotting
% plotting
lsize = 11; 
tsize = 14; 
cmap_17 = flipud(mf_colormap_cpt('YlGn 09'));
axcolor = [0.3 0.3 0.3]; 
axcolor_light = [0.8 0.8 0.8]; 

figure1 = figure('pos',[10 10 900 400]);
ax = axes;
imagesc(ax,corr_rankings,'AlphaData',~isnan(corr_rankings))
set(ax,'XTick',[0],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor)
set(ax,'YTick',[1:length(corr_rankings)],'YtickLabel',var_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_17)
c = colorbar;
colorbar('Ticks',[2.2 4.15 6.1 8 9.9 11.9 13.8 15.7 17.7], 'TickLabels', [2:2:18],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Annual correlation',...
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

