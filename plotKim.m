

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
locationlegend= 'southeast';

addpath('data/ExpData/');


% inputs
G = 400 ; % [kg/(m s]
q29 = 29.3; %[kW/m2]
q49 = 48.8; %[kW/m2]
Diam = 6.32/1000; % [m]

run kim20_data.m
run kim23_data.m
run kim30_data.m


figure(1); hold off

k=1;

%%%%%%%%%%%%%%%%%%%%%%%%
% ploting for kim 20
linestyle   = linestyles{k};
makerstyle  = markerstyles{k};
color       = colorstyles{k};
x = x_k20(:); %-506.9;
y = Tw_k20(:);
h0= subplotit_paper(x(:),y(:),1,'o',color,markersize,fontsize,1);
if(putlegend~=1)
    h=text(120,40,'$q"=20 kW/m^2$','fontsize',fontsize*0.7,'color',color) ; 
    set(h, 'rotation', 3)
end
k=k+1;
%%%%%%%%%%%%%%%%%%%%%%%%
% ploting for kim 23              
linestyle   = linestyles{k};
makerstyle  = markerstyles{k};
color       = colorstyles{k};
x = x_k23(:); %-506.9;
y = Tw_k23(:);
h1= subplotit_paper(x(:),y(:),1,'o',color,markersize,fontsize,1);
if(putlegend~=1)
    h=text(113,50,'$q"=23 kW/m^2$','fontsize',fontsize*0.7,'color',color) ; 
    set(h, 'rotation', 11)
end

k=k+1;
%%%%%%%%%%%%%%%%%%%%%%%%
% ploting for kim 30              
linestyle   = linestyles{k};
makerstyle  = markerstyles{k};
color       = colorstyles{k};
x = x_k30(:); %-506.9;
y = Tw_k30(:);
h2= subplotit_paper(x(:),y(:),1,'o',color,markersize,fontsize,1);
if(putlegend~=1)
    h=text(70,55,'$q"=30 kW/m^2$','fontsize',fontsize*0.7,'color',color) ; 
    set(h, 'rotation', 13)
end
h = findobj(gca,'Type','line');

if(putlegend==1)
    legend([h0 h1 h2],{'$20~kW/m^2$','$23~kW/m^2$', '$30~kW/m^2$'},'location', locationlegend);
end

% %%%%%%%%%%%%%%%%%%%%%%%%
% % ploting   bulk temperature
% h2=plot(h_b29,Tb_b29,'-.','LineWidth',1,'Color',[0.5 0.5 0.5]); hold on;
% h=text(-290,4,'Bulk Temperature','FontSize',fontsize*0.7);  set(h,'Rotation',27);
% 
% %           Pseudo-critical temperature 
% h=text(-60,38.5,'T$_{pc}$ = 35.3 $^{\circ}$C','FontSize',fontsize*0.7); 
% h3 = plot([-400 100],[35.3 35.3],'--','LineWidth',0.8,'Color',[0.6 0.6 0.6]);
% 
% %           Pseudo-critical enthalpy
% h_pc=340.4-506.9;
% h=text(-175,67,'h$_{pc}$ = -166.5 kJ/kg','FontSize',fontsize*0.7); set(h,'Rotation',90);
% h4 = plot([h_pc h_pc],[-20 160],'--','LineWidth',0.8,'Color',[0.6 0.6 0.6]);

%%%%%%%%%%%%%%%%%%%%%%%%
% making axis and ticks
drawaxis
set(gca,'TickDir','in')

xlabel( 'Axial position, $z/D$ [-]','Interpreter','latex');
ylabel('Wall Temperature, $T_w$ [$^{\circ}$C]','Interpreter','latex');
axis([0 160 20 62])  % 0 x/L and 0 r

set(gca,'XMinorTick','on'); %,'XLabel',[],'XTickLabel',[])
set(gca,'YMinorTick','on'); %,'YLabel',[],'YTickLabel',[])
set(gca,'fontsize', fontsize);

% pseudo critical temperature
Tpc = 34.7*ones(100); % 1.021*ones(100); %approx 34.23 degC
xpc = linspace(0,160,100);
plot(xpc,Tpc,'b-.','Color',FG.gray, 'LineWidth', linesize*0.6);
text(130,33.2,'$T_{pc}=34.7~^{\circ}$C','fontsize',fontsize*0.6) 



% size of the paper and saving image
set(gcf,'PaperUnits','points');
set(gca,'fontsize', fontsize)
scaling = 1.1;
set(gcf,'PaperPosition',[0 0 750 450]*scaling);
print(strcat('Kim_data.eps'),'-depsc')

return


