
%
set(groot, 'DefaultTextInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter','latex'); 
set(groot, 'defaultLegendInterpreter','latex');

FG.blue         = [0 0 1] ;                                                         %blue
FG.orange       = [0.850980401039124 0.325490206480026 0.0980392172932625];         %orange
FG.yellow       = [0.75 0.75 0];                                                    %yellow
FG.purple       = [0.49 0.18 0.56];                                                 %purple
FG.green        = [0 0.85 0];                                                          %green
FG.cyan         = [0.301960796117783 0.745098054409027 0.933333337306976];          %cyan
FG.brick        = [1 0 0] ;                                                         %brick


%Grayscale:
FG.ColorG0      = [0 0 0];													%black
FG.gray         = [0.5 0.5 0.5];                                            %gray
FG.ColorG2      = [0.8 0.8 0.8];											%greyish
plotingFact     = 1;
markersize      = 9;
linesize        = 2.5;
fontsize        = 28;%18;

plotstyle={'bx' , 'g+' , 'b*' ,  'ms' , 'rd', 'o'};
plotstyle1={'rx' , 'g+' , 'b-.' ,  'm--' , 'r:', '-'};

linestyles      ={'--' , '-',  ':' , '-.' , '-'};
markerstyles    ={'o' , '^' , 'v' ,  's' , 's', '>'};
colorstyles     ={FG.brick  , FG.blue , FG.green ,  FG.ColorG0 , FG.purple, FG.cyan};
