% Script to plot gradient for different time windows
close all

% plot
load('diag_temp_1.dat')
load('diag_pr_1.dat')
load('diag_temp_30.dat')
load('diag_pr_30.dat')
load('diag_temp_10.dat')
load('diag_pr_10.dat')
load('diag_temp_2.dat')
load('diag_pr_2.dat')
load('diag_temp_20.dat')
load('diag_pr_20.dat')

axcolor = [0.3 0.3 0.3];

% plot temperature
% set first absolute value to zero
diag_temp_1(:,1) = 0; 
diag_temp_5(:,1) = 0; 
diag_temp_10(:,1) = 0; 
diag_temp_30(:,1) = 0; 
diag_temp_20(:,1) = 0; 
diag_temp_2(:,1) = 0; 

diag_pr_1(:,1) = 0; 
diag_pr_5(:,1) = 0; 
diag_pr_10(:,1) = 0; 
diag_pr_30(:,1) = 0; 
diag_pr_20(:,1) = 0; 
diag_pr_2(:,1) = 0; 


temp_lim = [-2 13]; 
days_lim = [-100 100];

figure('Position', [10 10 750 950])

GMTlevels = [0,1,1.5,2,3,4]; 

cmap = mf_colormap_cpt('RdPu 06');


np = 1; % define diagnostic (number of subplot)
subplot(3,2,np) 
plot(GMTlevels, diag_temp_1(np,:), 'LineWidth', 1.5, 'Color', cmap(2,:))
hold on
plot(GMTlevels, diag_temp_2(np,:), 'LineWidth', 1.5, 'Color', cmap(3,:))
plot(GMTlevels, diag_temp_30(np,:), 'LineWidth', 1.5, 'Color', cmap(4,:))
plot(GMTlevels, diag_temp_10(np,:), 'LineWidth', 1.5, 'Color', cmap(5,:))
plot(GMTlevels, diag_temp_20(np,:), 'LineWidth', 1.5, 'Color', cmap(6,:))
title('\Delta T', 'Color', axcolor)
ylabel('\Delta temperature [°C]')
set(gca,'XTick',[0 1 1.5 2 3 4], 'XTickLabel', {'+0°' '+1°', '+1.5°', '+2°', '+3°', '+4°'},'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
grid on
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','ycolor', axcolor)
legend('1-year period','2-year period', '5-year period','10-year period','20-year period', 'Location','northwest','Fontweight', 'normal','Box','off','Fontsize', 9, 'Color', axcolor)

np = 2; % define diagnostic (number of subplot)
subplot(3,2,np) 
plot(GMTlevels, diag_temp_1(np,:), 'LineWidth', 1.5, 'Color', cmap(2,:))
hold on
plot(GMTlevels, diag_temp_2(np,:), 'LineWidth', 1.5, 'Color', cmap(3,:))
plot(GMTlevels, diag_temp_30(np,:), 'LineWidth', 1.5, 'Color', cmap(4,:))
plot(GMTlevels, diag_temp_10(np,:), 'LineWidth', 1.5, 'Color', cmap(5,:))
plot(GMTlevels, diag_temp_20(np,:), 'LineWidth', 1.5, 'Color', cmap(6,:))
title('\Delta TXx', 'Color', axcolor)
ylabel('\Delta temperature [°C]')
set(gca,'XTick',[0 1 1.5 2 3 4], 'XTickLabel', {'+0°' '+1°', '+1.5°', '+2°', '+3°', '+4°'},'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
grid on
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','ycolor', axcolor)



np = 3; % define diagnostic (number of subplot)
subplot(3,2,np) 
plot(GMTlevels, diag_temp_1(np,:), 'LineWidth', 1.5, 'Color', cmap(2,:))
hold on
plot(GMTlevels, diag_temp_2(np,:), 'LineWidth', 1.5, 'Color', cmap(3,:))
plot(GMTlevels, diag_temp_30(np,:), 'LineWidth', 1.5, 'Color', cmap(4,:))
plot(GMTlevels, diag_temp_10(np,:), 'LineWidth', 1.5, 'Color', cmap(5,:))
plot(GMTlevels, diag_temp_20(np,:), 'LineWidth', 1.5, 'Color', cmap(6,:))
title('\Delta TNn', 'Color', axcolor)
ylabel('\Delta temperature [°C]')
set(gca,'XTick',[0 1 1.5 2 3 4], 'XTickLabel', {'+0°' '+1°', '+1.5°', '+2°', '+3°', '+4°'},'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
grid on
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','ycolor', axcolor)


np = 4; % define diagnostic (number of subplot)
subplot(3,2,np) 
plot(GMTlevels, diag_temp_1(6,:), 'LineWidth', 1.5, 'Color', cmap(2,:))
hold on
plot(GMTlevels, diag_temp_2(6,:), 'LineWidth', 1.5, 'Color', cmap(3,:))
plot(GMTlevels, diag_temp_30(6,:), 'LineWidth', 1.5, 'Color', cmap(4,:))
plot(GMTlevels, diag_temp_10(6,:), 'LineWidth', 1.5, 'Color', cmap(5,:))
plot(GMTlevels, diag_temp_20(6,:), 'LineWidth', 1.5, 'Color', cmap(6,:))

title('\Delta  Summer days', 'Color', axcolor)
ylabel('\Delta days')
set(gca,'XTick',[0 1 1.5 2 3 4], 'XTickLabel', {'+0°' '+1°', '+1.5°', '+2°', '+3°', '+4°'},'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
grid on
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','ycolor', axcolor)



np = 5; % define diagnostic (number of subplot)
subplot(3,2,np) 
plot(GMTlevels, diag_temp_1(np,:), 'LineWidth', 1.5, 'Color', cmap(2,:))
hold on
plot(GMTlevels, diag_temp_2(np,:), 'LineWidth', 1.5, 'Color', cmap(3,:))
plot(GMTlevels, diag_temp_30(np,:), 'LineWidth', 1.5, 'Color', cmap(4,:))
plot(GMTlevels, diag_temp_10(np,:), 'LineWidth', 1.5, 'Color', cmap(5,:))
plot(GMTlevels, diag_temp_20(np,:), 'LineWidth', 1.5, 'Color', cmap(6,:))
title('\Delta Frost days', 'Color', axcolor)
ylabel('\Delta days')
set(gca,'XTick',[0 1 1.5 2 3 4], 'XTickLabel', {'+0°' '+1°', '+1.5°', '+2°', '+3°', '+4°'},'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
grid on
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','ycolor', axcolor)
xlabel('GMT anomaly')




np = 6; % define diagnostic (number of subplot)
subplot(3,2,np) 
plot(GMTlevels, diag_temp_1(4,:), 'LineWidth', 1.5, 'Color', cmap(2,:))
hold on
plot(GMTlevels, diag_temp_2(4,:), 'LineWidth', 1.5, 'Color', cmap(3,:))
plot(GMTlevels, diag_temp_30(4,:), 'LineWidth', 1.5, 'Color', cmap(4,:))
plot(GMTlevels, diag_temp_10(4,:), 'LineWidth', 1.5, 'Color', cmap(5,:))
plot(GMTlevels, diag_temp_20(4,:), 'LineWidth', 1.5, 'Color', cmap(6,:))
title('\Delta Growing season length', 'Color', axcolor)
ylabel('\Delta days')
set(gca,'XTick',[0 1 1.5 2 3 4], 'XTickLabel', {'+0°' '+1°', '+1.5°', '+2°', '+3°', '+4°'},'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
grid on
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','ycolor', axcolor)
xlabel('GMT anomaly')



%% plot precipitataion diagnostics
% set first absolute value to zero
diag_pr_5(:,1) = 0; 
diag_pr_10(:,1) = 0; 
diag_pr_30(:,1) = 0; 

figure('Position', [10 10 750 950])

GMTlevels = [0,1,1.5,2,3,4]; 

cmap_pr = mf_colormap_cpt('YlGnBu 06');


np = 1; % define diagnostic (number of subplot)
subplot(3,2,np)
plot(GMTlevels, diag_pr_1(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(2,:))
hold on
plot(GMTlevels, diag_pr_2(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(3,:))
plot(GMTlevels, diag_pr_30(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(4,:))
plot(GMTlevels, diag_pr_10(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(5,:))
plot(GMTlevels, diag_pr_20(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(6,:))
title('\Delta PRCTOT', 'Color', axcolor)
ylabel('\Delta precipitation [mm]')
set(gca,'XTick',[0 1 1.5 2 3 4], 'XTickLabel', {'+0°' '+1°', '+1.5°', '+2°', '+3°', '+4°'},'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
grid on
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','ycolor', axcolor)
ylim([-200 200])


np = 2; % define diagnostic (number of subplot)
subplot(3,2,np) 
plot(GMTlevels, diag_pr_1(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(2,:))
hold on
plot(GMTlevels, diag_pr_2(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(3,:))
plot(GMTlevels, diag_pr_30(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(4,:))
plot(GMTlevels, diag_pr_10(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(5,:))
plot(GMTlevels, diag_pr_20(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(6,:))
title('\Delta Rx1day', 'Color', axcolor)
ylabel('\Delta precipitation [mm]')
legend('1-year period','2-year period', '5-year period','10-year period','20-year period', 'Location','northwest','Fontweight', 'normal','Box','off','Fontsize', 9, 'Color', axcolor)

set(gca,'XTick',[0 1 1.5 2 3 4], 'XTickLabel', {'+0°' '+1°', '+1.5°', '+2°', '+3°', '+4°'},'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
grid on
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','ycolor', axcolor)
ylim([-4 10])




np =3; % define diagnostic (number of subplot)
subplot(3,2,np) 
plot(GMTlevels, diag_pr_1(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(2,:))
hold on
plot(GMTlevels, diag_pr_1(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(2,:))
hold on
plot(GMTlevels, diag_pr_2(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(3,:))
plot(GMTlevels, diag_pr_30(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(4,:))
plot(GMTlevels, diag_pr_10(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(5,:))
plot(GMTlevels, diag_pr_20(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(6,:))
title('\Delta R10mm', 'Color', axcolor)
ylabel('\Delta days')
set(gca,'XTick',[0 1 1.5 2 3 4], 'XTickLabel', {'+0°' '+1°', '+1.5°', '+2°', '+3°', '+4°'},'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
grid on
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','ycolor', axcolor)
ylim([-5 20])




np = 4; % define diagnostic (number of subplot)
subplot(3,2,np) 
plot(GMTlevels, diag_pr_1(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(2,:))
hold on
plot(GMTlevels, diag_pr_2(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(3,:))
plot(GMTlevels, diag_pr_30(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(4,:))
plot(GMTlevels, diag_pr_10(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(5,:))
plot(GMTlevels, diag_pr_20(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(6,:))
title('\Delta CDD', 'Color', axcolor)
ylabel('\Delta days')
set(gca,'XTick',[0 1 1.5 2 3 4], 'XTickLabel', {'+0°' '+1°', '+1.5°', '+2°', '+3°', '+4°'},'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
grid on
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','ycolor', axcolor)
ylim([-5 20])
xlabel('GMT anomaly')





np = 5; % define diagnostic (number of subplot)
subplot(3,2,np) 
plot(GMTlevels, diag_pr_1(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(2,:))
hold on
plot(GMTlevels, diag_pr_2(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(3,:))
plot(GMTlevels, diag_pr_30(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(4,:))
plot(GMTlevels, diag_pr_10(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(5,:))
plot(GMTlevels, diag_pr_20(np,:), 'LineWidth', 1.5, 'Color', cmap_pr(6,:))

title('\Delta CWD', 'Color', axcolor)
ylabel('\Delta days')
set(gca,'XTick',[0 1 1.5 2 3 4], 'XTickLabel', {'+0°' '+1°', '+1.5°', '+2°', '+3°', '+4°'},'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
grid on
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','xcolor', axcolor)
set(gca,'Fontsize', 10, 'Fontweight', 'Bold','ycolor', axcolor)
xlabel('GMT anomaly')
ylim([-6 6])
