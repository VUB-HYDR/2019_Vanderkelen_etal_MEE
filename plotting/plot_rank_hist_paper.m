% -----------------------------------------------------------------------
% Script to plot the ranking of all scores per variable for the historical
% runs 

close all
% define colors 
cmap_18 = flipud(mf_colormap_cpt('YlGn 09'));
cmap_17 = flipud(mf_colormap_cpt('YlGn 09'));
cmap_16 = flipud(mf_colormap_cpt('YlGn 08'));

cmap = mf_colormap_cpt('YlGn 08');

lsize = 11; %labelsize 
tsize = 12; 
axcolor = [0.3 0.3 0.3]; 

score_names = {'Bias', 'PSS', 'MAE total','MAE 1%','MAE  10%','MAE  90%','MAE  99%'};  
  

%% tas

% merge score rankings (opposite order)
tas_rankings = [     r_tas_bias
                     r_tas_PSS
                     r_tas_MAE
                     r_tas_MAE_1
                     r_tas_MAE_10
                     r_tas_MAE_90
                     r_tas_MAE_99 ];  
             
% plotting
figure1 = figure('pos',[10 10 700 300]);
%ax = mf_subtightplot(4,1,1,[0.03 0.01], [0.01 0.04], [0.17 0.05]); 
ax = axes;
imagesc(ax,tas_rankings,'AlphaData',~isnan(tas_rankings))
set(ax,'XTick',[0],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor)
set(ax,'YTick',[1:length(tas_rankings)],'YtickLabel',score_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_18)
c = colorbar;
colorbar('Ticks',[2.2 4.15 6.1 8 9.9 11.9 13.8 15.7 17.7], 'TickLabels', [2:2:18],...
    'Fontsize',lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
% colorbar('Ticks',[1.2 2.2 3.25 4.15 5.15 6.1 7.1 8 9 9.9 10.95 11.9 12.8 13.8 14.8 15.7 16.7 17.7], 'TickLabels', [1:18],...
%     'Fontsize',lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Mean daily temperature',...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)

% save figure
filename = strcat('ranking_hist_tas.png');
pathname = '/home/inne/documents/sideprojects/ecotrons/scripts/matlab/plots/ranking'; 
saveas(figure1,fullfile(pathname, filename))

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
figure2 = figure('pos',[10 10 700 300]);

%ax = mf_subtightplot(4,1,2,[0.03 0.01], [0.01 0.04], [0.17 0.05]); 
ax = axes;
imagesc(ax,pr_rankings,'AlphaData',~isnan(pr_rankings))
set(ax,'XTick',[0],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor,'TickLength',[0 0])
set(ax,'YTick',[1:length(tas_rankings)],'YtickLabel',score_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_18)
c = colorbar;
colorbar('Ticks',[2.2 4.15 6.1 8 9.9 11.9 13.8 15.7 17.7], 'TickLabels', [2:2:18],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Mean daily precipitation',...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)
set(gca,'color',[0.8 0.8 0.8]);

% save figure
filename = strcat('ranking_hist_pr.png');
saveas(figure2,fullfile(pathname, filename))


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
figure3 = figure('pos',[10 10 700 300]);

%ax = mf_subtightplot(4,1,3,[0.05 0.01], [0.01 0.04], [0.17 0.05]); 
ax = axes; 
imagesc(ax,rh_rankings,'AlphaData',~isnan(rh_rankings))
set(ax,'XTick',[0],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor,'TickLength',[0 0])
set(ax,'YTick',[1:length(tas_rankings)],'YtickLabel',score_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_18)
c = colorbar;
colorbar('Ticks',[1.2 3.25  5.15 7.1  9  10.95  12.8  14.8  16.7 ], 'TickLabels', [1:2:17],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Mean daily relative humidity',...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)
set(gca,'color',[0.8 0.8 0.8]);


% save figure
filename = strcat('ranking_hist_rh.png');
saveas(figure3,fullfile(pathname, filename))
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
figure4 = figure('pos',[10 10 700 300]);

%ax = mf_subtightplot(4,1,4,[0.03 0.01], [0.07 0.04], [0.17 0.05]); 
ax = axes; 
imagesc(ax,sfcWind_rankings,'AlphaData',~isnan(sfcWind_rankings))
set(ax,'XTick',[ 0],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(ax,'YTick',[1:length(tas_rankings)],'YtickLabel',score_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_16)
c = colorbar;
 colorbar('Ticks',[ 2.3 4.2 6.1 8  10  11.8  13.7  15.6 ], 'TickLabels', [2:2:16],...
     'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)

% colorbar('Ticks',[1.4 2.3 3.3 4.2 5.2 6.1 7.2 8 9 10 10.9 11.8 12.8 13.7 14.7 15.6 ], 'TickLabels', [1:16],...
%     'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Mean daily surface wind speed',...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)
set(gca,'color',[0.8 0.8 0.8]);

% save figure
filename = strcat('ranking_hist_sfcWind.png');
saveas(figure4,fullfile(pathname, filename))

