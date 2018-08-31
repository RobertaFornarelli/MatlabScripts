

function f = plot_EnergyDataRaw(matrix,time_interval)
    
f = figure('Color',[1 1 1],'Position', [30, 30, 700, 900]);

axes1 = axes('Parent',f,'Position',[0.08 0.85 0.85 0.13]);
hold(axes1,'on');
plot(matrix(:,1),(matrix(:,7)+matrix(:,8)+matrix(:,9)),'.-b','MarkerSize',8,'Parent',axes1);
hold on
plot(matrix(:,1),matrix(:,10),'.-r','MarkerSize',8,'Parent',axes1);
plot(matrix(:,1),matrix(:,11),'.-k','MarkerSize',8,'Parent',axes1);
plot(matrix(:,1),(matrix(:,7)+matrix(:,8)+matrix(:,9)+matrix(:,10)+matrix(:,11)),'.-g','MarkerSize',8,'Parent',axes1);
plot(matrix(:,1),matrix(:,25),'.-','MarkerSize',8,'Color',[0.313725501298904 0.313725501298904 0.313725501298904],'Parent',axes1);
plot(matrix(:,1),matrix(:,15),'.-','MarkerSize',8,'Color',[1 0.600000023841858 0.7843137383461],'Parent',axes1);
plot(matrix(:,1),matrix(:,16),'.-','MarkerSize',8,'Color',[0 0.498039215803146 0],'Parent',axes1);
plot(matrix(:,1),matrix(:,17),'.-','MarkerSize',8,'Color',[0.635294139385223 0.0784313753247261 0.184313729405403],'Parent',axes1);
plot(matrix(:,1),(matrix(:,15)+matrix(:,16)+matrix(:,17)),'.-','MarkerSize',8,'Color',[1 0 1],'Parent',axes1);
plot(matrix(:,1),matrix(:,27),'.-','MarkerSize',8,'Color',[1 1 0],'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[datenum(2017,01,01,0,0,0):datenum(0,0,0,6,0,0):datenum(2018,12,31,0,0,0)]);
datetick('x','dd/mmm/yy HH:MM','keeplimits','keepticks');
xlim(time_interval);
ylabel('Energy (Wh)','FontSize',10,'FontWeight','normal','FontName','Times')
legend1 = legend('Apt1+HouseServ','Apt2','Apt3','TotalLoadComXSim10','TotalLoad EnergyMeterOnLoad','Load A','Load B','Load C','TotalLoadDESS','TotalLoadFromPower EnergyMeterOnLoad','Orientation','vertical');
%set(legend1,'Position',[0.60 0.95 0.357 0.050];

axes1 = axes('Parent',f,'Position',[0.08 0.65 0.85 0.15]);
hold(axes1,'on');
plot(matrix(:,1),(matrix(:,12)+matrix(:,13)+matrix(:,14)),'.-b','MarkerSize',8,'Parent',axes1);
hold on
plot(matrix(:,1),matrix(:,12),'.-r','MarkerSize',8,'Parent',axes1);
plot(matrix(:,1),matrix(:,13),'.-k','MarkerSize',8,'Parent',axes1);
plot(matrix(:,1),matrix(:,14),'.-g','MarkerSize',8,'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[datenum(2017,01,01,0,0,0):datenum(0,0,0,6,0,0):datenum(2018,12,31,0,0,0)]);
datetick('x','dd/mmm/yy HH:MM','keeplimits','keepticks');
xlim(time_interval);
ylabel('Energy (Wh)','FontSize',10,'FontWeight','normal','FontName','Times')
legend1 = legend('Solar A+B+C','Solar A','Solar B','Solar C','Orientation','vertical');

axes1 = axes('Parent',f,'Position',[0.08 0.45 0.85 0.15]);
hold(axes1,'on');
yyaxis left
plot(matrix(:,1),(matrix(:,18)+matrix(:,19)+matrix(:,20)),'.-b','MarkerSize',8,'Parent',axes1);
hold on
plot(matrix(:,1),matrix(:,18),'.-r','MarkerSize',8,'Parent',axes1);
plot(matrix(:,1),matrix(:,19),'.-k','MarkerSize',8,'Parent',axes1);
plot(matrix(:,1),matrix(:,20),'.-g','MarkerSize',8,'Parent',axes1);
plot(matrix(:,1),matrix(:,23),'.-','MarkerSize',8,'Color',[1 0.600000023841858 0.7843137383461],'Parent',axes1);
plot(matrix(:,1),-matrix(:,24),'.-','MarkerSize',8,'Color',[0 0.498039215803146 0],'Parent',axes1);
yyaxis right
plot(matrix(:,1),matrix(:,22),'.-','MarkerSize',8,'Color',[0.313725501298904 0.313725501298904 0.313725501298904],'Parent',axes1);
ylabel('Energy Import (Wh)','FontSize',10,'FontWeight','normal','FontName','Times')
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
yyaxis left
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[datenum(2017,01,01,0,0,0):datenum(0,0,0,6,0,0):datenum(2018,12,31,0,0,0)]);
datetick('x','dd/mmm/yy HH:MM','keeplimits','keepticks');
xlim(time_interval);
ylim([0 2000])
ylabel('Energy (Wh)','FontSize',10,'FontWeight','normal','FontName','Times')
legend1 = legend('Grid A+B+C','Grid A','Grid B','Grid C','GridExport EnergyMeterOnGrid','GridExchangeFromPower EnergyMeterOnGrid','GridImport EnergyMeterOnGrid','Orientation','vertical');

axes1 = axes('Parent',f,'Position',[0.08 0.25 0.85 0.15]);
hold(axes1,'on');
plot(matrix(:,1),(matrix(:,25)+matrix(:,23)-matrix(:,22)),'.-b','MarkerSize',8,'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[datenum(2017,01,01,0,0,0):datenum(0,0,0,6,0,0):datenum(2018,12,31,0,0,0)]);
datetick('x','dd/mmm/yy HH:MM','keeplimits','keepticks');
xlim(time_interval);
ylabel('Energy (Wh)','FontSize',10,'FontWeight','normal','FontName','Times')
legend1 = legend('Solar+Battery=Load+GridExp-GridImp','Orientation','vertical');

axes1 = axes('Parent',f,'Position',[0.08 0.05 0.85 0.15]);
hold(axes1,'on');
yyaxis left
plot(matrix(:,1),((matrix(:,25)+matrix(:,23)-matrix(:,22))-(matrix(:,12)+matrix(:,13)+matrix(:,14))),'.-b','MarkerSize',8,'Parent',axes1);
hold on
yyaxis right
plot(matrix(:,1),matrix(:,21),'.-','MarkerSize',8,'Color',[0.313725501298904 0.313725501298904 0.313725501298904],'Parent',axes1);
ylabel('SOC battery (%)','FontSize',10,'FontWeight','normal','FontName','Times')
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
yyaxis left
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[datenum(2017,01,01,0,0,0):datenum(0,0,0,6,0,0):datenum(2018,12,31,0,0,0)]);
datetick('x','dd/mmm/yy HH:MM','keeplimits','keepticks');
xlim(time_interval);
ylabel('Energy (Wh)','FontSize',10,'FontWeight','normal','FontName','Times')
legend1 = legend('Battery=Load+GridExp-GridImp-Solar','SOC battery (%)','Orientation','vertical');

annotation(f,'textbox',[0.10 0.94 0.028 0.0403],'String',{'a)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');
annotation(f,'textbox',[0.10 0.76 0.028 0.0403],'String',{'b)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');
annotation(f,'textbox',[0.10 0.56 0.028 0.0403],'String',{'c)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');
annotation(f,'textbox',[0.10 0.36 0.028 0.0403],'String',{'d)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');
annotation(f,'textbox',[0.10 0.16 0.028 0.0403],'String',{'e)'},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');

end