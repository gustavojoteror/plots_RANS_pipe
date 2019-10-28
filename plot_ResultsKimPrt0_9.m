

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
locationlegend= 'northwest';

turbMod       = {'SST_Sta','MK_Mod','SA_Mod', 'SA_Sta'};           % = {'VF','SST','MK','SA'};
turbModname   = {'SST','MK-$\rho$','SA-$\rho$', 'SA'};           % = {'V2F','SST','MK','SA'};%'$\overline{v^2}-f$'};
fluid         = {'30','23','20'};
fluidname     = {'$30~kW/m^2$','$23~kW/m^2$','$20~kW/m^2$'};  
tempMod       = {'Prt0_9'};
titleSpec  = '%s';                              % title of the plot


linestyles      ={'--' , '-',  '--' , '-'};
markerstyles    ={'o' , '^' , 'v' ,  's' };
colorstyles     ={FG.brick  , FG.blue , FG.green ,  FG.green};


ncases          = [2 2 2; 1 1 2];                  % models per turbulence model
cases           = {'Sta','Mod'};
casesname       = {'RANS', 'Present study', 'Density corrected', 'Aupoix', 'Allamaras'};
DNSname         = 'DNS';

%%%%%%%%%%%%%%%%%%%%%%%%
% inputs to read RANS data

plot_var = 6;   % VARIABLES ="X", "Y", (1,2) 
% "U", "W", "C", "T", (3-6) 
% "k", "eps", "v2", "om", "nuSA", (7-11)
% "yplus", "RHO","Pe", mu, mut (12-16)
 %"lamcp","cp","alphat","kt","epst","Pk","Gk" ' (17-23)


%%%%%%%%%%%%%%%%%%%%%%
% reading thermodynamic table
init=120;  fin=120;
D=7.8/1000;      % diameter [m]
G=314;
T_0 = 273.15+15;
dtable = dlmread('data/table_props_9000.dat');
i=1;
while dtable(i,1)<T_0
    i=i+1;    
end
rho_0 = dtable(i,2); mu_0 = dtable(i,3); cp_0 = dtable(i,5); h_0 = dtable(i,6);
init_cond = [rho_0 mu_0 cp_0 h_0 G D T_0];

%%%%%%%%%%%%%%%%%%%%
% reading experimental data
addpath('data/ExpData/');
run kim20_data.m
run kim23_data.m
run kim30_data.m

% concatenating all the data to one matrix
[mk30,dummy]=size(x_k30);
x = x_k30(:);
y = Tw_k30(:);

[mk23,dummy]=size(x_k23);
x(1:mk23,2) = x_k23(:);
y(1:mk23,2) = Tw_k23(:);

% [mk20,dummy]=size(x_k20);
% x(1:mk20,2) = x_k20(:);
% y(1:mk20,2) = Tw_k20(:);
% 
% mindex=[mk30 mk23 mk20];

mindex=[mk30 mk23];


[dummy, nturb]= size(turbMod);
[dummy, nfluid]= size(fluid);

figure(1); hold off
nfluid=2;

for i=1:nfluid
    subplot(1,nfluid,(nfluid+1)-i);
    %%%%%%%%%%%%%%%%%%%%%%%%
    % ploting experimental data
    m = mindex(i);
    h0= subplotit_paper(x(1:m,i),y(1:m,i),1,'o','k',markersize,fontsize,1);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % PLOT TURBULENCE MODELS
    for j=1:nturb    
        ncpu = 16;
        imax = 192;
        kmax = 384*2;
        nvar = 16;  

        filename2 = sprintf('data/case2/Q_%s/%s/%s/',fluid{i},tempMod{1},turbMod{j});
        data      = readTecplot(filename2,ncpu, imax,kmax,nvar);
        [x_D, T_w, m]= calcKim(data, init_cond);

        linestyle   = linestyles{j};
        color       = colorstyles{j};
        hh(j) = subplotit_paper(x_D,T_w,1,linestyle,color,...
                    linesize,fontsize,1,1);


    end
    
  
    %           Pseudo-critical temperature
    % pseudo critical temperature
    Tpc = 34.7*ones(100); % 1.021*ones(100); %approx 34.23 degC
    xpc = linspace(0,160,100);
    plot(xpc,Tpc,'b-.','Color',FG.gray, 'LineWidth', linesize*0.6);

    if(i~=nfluid)
        text(130,33.2,'$T_{pc}=34.7~^{\circ}$C','fontsize',fontsize*0.6) 
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % making axis and ticks
    drawaxis
    set(gca,'TickDir','in')

    xlabel( 'Axial position, $z/D$ [-]','Interpreter','latex');
    ylabel('Wall Temperature, $T_w$ [$^{\circ}$C]','Interpreter','latex');
    if(i~=nfluid)
        set(gca, 'YAxisLocation', 'right'); 
    end
    axis([0 160 20 82])  % 0 x/L and 0 r

    set(gca,'XMinorTick','on'); %,'XLabel',[],'XTickLabel',[])
    set(gca,'YMinorTick','on'); %,'YLabel',[],'YTickLabel',[])
    set(gca,'fontsize', fontsize);
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %title
    title(sprintf(titleSpec,fluidname{i})); %,'FontWeight','bold');
    titletext = get(gca,'title');
    set(get(gca,'title'),'Position',titletext.Position + [0.0 0.0 0.0])
    
    grid off
    grid minor 
    grid minor 
    box on;
    
     % moving plots to make them fit together
    p=get(gca,'position');
    p(1) = p(1)-0.055;%0.0495;
    p(3) = p(3)+0.07;%0.0495;
    set(gca,'position',p);
    
    if((putlegend==1) & (i==2))
        h = findobj(gca,'Type','line');
        legend([h0 hh(4) hh(3) hh(2) hh(1) ],{'Exp. Data','SA', 'SA-$\rho$', 'MK-$\rho$', 'SST'},'location', locationlegend,'fontsize',fontsize*0.85);

    end
    
end
% pos=get(gcf,'position');
% pos(1) = pos(1) + -0.5;
% set(gcf, 'Position', pos)

set(gcf,'PaperUnits','points');
factor1 = 0.72; %0.78;
factor2 = 0.72; %0.78;
%set(gcf,'PaperPosition',factor*[0 0 1400 800]);

set(gcf,'PaperPosition',[0 0 factor1*1600 factor2*1600*3/5]);
print(strcat('RANS_Kimdata.eps'),'-depsc')
return


