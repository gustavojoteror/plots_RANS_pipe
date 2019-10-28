

clear all 
close all

set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');

addpath('functions');
addpath('plotfunctions');
addpath('figurefunctions');
plotInputs

putlegend=0;       % 1: yes, 0:no
set(0,'DefaultLegendAutoUpdate','off')
locationlegend= 'northeast';

press         = {'5_5MPa','7_4MPa','8_5MPa','9_5MPa'};  
pressname     = {'$5.5$~bar ($p_{crit} > p$)','$7.4$~bar  ($p_{crit} \approx p$)','$8.5$~bar  ($p_{crit} < p$)','$9.5$~bar  ($p_{crit} < p$)'};
titleSpec  = '%s';                              % title of the plot

[dummy, npress]= size(press);


%%%%%%%%%%%%%%%%%%%%%%%%
% inputs 
plot_var = 2;   % VARIABLES ="1:temp", "2:rho", "3:mu",
%                             "4:lam", "5:cp", "6:ent", "7:beta"
plot_var_name_short = {'temp', 'rho', 'mu', 'lam', 'cp', 'h', 'beta'};
plot_var_name = {'$T$ [$^{\circ}$C]', '$\rho$ [kg/m$^3$]', ...
'$\mu$ [N s/m$^2$]', '$\lambda$ [W/(m~K)]' ....
'$c_p$ [kJ/(kg~K)]', '$h$ [kJ/kg]', '$\beta$ [1/K]'       };

[dummy, nvar]= size(plot_var_name);

switch plot_var
%     case 2
%         axis([20 60 0 100]);
%     case 3
%         axis([20 60 0 1*10^-4]);
%     case 4
%         locationlegend= 'norteast';
    case 5
        locationlegend= 'southeast';
    case 6
        locationlegend= 'southeast';
end


for j=2:2
    
    
    figure(j); hold off
    plot_var = 4; %j;   
    
    for i=1:npress
        filename2 = sprintf('table/co2_%s_table.dat',press{i});
        dtable = dlmread(filename2);

        Temp = dtable(:,1)-273.15;
        variable = dtable(:,plot_var);


        linestyle   = linestyles{i};
        makerstyle  = markerstyles{i};
        color       = colorstyles{i};

        h1= subplotit_paper(Temp,variable,1,linestyle,color,...
                        linesize,fontsize,1,1);

    end

    % making axis and ticks
    drawaxis
    set(gca,'TickDir','in')

    xlabel(plot_var_name{1},'Interpreter','latex');
    ylabel(plot_var_name{plot_var},'Interpreter','latex');
    
    set(gca,'XMinorTick','on'); %,'XLabel',[],'XTickLabel',[])
    set(gca,'YMinorTick','on'); %,'YLabel',[],'YTickLabel',[])
    
    switch plot_var
        case 2
            axis([20 60 0 1000]);
            yticks([0:200:1000]);
        case 3
            axis([20 60 0 1*10^-4]);
            yticks([0:2*10^-5:1*10^-4]);
        case 4
            axis([20 60 0 0.12]);
            yticks([0:0.02:0.12]);
        case 5
            axis([20 60 0 20]);
        case 6
            axis([20 60 200 600]);
    end

   
    
    
    set(gca,'fontsize', fontsize);

    if((putlegend==1))
        h = findobj(gca,'Type','line');
        legend([h(4) h(3) h(2) h(1) ],{pressname{1},pressname{2},pressname{3},pressname{4}},'location', locationlegend,'fontsize',fontsize*0.85);

    end

    % size of the paper and saving image
    set(gcf,'PaperUnits','points');
    set(gca,'fontsize', fontsize)
    scaling = 0.87;
    set(gcf,'PaperPosition',[0 0 750 450]*scaling);
    filename3 = sprintf('table/co2_%sVs%s_plot.eps',plot_var_name_short{1},plot_var_name_short{plot_var});
    if((putlegend==1))
        filename3 = sprintf('table/co2_%sVs%s_plot_leg.eps',plot_var_name_short{1},plot_var_name_short{plot_var});
    end    
    print(strcat(filename3),'-depsc')

end
return


