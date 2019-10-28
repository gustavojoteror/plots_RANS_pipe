function h = subplotit_paper(y,v1,flagHold, style, color, markersizes, fontsize, logPlot, line)
    
    if (flagHold == 0); hold off; end
    if nargin <9;         h = plot(y,v1,'Color', color,'Marker',style,'MarkerSize',markersizes, 'LineWidth', 1.0,'LineStyle','none'); 
    else                  h = plot(y,v1,'Color', color,'LineStyle', style, 'LineWidth', markersizes); end
        
 
    hold on
    
%     if(logPlot>0)
%         set(gca,'XScale','log');
%         if(logPlot>1)
%            set(gca,'YScale','log'); 
%         end
%     end
    
    %grid on;
    %xlabel( xaxis,'Interpreter','latex');
    %ylabel( yaxis,'Interpreter','latex');
    set(gca,'fontsize', fontsize)
    
end