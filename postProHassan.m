

clear all 
% close all


set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');


FSZ = 24;
LW = 3;
MSZ = 10;
TickLength = [0.025 0.05];
MarkerSize = 8;
LineWidth = 2;

widthPos = 0.265;
heightPos = 0.275;

plotmovey = -0.0;





%dlmread('/Users/renep/Dropbox/Research/RANS_pipe/DNS_Hassan/Wall_Temp/...)
dataA = dlmread('DNS_Hassan/Wall_Temp/Abulk');
dataB = dlmread('DNS_Hassan/Wall_Temp/Bbulk');
dataC = dlmread('DNS_Hassan/Wall_Temp/Cbulk');
dataD = dlmread('DNS_Hassan/Wall_Temp/Dbulk');
dataE = dlmread('DNS_Hassan/Wall_Temp/Ebulk');   % downward
dataF = dlmread('DNS_Hassan/Wall_Temp/Fbulk');   % forced high Q
dataG = dlmread('DNS_Hassan/Wall_Temp/Gbulk');   % mixed high Q, case G
dataH = dlmread('DNS_Hassan/Wall_Temp/Hbulk');   % C 60 long
dataJ = dlmread('DNS_Hassan/Wall_Temp/Jbulk');   % A 60 long

datA = dlmread('DNS_Bae/A.txt');   
datB = dlmread('DNS_Bae/B.txt');   
datC = dlmread('DNS_Bae/C.txt');  
datD = dlmread('DNS_Bae/D.txt'); 
datE = dlmread('DNS_Bae/E.txt'); 





skip = 50;

%figure(1); 
hold on
turbMod         = {'SA','MK', 'VF','OM'};


mod = 'VF';


cas = 'cAL';
data = 'H'; %H or B
if(data=='H') %hassan data
    switch cas
        case {'cA','cAL'}
            h1=plot(dataJ(1:skip:end,1), dataJ(1:skip:end,4),'ko','MarkerSize',MarkerSize,'LineWidth',LineWidth); hold on;
        case {'cB','cBL'} 
            h1=plot(dataB(1:skip:end,1), dataB(1:skip:end,4),'ko','MarkerSize',MarkerSize,'LineWidth',LineWidth); hold on;
        case {'cC','cCL'}
            h1=plot(dataH(1:skip:end,1), dataH(1:skip:end,4),'ko','MarkerSize',MarkerSize,'LineWidth',LineWidth); hold on;
        case {'cD','cDL'}
            h1=plot(dataD(1:skip:end,1), dataD(1:skip:end,4),'ko','MarkerSize',MarkerSize,'LineWidth',LineWidth); hold on;
        case {'cE','cEL'} 
            h1=plot(dataE(1:skip:end,1), dataE(1:skip:end,4),'ko','MarkerSize',MarkerSize,'LineWidth',LineWidth); hold on;

    end
else %bae data
    switch cas
        case {'cA','cAL'}
            h1=plot(datA(1:end,1), datA(1:end,2),'k^','MarkerSize',MarkerSize,'LineWidth',LineWidth); hold on;
        case {'cB','cBL'} 
            h1=plot(datB(1:end,1), datB(1:end,2),'k^','MarkerSize',MarkerSize,'LineWidth',LineWidth); hold on;
        case {'cC','cCL'}
            h1=plot(datC(1:end,1), datC(1:end,2),'k^','MarkerSize',MarkerSize,'LineWidth',LineWidth); hold on;
        case {'cD','cDL'}
            h1=plot(datD(1:end,1), datD(1:end,2),'k^','MarkerSize',MarkerSize,'LineWidth',LineWidth); hold on;
        case {'cE','cEL'}
            h1=plot(datE(1:end,1), datE(1:end,2),'k^','MarkerSize',MarkerSize,'LineWidth',LineWidth); hold on;

    end
end


%---- Conventional
vers = 'noMod_90'; %vers = 'noMod'; %vers = 'modNew';
%------------------
filename  = sprintf('clusterAll/%s_%s',cas,mod);
filename2 = sprintf('%s_%s/',filename,vers);
dataRans = ReadRansX(sprintf('%s/%s/',filename2,mod),4);
%------------------
%filename = sprintf('caseA/%s_%s',cas,mod);
%dataRans = ReadRansX(sprintf('%s_%s/',filename,vers),4);
T = 1.0*(dataRans(:,5)-1)+1;
h3=plot(dataRans(1:1:end,1)-0.15, T,'r-','MarkerSize',MarkerSize,'LineWidth',LineWidth);  hold on;
size(dataRans(:,5));

%---- Modified
vers = 'modNew_90'; %vers = 'noMod_90'; %vers = 'modNew_90';
%------------------
filename  = sprintf('clusterAll/%s_%s',cas,mod);
filename2 = sprintf('%s_%s/',filename,vers);
dataRans = ReadRansX(sprintf('%s/%s/',filename2,mod),4);
%dataRans = ReadRansX('caseA/OM/',4);
%------------------
%filename = sprintf('caseA/%s_%s',cas,mod);
%dataRans = ReadRansX(sprintf('%s_%s/',filename,vers),4);
T = 1.0*(dataRans(1:1:end,5)-1)+1;
h3=plot(dataRans(1:1:end,1)-0.15, T,'b-.','MarkerSize',MarkerSize,'LineWidth',LineWidth);

%---- Modified
vers = 'Aupoix_90';
%------------------
filename  = sprintf('clusterAll/%s_%s',cas,mod);
filename2 = sprintf('%s_%s/',filename,vers);
dataRans = ReadRansX(sprintf('%s/%s/',filename2,mod),4);
%dataRans = ReadRansX('caseA/OM/',4);
%------------------
%filename = sprintf('caseA/%s_%s',cas,mod);
%dataRans = ReadRansX(sprintf('%s_%s/',filename,vers),4);
T = 1.0*(dataRans(1:1:end,5)-1)+1;
h3=plot(dataRans(1:1:end,1)-0.15, T,'g:','MarkerSize',MarkerSize,'LineWidth',LineWidth);

% %---- Aupoix
% vers = 'Aupoix';
% filename = sprintf('caseA/%s_%s',cas,mod);
% dataRans = ReadRansX(sprintf('%s_%s/',filename,vers),4);
% T = 1.0*(dataRans(1:1:end,5)-1)+1;
% h3=plot(dataRans(1:1:end,1)-0.15, T,'g:','MarkerSize',MarkerSize,'LineWidth',LineWidth);

% filename = sprintf('/Users/renep/Documents/Research/RANS_pipe/caseA/cC_VF_modNew',mod);
% dataRans = ReadRansX(sprintf('/Users/renep/Documents/Research/RANS_pipe/caseA/cC_VF_modNew/',filename),4);
% T = 1.0*(dataRans(1:5:end,5)-1)+1;
% h3=plot(dataRans(1:5:end,1)-0.15, T,'b-o','MarkerSize',MarkerSize,'LineWidth',LineWidth);


% dataRans = ReadRansX('/Users/renep/Documents/Research/RANS_pipe/caseA/cA_VF_Aupoix/',4);
% T = 1.0*(dataRans(:,5)-1)+1;
% h3=plot(dataRans(1:1:end,1)-0.15, T,'m-','MarkerSize',MarkerSize,'LineWidth',LineWidth);  hold on;




xlabel('$x/D$','Interpreter','latex');
ylabel('Wall temperature $T/T_0$','Interpreter','latex');
% legend([h2 h3 h1],'Original model','"Semi-local" model','DNS','Location','northwest');
% legend([h3 h2  h1],'Original ystar','"Semi-local" model','DNS','Location','northwest');
set(gca,'fontsize', 24)

set(gca, 'XMinorTick', 'on')
% set(gca, 'XTick', [0:5:30])

set(gca, 'YMinorTick', 'on')
% set(gca, 'YTick', [0:5:30])

xlim([0 90]);
ylim([1 1.65]);
saveas(gcf,'cAL_VF_90.png')


