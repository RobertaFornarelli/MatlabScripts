clear all
close all
clc

load('JoshData.mat')

% Daily flows in L/d
% 1 = Bore; 2 = GreyMeas; 3 = GreyEst; 4 = Mains; 5 = Rain; 6 = Rain(mm); 
% 7 = Credit to IWSS; 8 = Debit to IWSS;
% 9 = Credit to IWSS; 10 = Debit to IWSS;
% 11 = Rain captured in tank

TimeInterval = [datenum(2015,01,01) datenum(2015,12,31)];
time = [datenum(2015,01,01):1:datenum(2015,12,31)]';

% f = figure('Color',[1 1 1],'Position', [50, 50, 700, 500]);
% axes1 = axes('Parent',f,'Position',[0.08 0.57 0.80 0.36]);
% hold(axes1,'on');
% area1 = area(time,temp(:,4:5),'Parent',axes1);
% %area1 = area(X1,ymatrix1,'Parent',axes1);
% set(area1(2),...
%     'FaceColor',[0.800000011920929 0.800000011920929 0.800000011920929],...
%     'EdgeColor',[0 0 0]);
% set(area1(1),'FaceColor',[0 0 0]);
% hold on
% yyaxis right
% bar(time,temp(:,11),'Parent',axes1,'FaceColor',[0 0 1],'EdgeColor','none');
% ylabel('Rainfall captured in tank (L)','FontSize',10,'FontWeight','normal','FontName','Times')
% set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
% ylim([0 5000])
% yyaxis left
% 
% box(axes1,'on');
% set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
% set(gca,'Xtick',[datenum(2015,01,01,0,0,0):datenum(0,4,0,0,0,0):datenum(2015,12,31,0,0,0)]);
% datetick('x','dd/mmm/yy','keeplimits','keepticks');
% xlim(TimeInterval);
% ylim([0 2100]);
% ylabel('Indoor water use (L/d)','FontSize',10,'FontWeight','normal','FontName','Times')
% legend1 = legend('Mains water','Rainwater','Captured rainfall','Orientation','vertical');
% %set(legend1,'Position',[0.60 0.95 0.357 0.050];
% 
% axes1 = axes('Parent',f,'Position',[0.08 0.10 0.80 0.36]);
% hold(axes1,'on');
% area1 = area(time,temp(:,1),'Parent',axes1);
% set(area1(1),...
%     'FaceColor',[0.800000011920929 0.800000011920929 0.800000011920929],...
%     'EdgeColor',[0 0 0]);
% plot(time(270:360,1),temp(270:360,12),'.k','MarkerSize',8,'Parent',axes1);
% 
% hold on
% plot(time(:,1),temp(:,3),'.-k','MarkerSize',8,'Parent',axes1);
% box(axes1,'on');
% set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
% set(gca,'Xtick',[datenum(2015,01,01,0,0,0):datenum(0,4,0,0,0,0):datenum(2015,12,31,0,0,0)]);
% datetick('x','dd/mmm/yy','keeplimits','keepticks');
% xlim(TimeInterval);
% ylabel('Outdoor water use (L/d)','FontSize',10,'FontWeight','normal','FontName','Times')
% legend1 = legend('Groundwater','Measured greywater','Estimated greywater','Orientation','vertical');
% 
% annotation(f,'textbox',[0.10 0.94 0.028 0.0403],'String',{'a)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');
% annotation(f,'textbox',[0.10 0.47 0.028 0.0403],'String',{'b)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');
% 



%%
f = figure('Color',[1 1 1],'Position', [50, 50, 700, 500]);
axes1 = axes('Parent',f,'Position',[0.08 0.57 0.85 0.36]);
hold(axes1,'on');
area1 = area(time,temp(:,7:8),'Parent',axes1);
set(area1(1),'DisplayName','Credits to IWSS',...
    'FaceColor',[0.800000011920929 0.800000011920929 0.800000011920929],...
    'EdgeColor',[0 0 0]);
set(area1(2),'DisplayName','Debits to IWSS','FaceColor',[0 0 0]);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[datenum(2015,01,01,0,0,0):datenum(0,4,0,0,0,0):datenum(2015,12,31,0,0,0)]);
datetick('x','dd/mmm/yy','keeplimits','keepticks');
xlim(TimeInterval);
ylim([0 2100]);
ylabel('Volumetric credits/debits (L/d)','FontSize',10,'FontWeight','normal','FontName','Times')
legend1 = legend('Credits to IWSS','Debits to IWSS','Orientation','vertical');
%set(legend1,'Position',[0.60 0.95 0.357 0.050];

axes1 = axes('Parent',f,'Position',[0.08 0.10 0.85 0.36]);
hold(axes1,'on');
area1 = area(time,temp(:,9:10),'Parent',axes1);
set(area1(1),'DisplayName','Credits to IWSS',...
    'FaceColor',[0.800000011920929 0.800000011920929 0.800000011920929],...
    'EdgeColor',[0 0 0]);
set(area1(2),'DisplayName','Debits to IWSS','FaceColor',[0 0 0]);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[datenum(2015,01,01,0,0,0):datenum(0,4,0,0,0,0):datenum(2015,12,31,0,0,0)]);
datetick('x','dd/mmm/yy','keeplimits','keepticks');
xlim(TimeInterval);
ylim([0 100]);
ylabel('Percentage (%)','FontSize',10,'FontWeight','normal','FontName','Times')

annotation(f,'textbox',[0.10 0.94 0.028 0.0403],'String',{'a)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');
annotation(f,'textbox',[0.10 0.47 0.028 0.0403],'String',{'b)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');

