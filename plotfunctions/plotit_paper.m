function plotit_paper(y,v1,i,flagHold,xaxis, yaxis, style, color, markersizes, fontsize, logPlot, line)
    figure(i)
    n = size(v1,1);
    
    if (flagHold == 0); hold off; end
    if nargin <12;         plot(y,v1,'Color', color,'Marker',style,'MarkerSize',markersizes, 'LineWidth', 1.5,'LineStyle','none'); 
    else                   plot(y,v1,'Color', color,'LineStyle', style, 'LineWidth', markersizes); end
        
 
    hold on
    
    if(logPlot>0)
        set(gca,'XScale','log');
        if(logPlot>1)
           set(gca,'YScale','log'); 
        end
    end
    
    %xlim([0.1 y(n/2)]);
    %grid on;
    
    xlabel( xaxis,'Interpreter','latex');
    ylabel( yaxis,'Interpreter','latex');
    set(gca,'fontsize', fontsize)
    
end