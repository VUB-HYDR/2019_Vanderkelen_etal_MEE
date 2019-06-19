% -----------------------------------------------------------------------
% Script to plot ranks for biases of physical values (both evaluation and
% historical runs). Paper figure
% -----------------------------------------------------------------------

figure('rend','painters','pos',[10 10 1400 800])

close all
% define colors 
cmap_9 = flipud(mf_colormap_cpt('YlGn 09'));
cmap_7 = flipud(mf_colormap_cpt('YlGn 07'));
cmap_8 = flipud(mf_colormap_cpt('YlGn 08'));
cmap_18 = flipud(mf_colormap_cpt('YlGn 09'));
cmap_17 = flipud(mf_colormap_cpt('YlGn 09'));
cmap_16 = flipud(mf_colormap_cpt('YlGn 08'));

cmap = mf_colormap_cpt('RdYlGn 08');

lsize = 11; %labelsize 
tsize = 12; 
axcolor = [0.3 0.3 0.3]; 

%% plot eval 
load seas_rankings_eval
load seasvar_names_eval 

figure('rend','painters','pos',[10 10 1200 400]);


% plotting
ax1 = mf_subtightplot(1,2,1,[0.01,0.03],[0.32 0.1],[0.15 0.16]);
imagesc(ax1,seas_rankings_eval,'AlphaData',~isnan(seas_rankings_eval))
set(ax1,'XTick',[1:9],'XtickLabel',RCM,'XTickLabelRotation',45,...
    'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(ax1,'YTick',[1:length(seas_rankings_eval)],'YtickLabel',seasvar_names,...
    'Fontsize', lsize, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_7)
c = colorbar;
colorbar('Ticks',[1.4 2.35 3.2 4.1 5 5.85 6.8 7.7 8.5], 'TickLabels', [1:9],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Evaluation simulations',...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)
set(gca,'color',[0.8 0.8 0.8]);




%% plot hist  seasonal cycle ranking

load seas_rankings_hist
load seasvar_names_hist
load RCM_text

% plotting
ax2 = mf_subtightplot(1,2,2,[0.03,0.01],[0.32 0.1],[0.03 0.01]);
imagesc(ax2,seas_rankings_hist,'AlphaData',~isnan(seas_rankings_hist))
set(ax2,'XTick',[1:18],'XtickLabel',strcat(RCM_text,GCM_text),'XTickLabelRotation',45,...
    'Fontsize', lsize, 'Fontweight', 'Bold','xcolor', axcolor)
set(ax2,'YTick',[1:length(seas_rankings_hist)],'YtickLabel',' ',...
    'Fontsize', 10, 'Fontweight', 'Bold','ycolor', axcolor,'TickLength',[0 0])
colormap(cmap_17)
c = colorbar;
colorbar('Ticks',[2.2 4.15 6.1 8 9.9 11.9 13.8 15.7 17.7], 'TickLabels', [2:2:18],...
    'Fontsize', lsize, 'Fontweight', 'Bold','Color', axcolor,'TickLength',0)
title('Historical simulations',...
    'Fontsize', tsize, 'Fontweight', 'Bold','Color', axcolor)
set(gca,'color',[0.8 0.8 0.8]);
