function f = plot_trend(x,annot)

% First figure is to inspect raw data and normality hypothesis
f = figure('Color',[1 1 1],'Position', [50, 50, 600, 600]);
subplot1 = subplot(2,1,1,'Parent',f);
hold(subplot1,'on');
plot(x,'.','Parent',subplot1);
box(subplot1,'on');
set(subplot1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
title('Trend - total water demand','FontSize',10,'FontWeight','normal','FontName','Times')

subplot1 = subplot(2,1,2,'Parent',f);
hold(subplot1,'on');
qqplot(x);
box(subplot1,'on');
set(subplot1,'XColor','k','YColor','k','FontName','Times','FontSize',10,'YGrid','on','XGrid','on');
title('Normality Check - total water demand','FontSize',10,'FontWeight','normal','FontName','Times')

annotation(f,'textbox',[0.75 0.92 0.028 0.0403],'String',{annot},'FontName','Times','FontSize',10,'FitBoxToText','off','EdgeColor','none');

end
