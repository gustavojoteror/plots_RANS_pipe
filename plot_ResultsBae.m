

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

turbMod       = {'SST','MK','SA'};           % = {'VF','SST','MK','SA'};
turbModname   = {'SST','MK','SA'};           % = {'V2F','SST','MK','SA'};%'$\overline{v^2}-f$'};
fluid         = {'48','29'};
fluidname     = {'$48.8~kW/m^2$','$29.3~kW/m^2$'};  
tempMod       = {'Prt0_9'};
titleSpec  = '%s';                              % title of the plot


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
D=6.32/1000;      % diameter [m]
G=400;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T_29 = 274.15;
T_49 = 278.15;
dtable = dlmread('data/table_props_9000.dat');
i=1;
while dtable(i,1)<T_29
    i=i+1;    
end
rho_29 = dtable(i,2); mu_29 = dtable(i,3); cp_29 = dtable(i,5); h_29 = dtable(i,6);

i=1;
while dtable(i,1)<T_49
    i=i+1;    
end
rho_49 = dtable(i,2); mu_49 = dtable(i,3); cp_49 = dtable(i,5); h_49 = dtable(i,6);


%%%%%%%%%%%%%%%%%%%%
% reading experimental data
addpath('data/ExpData/');
run bae29p3.m
run bae48p8.m

% concatenating all the data to one matrix
[mb49,dummy]=size(x_b49);
x = x_b49(:)-506.9;
y = Tw_b49(:);

[mb29,dummy]=size(x_b29);
x(1:mb29,2) = x_b29(:)-506.9;
y(1:mb29,2) = Tw_b29(:);

mindex=[mb49 mb29];


[dummy, nturb]= size(turbMod);
[dummy, nfluid]= size(fluid);

figure(1); hold off

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
        
        if(i==2)
            init_cond = [rho_29 mu_29 cp_29 h_29 G D T_29];
            init=120;%120;
            fin=120;
            ncpu = 32;
            imax = 192/2;
            kmax = 1152;
            nvar = 23;
            k=2;
            filename2 = sprintf('data/case1/Q_%s/%s/%s_%s/',fluid{i},tempMod{1},turbMod{j},cases{k});
            data      = readTecplot(filename2,ncpu, imax,kmax,nvar);
            [h_b, T_w, m]= calcBulkEnthalpyBae(data, init_cond, fin);

            linestyle   = linestyles{k};
            color       = colorstyles{j};
            h2= subplotit_paper(h_b(init:m),T_w(init:m),1,linestyle,color,...
                        linesize,fontsize,1,1);
        
            k=1;
            filename2 = sprintf('data/case1/Q_%s/%s/%s_%s/',fluid{i},tempMod{1},turbMod{j},cases{k});
            data      = readTecplot(filename2,ncpu, imax,kmax,nvar);
            [h_b, T_w, m]= calcBulkEnthalpyBae(data, init_cond, fin);

            linestyle   = linestyles{k};
            color       = colorstyles{j};
            h1= subplotit_paper(h_b(init:m),T_w(init:m),1,linestyle,color,...
            linesize,fontsize,1,1);
        else
            init_cond = [rho_49 mu_49 cp_49 h_49 G D T_49];
            init=140;
            ncpu = 32;
            imax = 128;
            kmax = 1152;
            nvar = 23;
            if(j==3)
                k=2;
                filename2 = sprintf('data/case1/Q_%s/%s/%s_%s/',fluid{i},tempMod{1},turbMod{j},cases{k});
                data      = readTecplot(filename2,ncpu, imax,kmax,nvar);
                [h_b, T_w, m]= calcBulkEnthalpyBae(data, init_cond, fin);

                linestyle   = linestyles{k};
                color       = colorstyles{j};
                h2= subplotit_paper(h_b(init:m),T_w(init:m),1,linestyle,color,...
                            linesize,fontsize,1,1);

                k=1;
                filename2 = sprintf('data/case1/Q_%s/%s/%s_%s/',fluid{i},tempMod{1},turbMod{j},cases{k});
                data      = readTecplot(filename2,ncpu, imax,kmax,nvar);
                [h_b, T_w, m]= calcBulkEnthalpyBae(data, init_cond, fin);

                linestyle   = linestyles{k};
                color       = colorstyles{j};
                h1= subplotit_paper(h_b(init:m),T_w(init:m),1,linestyle,color,...
                linesize,fontsize,1,1);
            elseif(j==1)
                k=1;
                filename2 = sprintf('data/case1/Q_%s/%s/%s_%s/',fluid{i},tempMod{1},turbMod{j},cases{k});
                data      = readTecplot(filename2,ncpu, imax,kmax,nvar);
                [h_b, T_w, m]= calcBulkEnthalpyBae(data, init_cond, fin);

                linestyle   = linestyles{k};
                color       = colorstyles{j};
                h1= subplotit_paper(h_b(init:m),T_w(init:m),1,linestyle,color,...
                linesize,fontsize,1,1);                    
            elseif(j==2)
                 k=2;
                filename2 = sprintf('data/case1/Q_%s/%s/%s_%s/',fluid{i},tempMod{1},turbMod{j},cases{k});
                data      = readTecplot(filename2,ncpu, imax,kmax,nvar);
                [h_b, T_w, m]= calcBulkEnthalpyBae(data, init_cond, fin);

                linestyle   = linestyles{k};
                color       = colorstyles{j};
                h2= subplotit_paper(h_b(init:m),T_w(init:m),1,linestyle,color,...
                            linesize,fontsize,1,1);
            end
            
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % ploting   bulk temperature
    h2=plot(h_b29,Tb_b29,'-.','LineWidth',1,'Color',[0.5 0.5 0.5]); hold on;
    h=text(-290,4,'Bulk Temperature','FontSize',fontsize*0.7);  set(h,'Rotation',45);

    %           Pseudo-critical temperature 
    if(i~=nfluid)
        h=text(-85,38.5,'T$_{pc}$ = 35.3 $^{\circ}$C','FontSize',fontsize*0.7); 
    end
    h3 = plot([-400 100],[35.3 35.3],'--','LineWidth',0.8,'Color',[0.6 0.6 0.6]);
    
    %           Pseudo-critical enthalpy
    h_pc=340.4-506.9;
    h=text(-175,80,'h$_{pc}$ = -166.5 kJ/kg','FontSize',fontsize*0.7); set(h,'Rotation',90);
    h4 = plot([h_pc h_pc],[-20 160],'--','LineWidth',0.8,'Color',[0.6 0.6 0.6]);
    
    %%%%%%%%%%%%%%%%%%%%%%%%
    % making axis and ticks
    drawaxis
    set(gca,'TickDir','in')

    xlabel( 'Bulk enthalpy, $h_b$ [kJ/kg]','Interpreter','latex');
    ylabel('Wall Temperature, $T_w$ [$^{\circ}$C]','Interpreter','latex');
    if(i~=nfluid)
        set(gca, 'YAxisLocation', 'right'); 
    end
    axis([-300 0 0 120])  % 0 x/L and 0 r

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
        legend([h(10) h(4) h(5)  h(6) h(7) h(8) h(9) ],{'Exp. Data','SA', 'SA-$\rho$','MK', 'MK-$\rho$','SST', 'SST-$\rho$'},'location', locationlegend,'fontsize',fontsize*0.85);
        %legend([h(10) ],{'Exp. Data'},'location', locationlegend);

        %hl=legend([h0 h1 h2],{'DNS','Conventional', '$\rho$-modified'},'location', locationlegend,'fontsize',fontsize*0.85);
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
print(strcat('RANS_Baedata.eps'),'-depsc')
return


