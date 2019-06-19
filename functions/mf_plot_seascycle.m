% ------------------------------------------------------------------------
% Function to plot the seasonal cycle of EUR-CORDEX variables against
% referende
% -----------------------------------------------------------------------


function mf_plot_seascycle(var_seas,refvar_seas,var_name, nm,RCM, time_res, ownylabel,run,flg_legend,loc_legend)

% define axcolor
axcolor = [0.3 0.3 0.3];
if strcmp(run,'eval') ==1
colors = mf_colormap_cpt('Set2 08',8);

colors_extra = mf_colormap_cpt('Set1 04',4);
color_extra = colors_extra(4,:);  

colors(length(colors)+1,:) = color_extra; 

else
    color_select = mf_histcolors; 
    histcolors = [color_select(9,:);color_select(10,:);color_select(11,:);...
        color_select(13,:);color_select(14,:);color_select(15,:);...
        color_select(16,:);color_select(1,:);color_select(5,:)];
    colors = mf_colormap_cpt('Set2 08',8);

    colors_extra = mf_colormap_cpt('Set1 04',4);
    color_extra = colors_extra(4,:);  

    colors(length(colors)+1,:) = color_extra;
    colors = [colors; histcolors ];
    end
% define ticks and ticklabels

% define one leap year
year_begin  = [2008, 1, 1, 0,0,0];
year_end   =  [2008,12,31,23,0,0];  
year_vec = datevec(datenum(year_begin):1:datenum(year_end)); 
month_day = year_vec(:,2:3); 

months_label = ['Jan';'Feb';'Mar';'Apr';'May';'Jun';'Jul';'Aug';'Sep';'Oct';'Nov';'Dec'];
months_label_short = ['J';'F';'M';'A';'M';'J';'J';'A';'S';'O';'N';'D'];
months = (1:12).'; 

first_day = ones(length(months),1); 
first_daymonth=[months first_day]; 

[~,ind_firstmonth] = ismember(first_daymonth,month_day,'rows');

mid_day = ones(length(months),1).*15; 
mid_daymonth=[months mid_day]; 

[~,ind_midmonth] = ismember(mid_daymonth,month_day,'rows');



% plot 

j = 0; 
for i = 1:nm
       
      plot(var_seas(:,i),'linewidth',1.5, 'color', colors(i,:) )

   
   hold on 
end

plot(refvar_seas, 'linewidth', 1.5, 'color','k')

hold off

% plot characteristics

if flg_legend == 1
RCM{19,1}='Observations';
legend(RCM,'Box','Off')   
%legend(RCM,'Reference')   

set(legend,'Fontweight', 'Bold', 'Fontsize', 10, 'TextColor', axcolor,'Location',loc_legend);
end

title(var_name,'Fontsize', 20, 'Fontweight', 'Bold', 'color', axcolor) 

ylabel(ownylabel)

if strcmp(time_res,'day')
    
    xlim([1 366])
    
    set(gca,'XTick',ind_firstmonth,'XtickLabel',[],'Fontsize', 14, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'XTick',ind_midmonth,'XTickLabel',months_label_short )


elseif strcmp(time_res,'month')
    
    xlim([1 12])
    
    set(gca,'XTick',months,'XtickLabel',[],'Fontsize', 12, 'Fontweight', 'Bold','Xcolor', axcolor,...
    'Ycolor', axcolor,'XTick',months,'XTickLabel',months_label_short )

end

grid on



end