

if(saveplot==1)
       figunam  = strcat(name_,'_.eps');
       filename = strcat(name_,'_Figure.eps');
       print(filename,'-depsc');
end