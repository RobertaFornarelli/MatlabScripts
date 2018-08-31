function f = plot_boxplot(y,WeekDay,Apt)

f = figure('Color',[1 1 1],'Position', [50, 50, 700, 700]);
axes1 = axes('Parent',f,'Position',[0.08 0.70 0.85 0.25]);
hold(axes1,'on');
boxplot(y(:,1),WeekDay,'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[1:1:7],'XTickLabel',{'Mon','Tue','Wed','Thu','Fri','Sat','Sun'});
xlim([0.5 7.5]);
%ylim([0 400]);
ylabel('Total demand (L)','FontSize',10,'FontWeight','normal','FontName','Times')

axes1 = axes('Parent',f,'Position',[0.08 0.35 0.85 0.25]);
hold(axes1,'on');
boxplot(y(:,2),WeekDay,'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[1:1:7],'XTickLabel',{'Mon','Tue','Wed','Thu','Fri','Sat','Sun'});
xlim([0.5 7.5]);
%ylim([0 250]);
ylabel('Potable water demand (L)','FontSize',10,'FontWeight','normal','FontName','Times')
    
axes1 = axes('Parent',f,'Position',[0.08 0.05 0.85 0.25]);
hold(axes1,'on');
boxplot(y(:,3),WeekDay,'Parent',axes1);
box(axes1,'on');
set(axes1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
set(gca,'Xtick',[1:1:7],'XTickLabel',{'Mon','Tue','Wed','Thu','Fri','Sat','Sun'});
xlim([0.5 7.5]);
%ylim([0 250]);
ylabel('Non potable water demand (L)','FontSize',10,'FontWeight','normal','FontName','Times')

annotation(f,'textbox',[0.50 0.90 0.1 0.1],'String',{Apt},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');

end
