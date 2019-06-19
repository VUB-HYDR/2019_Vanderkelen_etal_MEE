% ------------------------------------------------------------------------
% Function to plot annual means of a season


function mf_plot_ymeanseas(var_ymean, season, sel, ownylabel,ownylim,RCM_text, GCM_text)

axcolor = [0.3 0.3 0.3]; 
gray = [0.7 0.7 0.7]; 
gray_range = [0.8 0.8 0.8];

label_loc10 =5:10:94; 
label_loc10(length(label_loc10)+1) = 94; 
 
year_labels10 = {'2010','2020','2030','2040','2050','2060','2070',...
    '2080','2090','2100'};


pr_ymean_mod = var_ymean(:,sel); 

min_var_ymean = min(var_ymean,[],2);
max_var_ymean = max(var_ymean,[],2);


x = (1:length(var_ymean)); 
x2 = [x, fliplr(x)];
range_pr = [min_var_ymean' , fliplr(max_var_ymean' )];
plot(pr_ymean_mod, 'r','LineWidth',1.5)
hold on
plot(mean(var_ymean,2),'k','LineWidth',1.5)
f1 = fill(x2, range_pr, gray_range);
set(f1,'facealpha',.5)
plot(min_var_ymean,'Color',gray)
plot(max_var_ymean,'Color',gray)
hold off

ylim(ownylim)
xlim([1 94])
grid on
ylabel(ownylabel,'Fontsize', 12, 'Fontweight', 'Bold', 'color', axcolor)
title(season,'Fontsize', 14, 'Fontweight', 'Bold', 'color', axcolor)
set(gca, 'Fontsize', 11, 'Fontweight', 'Bold','Xcolor', axcolor,...
   'Ycolor', axcolor,'xtick',label_loc10,'xticklabel',year_labels10,'xticklabelrotation',45); 

if strcmp(season,'JJA') ==1
legend(strcat(RCM_text(sel),GCM_text(sel)),'Multimodel mean')
set(legend,'Fontweight', 'Bold','Fontsize', 12, 'TextColor', axcolor);
end
end