function [locs] = splitdomain(dudy_)

    n = size(dudy_,1);
    dudy=dudy_(2:n-1); 
    
    locs2 = n/2;
    for i=2:n-2
        sign= dudy(i-1)*dudy(i);
     	if(sign<0)
        	locs2 = i; 
        	break;
        end
    end
    
    locs = locs2;
    
    
end