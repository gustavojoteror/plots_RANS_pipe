yppp = linspace(-1,13,100);
semilogx(yppp,yppp,'b-.','Color',FG.gray);
yppp = linspace(0.9,5,20);
ulog = 1/0.41*log(10.^yppp)+5.5; %5.5;
semilogx(10.^yppp,ulog,'b-.','Color',FG.gray);