

clear all 
close all

To = 28+273.15;

set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');

addpath('functions');
addpath('plotfunctions');
addpath('figurefunctions');
colDat = 2;

plotInputs

% reading dns data
skip = 1;
tmp = dlmread('data/DNS_Hassan/Wall_Temp/Jbulk');   dataA = [tmp(1:skip:end,1) tmp(1:skip:end,4)]; % A 60 long
tmp = dlmread('data/DNS_Hassan/Wall_Temp/Bbulk');   dataB = [tmp(1:skip:end,1) tmp(1:skip:end,4)];
tmp = dlmread('data/DNS_Hassan/Wall_Temp/Hbulk');   dataC = [tmp(1:skip:end,1) tmp(1:skip:end,4)];   % C 60 long
tmp = dlmread('data/DNS_Hassan/Wall_Temp/Dbulk');   dataD = [tmp(1:skip:end,1) tmp(1:skip:end,4)];
tmp = dlmread('data/DNS_Hassan/Wall_Temp/Ebulk');   dataE = [tmp(1:skip:end,1) tmp(1:skip:end,4)];   % downward

% concatenating all the data to one matrix
[mA,n]=size(dataA);
dataDNS = dataA;
[mB,n]=size(dataB);
dataDNS(1:mB,:,2) = dataB;
[mC,n]=size(dataC);
dataDNS(1:mC,:,3) = dataC;
[mD,n]=size(dataD);
dataDNS(1:mD,:,4) = dataD;
[mE,n]=size(dataE);
dataDNS(1:mE,:,5) = dataE;

mindex=[mA mB mC mD mE];

figure(1); 

dir = '/home/gjoterorodrigu/PhD/Dropbox/PhD/Codes/Repository/plots_RANS_pipe';

% subplot(3,2,1); 
hold off
 
for i=1:3
    linestyle   = linestyles{i};
    makerstyle  = markerstyles{i};
    color       = colorstyles{i};
    x = dataDNS(:,1,i);
    y = dataDNS(:,colDat,i)*To - 273.15;

    m = mindex(i);

    h1= subplotit_paper(x(1:m),y(1:m),1,linestyle,color,...
                    linesize,fontsize,1,1);
    
end

% making axis and ticks
drawaxis
set(gca,'TickDir','in')

xlabel( 'Axial position, $z/D$ [-]','Interpreter','latex');
ylabel('Wall Temperature, $T_w$ [$^{\circ}$C]','Interpreter','latex');
axis([0 60 28 90]);

set(gca,'XMinorTick','on'); %,'XLabel',[],'XTickLabel',[])
set(gca,'YMinorTick','on'); %,'YLabel',[],'YTickLabel',[])
set(gca,'fontsize', fontsize);


% pseudo critical temperature
Tpc = 34.7*ones(100); % 1.021*ones(100); %approx 34.23 degC
xpc = linspace(0,60,100);
plot(xpc,Tpc,'b-.','Color',FG.gray, 'LineWidth', linesize*0.6);
text(40,37,'$T_{pc}=34.7~^{\circ}$C','fontsize',fontsize) 


% instead of a legend we add this
h=text(30,70,'A: Forced convection','fontsize',fontsize*0.9,'color',colorstyles{1}) ; set(h, 'rotation', 3)
h=text(4,48,'B: Upward flow with low buoyancy','fontsize',fontsize*0.9,'color',colorstyles{2}) ; set(h, 'rotation', 39.2)
h=text(20,53,'C: Upward flow with high buoyancy','fontsize',fontsize*0.9,'color',colorstyles{3}) ; set(h, 'rotation', 6)
%h=text(8,40,'D: Upward flow with moderate buoyancy','fontsize',fontsize*0.9,'color',colorstyles{4}) ; set(h, 'rotation', 3.5)

% size of the paper and saving image
set(gcf,'PaperUnits','points');
set(gca,'fontsize', fontsize)
scaling = 1.1;
set(gcf,'PaperPosition',[0 0 750 450]*scaling);
print(strcat('DNS_data.eps'),'-depsc')




