% -----------------------------------------------------------------------
% Script to plot the ranking of all scores per variable for the historical
% runs 

close all
% define colors 
cmap_18 = flipud(mf_colormap_cpt('RdYlGn 09'));
cmap_17 = flipud(mf_colormap_cpt('RdYlGn 09'));
cmap_16 = flipud(mf_colormap_cpt('RdYlGn 08'));

cmap = mf_colormap_cpt('RdYlGn 08');

lsize = 14; %labelsize 
tsize = 18; 
axcolor = [0.3 0.3 0.3]; 

score_names = {'Bias', 'PSS', 'MAE total','MAE    1%','MAE  10%','MAE  90%','MAE  99%'};  
  

%%tas

% merge score rankings (opposite order)
tas_rankings = [     r_tas_bias
                     r_tas_PSS
                     r_tas_MAE
                     r_tas_MAE_1
                     r_tas_MAE_10
                     r_tas_MAE_90
                     r_tas_MAE_99 ];  
             
% plotting
figure()
ax = axes;
imagesc(ax,tas_rankings,'AlphaData',~isnan(tas_rankings))
set(ax,'XTick',[1:18],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor)
set(ax,'YTick',[1:length(tas_rankings)],'YtickLabel',score_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_18)
c = colorbar;
colorbar('Ticks',[1.2 2.2 3.25 4.15 5.15 6.1 7.1 8 9 9.9 10.95 11.9 12.8 13.8 14.8 15.7 16.7 17.7], 'TickLabels', [1:18],...
    'Fontsize',lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Mean daily temperature',...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)



%% pr

% merge score rankings (opposite order)
pr_rankings = [      r_pr_bias
                     r_pr_PSS
                     r_pr_MAE
                     r_pr_MAE_1
                     r_pr_MAE_10
                     r_pr_MAE_90
                     r_pr_MAE_99      ]; 

% plotting

figure()
ax = axes;
imagesc(ax,pr_rankings,'AlphaData',~isnan(pr_rankings))
set(ax,'XTick',[1:18],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor,'TickLength',[0 0])
set(ax,'YTick',[1:length(tas_rankings)],'YtickLabel',score_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_18)
c = colorbar;
colorbar('Ticks',[1.2 2.2 3.25 4.15 5.15 6.1 7.1 8 9 9.9 10.95 11.9 12.8 13.8 14.8 15.7 16.7 17.7], 'TickLabels', [1:18],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Mean daily precipitation',...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)
set(gca,'color',[0.8 0.8 0.8]);

%% rh

% merge score rankings (opposite order)
rh_rankings = [  r_rh_bias
                 r_rh_PSS
                 r_rh_MAE
                 r_rh_MAE_1
                 r_rh_MAE_10
                 r_rh_MAE_90
                 r_rh_MAE_99];
             

% plotting

figure()
ax = axes;
imagesc(ax,rh_rankings,'AlphaData',~isnan(rh_rankings))
set(ax,'XTick',[1:18],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor,'TickLength',[0 0])
set(ax,'YTick',[1:length(tas_rankings)],'YtickLabel',score_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_18)
c = colorbar;
colorbar('Ticks',[1:1:18], 'TickLabels', [1:18],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Mean daily relative humidity',...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)
set(gca,'color',[0.8 0.8 0.8]);

%% sfcWind

% merge score rankings (opposite order)
sfcWind_rankings = [ r_sfcWind_bias
                     r_sfcWind_PSS   
                     r_sfcWind_MAE
                     r_sfcWind_MAE_1
                     r_sfcWind_MAE_10
                     r_sfcWind_MAE_90
                     r_sfcWind_MAE_99]; 
  
% plotting

figure()
ax = axes;
imagesc(ax,sfcWind_rankings,'AlphaData',~isnan(sfcWind_rankings))
set(ax,'XTick',[1:18],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor)
set(ax,'YTick',[1:length(tas_rankings)],'YtickLabel',score_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_16)
c = colorbar;
colorbar('Ticks',[1.4 2.3 3.3 4.2 5.2 6.1 7.2 8 9 10 10.9 11.8 12.8 13.7 14.7 15.6 ], 'TickLabels', [1:16],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Mean daily surface wind speed',...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)
set(gca,'color',[0.8 0.8 0.8]);


%% plot correlation ranking

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

figure()
ax = axes;
imagesc(ax,corr_rankings,'AlphaData',~isnan(corr_rankings))
set(ax,'XTick',[1:18],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor)
set(ax,'YTick',[1:length(corr_rankings)],'YtickLabel',var_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_17)
c = colorbar;
colorbar('Ticks',[1.2 2.2 3.25 4.15 5.15 6.1 7.1 8 9 9.9 10.95 11.9 12.8 13.8 14.8 15.7 16.7 17.7], 'TickLabels', [1:18],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Correlation',...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)
set(gca,'color',[0.8 0.8 0.8]);


for i = 1:size(corr,1)
    for j = 1:size(corr,2)
        y = i+0.3;
        x = j-0.25; 
        
        if ~isnan(corr(i,j))
        text(x,y,num2str(corr(i,j),'%.2f'),'Color',axcolor,'Fontsize',20);      
        end
    end
end

%% plot seasonal cycle ranking

% merge score rankings (opposite order)
seas_rankings = [     r_dtr
                      r_dtr_DJF
                      r_dtr_JJA
                      r_wdays
                      r_wdays1
                      r_frdays
                      r_pr_monmax
                      r_cdd
                      r_cwd];
             
seasvar_names = {strcat('DTR (',num2str(mean(DTR),'%.1f'), ' K)'), ...
    strcat('DTR winter (',num2str(mean(DTR_DJF),'%.1f'), ' K)'), ...
    strcat('DTR summer (',num2str(mean(DTR_JJA),'%.1f'), ' K)'), ...
    strcat('Wet days 0mm (',num2str(fwdays_obs,'%.1f'), ' %)'), ...
    strcat('Wet days 1mm (',num2str(fwdays_obs1,'%.1f'), ' %)'), ...
    strcat('Frost days (',num2str(ffrdays_obs,'%.1f'), ' %)'), ...
    strcat('PRx1day  (',num2str(mean(PR_monmax),'%.1f'), ' mm/day)'), ...
    strcat('CDD (',num2str(mean(CDD_max),'%.1f'), ' days)'), ...
    strcat('CWD (',num2str(mean(CWD_max),'%.1f'), ' days)'), ...

    };  

save seas_rankings_hist.mat seas_rankings
save seasvar_names_hist.mat seasvar_names
% plotting

figure()
ax = axes;
imagesc(ax,seas_rankings,'AlphaData',~isnan(seas_rankings))
set(ax,'XTick',[1:18],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor)
set(ax,'YTick',[1:length(seas_rankings)],'YtickLabel',seasvar_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_17)
c = colorbar;
colorbar('Ticks',[1.2 2.2 3.25 4.15 5.15 6.1 7.1 8 9 9.9 10.95 11.9 12.8 13.8 14.8 15.7 16.7 17.7], 'TickLabels', [1:18],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Bias related to the annual cycle',...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)
set(gca,'color',[0.8 0.8 0.8]);
