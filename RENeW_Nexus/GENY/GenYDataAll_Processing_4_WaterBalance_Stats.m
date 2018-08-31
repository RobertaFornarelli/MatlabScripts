%% Analyse water balance data in Apt 2 to look for correlations, weekly trends, etc

clear all
close all
clc
cd C:\Users\277803E\Documents\MATLAB\RENeW_Nexus\GENY\
load('GenYData_WaterBalance.mat')

temp_day = GenYData_TimeStep_1_Day_WaterBalance; % From 30/Oct/2017 to 3/Jun/2018
temp_hour = GenYData_TimeStep_1_Hour_WaterBalance(1:5208,:); % From 30/Oct/2017 to 3/Jun/2018

%% Daily data
str = datestr(temp_day(:,1),'ddd');
cell = cellstr(str);
Mon = find(cell(:,1) == "Mon");
Tue = find(cell(:,1) == "Tue");
Wed = find(cell(:,1) == "Wed");
Thu = find(cell(:,1) == "Thu");
Fri = find(cell(:,1) == "Fri");
Sat = find(cell(:,1) == "Sat");
Sun = find(cell(:,1) == "Sun");

WeekDay = zeros(size(temp_day,1),1);
WeekDay(Mon,1) = 1;
WeekDay(Tue,1) = 2;
WeekDay(Wed,1) = 3;
WeekDay(Thu,1) = 4;
WeekDay(Fri,1) = 5;
WeekDay(Sat,1) = 6;
WeekDay(Sun,1) = 7;

temp_day_Mon = temp_day(Mon,:); 
temp_day_Tue = temp_day(Tue,:);
temp_day_Wed = temp_day(Wed,:); 
temp_day_Thu = temp_day(Thu,:);
temp_day_Fri = temp_day(Fri,:); 
temp_day_Sat = temp_day(Sat,:);
temp_day_Sun = temp_day(Sun,:); 

% Create matrix of weekly water demand for Apt 2
col = 21; % total water demand
matrix = [temp_day_Mon(:,col),temp_day_Tue(:,col),temp_day_Wed(:,col),temp_day_Thu(:,col),temp_day_Fri(:,col),temp_day_Sat(:,col),temp_day_Sun(:,col),]; 

% Look at data and inspect for normality of total water demand for Apt 2
plot_trend(temp_day_Mon(:,21),'Monday');
plot_trend(temp_day_Tue(:,21),'Tuesday');
plot_trend(temp_day_Wed(:,21),'Wednesday');
plot_trend(temp_day_Thu(:,21),'Thursday');
plot_trend(temp_day_Fri(:,21),'Friday');
plot_trend(temp_day_Sat(:,21),'Saturday');
plot_trend(temp_day_Sun(:,21),'Sunday');

% Look at box plot for total water demand, potable, non potable for Apt 2
y = [temp_day(:,21),temp_day(:,10:11)]; 
plot_boxplot(y,WeekDay,'Apt2');

% Remove outliers
outlier = find(matrix(:,3) == max(matrix(:,3))); 
matrix(outlier,:) = [];
outlier = find(matrix(:,3) == max(matrix(:,3))); 
matrix(outlier,:) = [];

plot_trend(matrix(:,1),'Monday');
plot_trend(matrix(:,2),'Tuesday');
plot_trend(matrix(:,3),'Wednesday');
plot_trend(matrix(:,4),'Thursday');
plot_trend(matrix(:,5),'Friday');
plot_trend(matrix(:,6),'Saturday');
plot_trend(matrix(:,7),'Sunday');
figure
boxplot(matrix)

% Data don't have outliers, are reasonably normally distributed, which means I can apply a 2 sample t-test to see if the mean/median between two days
% is statistically different, and therefore to see if there is a weekly trend in the data
% H0: two populations have the same mean/median
% H0 is accepted: h = 0; p > 0.05; mean is the same
% H0 is rejected: h = 1; p < 0.05; mean is different

p_matrix = []; h_matrix = [];
for i = 1:6
    for j = (i+1):7
        [h,p] = ttest2(matrix(:,i),matrix(:,j));
        p_matrix(i,j) = p;
        h_matrix(i,j) = h;
    end
end


 
%% Hourly data
temp_hour_0 = temp_hour((find(temp_hour(:,5) == 0)),:);
temp_hour_6 = temp_hour((find(temp_hour(:,5) == 6)),:);
temp_hour_11 = temp_hour((find(temp_hour(:,5) == 11)),:);

% Look at box plot for total water demand, potable, non potable for Apt 2 at hourly intervals
 

% Box plot hourly data
f = figure('Color',[1 1 1],'Position', [50, 50, 700, 700]);
axes1 = axes('Parent',f,'Position',[0.08 0.70 0.85 0.25]);
hold(axes1,'on');
boxplot(temp_hour(:,21),temp_hour(:,5),'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[0:1:23]);
xlim([0 23.5]);
%ylim([0 200]);
title('Water demand Apt 2','FontSize',10,'FontWeight','normal','FontName','Times')
ylabel('Total demand (L)','FontSize',10,'FontWeight','normal','FontName','Times')

axes1 = axes('Parent',f,'Position',[0.08 0.35 0.85 0.25]);
hold(axes1,'on');
boxplot(temp_hour(:,10),temp_hour(:,5),'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[0:1:23]);
xlim([0 23.5]);
%ylim([0 150]);
ylabel('Potable water demand (L)','FontSize',10,'FontWeight','normal','FontName','Times')
    
axes1 = axes('Parent',f,'Position',[0.08 0.05 0.85 0.25]);
hold(axes1,'on');
boxplot(temp_hour(:,11),temp_hour(:,5),'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[0:1:23]);
xlim([0 23.5]);
%ylim([0 150]);
ylabel('Non potable water demand (L)','FontSize',10,'FontWeight','normal','FontName','Times')



















