

clear all 
close all

set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');

addpath('functions');
addpath('plotfunctions');
addpath('figurefunctions');
plotInputs

putlegend=1;       % 1: yes, 0:no
set(0,'DefaultLegendAutoUpdate','off')
locationlegend= 'southeast';

addpath('data/ExpData/');

% inputs
G = 400 ; % [kg/(m s]
q29 = 29.3; %[kW/m2]
q49 = 48.8; %[kW/m2]
Diam = 6.32/1000; % [m]

run bae29p3.m
run bae48p8.m



figure(1); hold off

%%%%%%%%%%%%%%%%%%%%%%%%
% ploting for base 29
linestyle   = linestyles{1};
makerstyle  = markerstyles{1};
color       = colorstyles{1};
x = x_b29(:)-506.9;
y = Tw_b29(:);
h0= subplotit_paper(x(:),y(:),1,'o',color,markersize,fontsize,1);
if(putlegend~=1)
    h=text(-105,46,'$q"=29.3 kW/m^2$','fontsize',fontsize*0.7,'color',colorstyles{1}) ; 
    set(h, 'rotation', 31)
end
                
%%%%%%%%%%%%%%%%%%%%%%%%
% ploting for base 49              
linestyle   = linestyles{2};
makerstyle  = markerstyles{2};
color       = colorstyles{2};
x = x_b49(:)-506.9;
y = Tw_b49(:);
h1= subplotit_paper(x(:),y(:),1,'o',color,markersize,fontsize,1);
if(putlegend~=1)
    h=text(-110,83,'$q"=48.8 kW/m^2$','fontsize',fontsize*0.7,'color',colorstyles{2}) ; 
    set(h, 'rotation', 30)
end

if(putlegend==1)
    legend([h0 h1],{'$29.3~kW/m^2$','$48.8~kW/m^2$'},'location', locationlegend);
end
%%%%%%%%%%%%%%%%%%%%%%%%
% ploting   bulk temperature
h2=plot(h_b29,Tb_b29,'-.','LineWidth',1,'Color',[0.5 0.5 0.5]); hold on;
h=text(-290,4,'Bulk Temperature','FontSize',fontsize*0.7);  set(h,'Rotation',27);

%           Pseudo-critical temperature 
h=text(-60,38.5,'T$_{pc}$ = 35.3 $^{\circ}$C','FontSize',fontsize*0.7); 
h3 = plot([-400 100],[35.3 35.3],'--','LineWidth',0.8,'Color',[0.6 0.6 0.6]);

%           Pseudo-critical enthalpy
h_pc=340.4-506.9;
h=text(-175,67,'h$_{pc}$ = -166.5 kJ/kg','FontSize',fontsize*0.7); set(h,'Rotation',90);
h4 = plot([h_pc h_pc],[-20 160],'--','LineWidth',0.8,'Color',[0.6 0.6 0.6]);

%%%%%%%%%%%%%%%%%%%%%%%%
% making axis and ticks
drawaxis
set(gca,'TickDir','in')

xlabel( 'Bulk enthalpy, $h_b$ [kJ/kg]','Interpreter','latex');
ylabel('Wall Temperature, $T_w$ [$^{\circ}$C]','Interpreter','latex');
axis([-300 0 0 120])  % 0 x/L and 0 r

set(gca,'XMinorTick','on'); %,'XLabel',[],'XTickLabel',[])
set(gca,'YMinorTick','on'); %,'YLabel',[],'YTickLabel',[])
set(gca,'fontsize', fontsize);

% size of the paper and saving image
set(gcf,'PaperUnits','points');
set(gca,'fontsize', fontsize)
scaling = 1.1;
set(gcf,'PaperPosition',[0 0 750 450]*scaling);
print(strcat('Bae_data.eps'),'-depsc')


