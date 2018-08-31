

function f = plot_EnergyBalance(matrix,time_interval)

matrix1 = [matrix(:,32) matrix(:,35) matrix(:,40)];

f = figure('Color',[1 1 1],'Position', [30, 30, 700, 900]);

axes1 = axes('Parent',f,'Position',[0.08 0.85 0.85 0.13]);
hold(axes1,'on');
plot(matrix(:,1),matrix(:,31),'.-b','MarkerSize',8,'Parent',axes1);
hold on
area(matrix(:,1),matrix1(:,1:3),'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[datenum(2017,01,01,0,0,0):datenum(0,0,0,6,0,0):datenum(2018,12,31,0,0,0)]);
datetick('x','dd/mmm/yy HH:MM','keeplimits','keepticks');
xlim(time_interval);
ylabel('Energy (Wh)','FontSize',10,'FontWeight','normal','FontName','Times')
legend1 = legend('TotalLoad GenYBuilding','From Solar','From Grid','From Battery','Orientation','vertical');
%set(legend1,'Position',[0.60 0.95 0.357 0.050];

axes1 = axes('Parent',f,'Position',[0.08 0.65 0.85 0.15]);
hold(axes1,'on');
plot(matrix(:,1),matrix(:,30),'.-b','MarkerSize',8,'Parent',axes1);
hold on
area(matrix(:,1),matrix(:,32:34),'Parent',axes1);
%plot(matrix(:,1),matrix(:,33),'.-k','MarkerSize',8,'Parent',axes1);
%plot(matrix(:,1),matrix(:,34),'.-g','MarkerSize',8,'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[datenum(2017,01,01,0,0,0):datenum(0,0,0,6,0,0):datenum(2018,12,31,0,0,0)]);
datetick('x','dd/mmm/yy HH:MM','keeplimits','keepticks');
xlim(time_interval);
ylabel('Energy (Wh)','FontSize',10,'FontWeight','normal','FontName','Times')
legend1 = legend('Total Solar','To Load','To Grid','To Battery','Orientation','vertical');

axes1 = axes('Parent',f,'Position',[0.08 0.45 0.85 0.15]);
hold(axes1,'on');
plot(matrix(:,1),matrix(:,41),'.-b','MarkerSize',8,'Parent',axes1);
hold on
yyaxis right
plot(matrix(:,1),matrix(:,42),'.-r','MarkerSize',8,'Parent',axes1);
ylabel('Battery supply (Wh)','FontSize',10,'FontWeight','normal','FontName','Times')
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
ylim([0 2000])
yyaxis left
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[datenum(2017,01,01,0,0,0):datenum(0,0,0,6,0,0):datenum(2018,12,31,0,0,0)]);
datetick('x','dd/mmm/yy HH:MM','keeplimits','keepticks');
xlim(time_interval);
ylim([0 2000])
ylabel('Energy (Wh)','FontSize',10,'FontWeight','normal','FontName','Times')
legend1 = legend('Battery recharge','Battery supply','Orientation','vertical');

axes1 = axes('Parent',f,'Position',[0.08 0.25 0.85 0.15]);
hold(axes1,'on');
plot(matrix(:,1),matrix(:,28),'.-b','MarkerSize',8,'Parent',axes1);
hold on
plot(matrix(:,1),matrix(:,43),'.-r','MarkerSize',8,'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[datenum(2017,01,01,0,0,0):datenum(0,0,0,6,0,0):datenum(2018,12,31,0,0,0)]);
datetick('x','dd/mmm/yy HH:MM','keeplimits','keepticks');
xlim(time_interval);
ylabel('Energy (Wh)','FontSize',10,'FontWeight','normal','FontName','Times')
legend1 = legend('Energy in Battery','Energy in Battery Calculated','Orientation','vertical');

axes1 = axes('Parent',f,'Position',[0.08 0.05 0.85 0.15]);
hold(axes1,'on');
plot(matrix(:,1),matrix(:,21),'.-b','MarkerSize',8,'Parent',axes1);
hold on
plot(matrix(:,1),matrix(:,44),'.-r','MarkerSize',8,'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[datenum(2017,01,01,0,0,0):datenum(0,0,0,6,0,0):datenum(2018,12,31,0,0,0)]);
datetick('x','dd/mmm/yy HH:MM','keeplimits','keepticks');
xlim(time_interval);
ylabel('SOC (%)','FontSize',10,'FontWeight','normal','FontName','Times')
legend1 = legend('SOC Battery','SOC Battery Calculated','Orientation','vertical');

annotation(f,'textbox',[0.10 0.94 0.028 0.0403],'String',{'a)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');
annotation(f,'textbox',[0.10 0.76 0.028 0.0403],'String',{'b)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');
annotation(f,'textbox',[0.10 0.56 0.028 0.0403],'String',{'c)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');
annotation(f,'textbox',[0.10 0.36 0.028 0.0403],'String',{'d)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');
annotation(f,'textbox',[0.10 0.16 0.028 0.0403],'String',{'e)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');

end