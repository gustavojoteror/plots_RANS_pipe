

clear all 
close all

To = 28+273.15;

set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');

addpath('functions');
addpath('plotfunctions');
addpath('figurefunctions');



formatSpec = 'data/%s/%s_%s/';               % data/caseX/turbMod_mode/
%                               caseX: caseA, caseB, caseC, caseD, caseE
%                               turbMod: MK, SA, SST, VF
%                               mode: Sta, Mod

nameSpec   = '%s';                              % name of the output file
titleSpec  = '%s';                              % title of the plot
saveplot=1;                                     % save plot? 0:no, 1:yes
putlegend=1;                                    % add legend 1: yes, else:no
set(0,'DefaultLegendAutoUpdate','off')
locationlegend='southeast';                     %location of the legend

turbMod       = {'SST','MK','SA'};           % = {'VF','SST','MK','SA'};
turbModname   = {'SST','MK','SA'};           % = {'V2F','SST','MK','SA'};%'$\overline{v^2}-f$'};
fluid         = {'caseC','caseB','caseA'};     %= {'caseE','caseD','caseC','caseB','caseA'};
fluidname     = {'case C','case B','case A'};  %= {'case E','case D','case C','case B','case A'};


ncases          = [2 2 2 2 2];                  % models per turbulence model
cases           = {'Sta','Mod'};
casesname       = {'RANS', 'Present study', 'Density corrected', 'Aupoix', 'Allamaras'};
DNSname         = 'DNS';

colDat = 2;
deltaTemp = 100;

[dummy, nturb]= size(turbMod);
[dummy, nfluid]= size(fluid);


plotInputs

%loop over the fluids
figure(1); 
for i=1:nfluid

    subplot(1,nfluid,(nfluid+1)-i);
    scaling = 1;
    if (fluid{i}=='caseA' | fluid{i}=='caseC')
        scaling = 2;
    end
    skip = scaling*40;
    xmax = scaling*30;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %--------- reading DNS data 
    filename = sprintf('data/DNS_Hassan/Twall/%s',fluid{i});
    tmp = dlmread(filename);   dataDNS = [tmp(1:skip:end,1) tmp(1:skip:end,4)]; 
    xdns = dataDNS(:,1);
    Tdns = dataDNS(:,colDat)*To - 273.15;
    Tpc = 34.7;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % PLOT TURBULENCE MODELS and DNS
    for j=1:nturb
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % plot dns
        Tdns1=Tdns(:)+(j-1)*deltaTemp;
        h0= subplotit_paper(xdns,Tdns1,1,'o','k',markersize,fontsize,1);
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % pseudo critical temperature
        Tpc1=(Tpc+(j-1)*deltaTemp)*ones(100); 
        xpc = linspace(0,(xmax+scaling*2),100);
        plot(xpc,Tpc1,'b-.','Color',FG.gray, 'LineWidth', linesize*0.6);
        if(i==nfluid-1)
            text((xmax/2+scaling*5),40+(j-1)*deltaTemp,'$T_{pc}=34.7~^{\circ}$C','fontsize',fontsize*0.65) 
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % turb model name (left hand side)
        if (i==nfluid)
            h = text(-5, 70+(j-1)*deltaTemp, turbModname{j}); %, 'Color', [0.3, 0.3, 0.3])
            set(h,'Rotation',90, 'FontSize', 22, 'FontWeight', 'bold');
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 
        %                     data/caseX/turbMod_mode/
        % plotting for standard turb model
        k=2; 
            filename2    = sprintf('data/%s/%s_%s/',fluid{i},turbMod{j},cases{k});
            dataRans = ReadRansX(filename2,4);
            T = (1.0*(dataRans(:,5)-1)+1)*To - 273.15;
            Trans = T(:)+(j-1)*deltaTemp;
            xrans = dataRans(1:1:end,1)-0.15;
            makerstyle  = markerstyles{k};
            color       = colorstyles{k};
            linestyle   = linestyles{k};
            h2= subplotit_paper(xrans,Trans,1,linestyle,color,...
                        linesize,fontsize,1,1);
        
        % plotting for standard turb model
        k=1; 
            filename1    = sprintf('data/%s/%s_%s/',fluid{i},turbMod{j},cases{k});
            dataRans = ReadRansX(filename1,4);
            T = (1.0*(dataRans(:,5)-1)+1)*To - 273.15;
            Trans = T(:)+(j-1)*deltaTemp;
            xrans = dataRans(1:1:end,1)-0.15;
            makerstyle  = markerstyles{k};
            color       = colorstyles{k};
            linestyle   = linestyles{k};
            h1= subplotit_paper(xrans,Trans,1,linestyle,color,...
                        linesize,fontsize,1,1);
        
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % axis and ticks
    drawaxis
    xlabel( 'Axial position, $z/D$ [-]','Interpreter','latex');
    axis([0 (xmax+scaling*2) 0 nturb*100]);
    set(gca,'TickDir','in')
    set(gca, 'xTick', [0 xmax/3 2*xmax/3 xmax ]);
    if(i<nfluid)
        set(gca, 'xtickLabel', [{' ', xmax/3, 2*xmax/3, xmax}]); 
    else
        set(gca, 'xtickLabel', [{0, xmax/3, 2*xmax/3, xmax}]); 
    end
    
    ax = gca;
    ax.YAxis.MinorTick = 'on';
    ax.YAxis.MinorTickValues = 0:5:(nturb*deltaTemp);
    ax.YMinorGrid = 'on';
    
    if(nturb==5)
        set(gca, 'yTick', [0           25             50             75             100 ...
                             deltaTemp+25   deltaTemp+50   deltaTemp+75   deltaTemp+100 ...
                           2*deltaTemp+25 2*deltaTemp+50 2*deltaTemp+75 2*deltaTemp+100 ...
                           3*deltaTemp+25 3*deltaTemp+50 3*deltaTemp+75 3*deltaTemp+100 ...
                           4*deltaTemp+25 4*deltaTemp+50 4*deltaTemp+75 4*deltaTemp+100 ]);
    elseif(nturb==4)
        set(gca, 'yTick', [0           25             50             75             100 ...
                             deltaTemp+25   deltaTemp+50   deltaTemp+75   deltaTemp+100 ...
                           2*deltaTemp+25 2*deltaTemp+50 2*deltaTemp+75 2*deltaTemp+100 ...
                           3*deltaTemp+25 3*deltaTemp+50 3*deltaTemp+75 3*deltaTemp+100 ]);
    elseif(nturb==3)
        set(gca, 'yTick', [0           25             50             75             100 ...
                             deltaTemp+25   deltaTemp+50   deltaTemp+75   deltaTemp+100 ...
                           2*deltaTemp+25 2*deltaTemp+50 2*deltaTemp+75 2*deltaTemp+100 ]);
    end
    
    if(i==nfluid) %if(mod(i-1,2)==0 || subplotting==0) 
        set(gca, 'YtickLabel', [{' '}]); 
        
        
    elseif(i==1)
        ylabel('Wall Temperature, $T_w$ [$^{\circ}$C]','Interpreter','latex');
        if(nturb==5)
            set(gca, 'YtickLabel', [{'0','25','50','75','0','25','50','75','0','25','50','75','0','25','50','75','0','25','50','75','100'}],'YAxisLocation', 'right'); 
        elseif(nturb==4)
            set(gca, 'YtickLabel', [{'0','25','50','75','0','25','50','75','0','25','50','75','0','25','50','75','100'}],'YAxisLocation', 'right'); 
        elseif(nturb==3)
            set(gca, 'YtickLabel', [{'0','25','50','75','0','25','50','75','0','25','50','75','100'}],'YAxisLocation', 'right'); 
        end

    elseif(i==2) 
        set(gca,'YtickLabel',[]);  
    elseif(i==3)
        set(gca,'YtickLabel',[]);  
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %title
    title(sprintf(titleSpec,fluidname{i})); %,'FontWeight','bold');
    titletext = get(gca,'title');
    set(get(gca,'title'),'Position',titletext.Position + [0.0 0.04 0.0])
    
    grid off
    grid minor 
    grid minor 
    box on;
    
    % moving plots to make them fit together
    p=get(gca,'position');
    p(1) = p(1)-0.06;%0.0495;
    p(3) = p(3)+0.07;%0.0495;
    set(gca,'position',p);
    
    if((putlegend==1) & (i==1))
        hl=legend([h0 h1 h2],{'DNS','Conventional', '$\rho$-modified'},'location', locationlegend,'fontsize',fontsize*0.85);
    end
    
end

% pos=get(gcf,'position');
% pos(1) = pos(1) + -0.5;
% set(gcf, 'Position', pos)

set(gcf,'PaperUnits','points');
factor1 = 0.72; %0.78;
factor2 = 0.72; %0.78;
%set(gcf,'PaperPosition',factor*[0 0 1400 800]);

set(gcf,'PaperPosition',[0 0 factor1*1600 factor2*1600*nturb/5]);
print(strcat('RANS_DNSdata.eps'),'-depsc')
return
