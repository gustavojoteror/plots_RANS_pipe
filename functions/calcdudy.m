function [dudy, y] = calcdudy(u,mesh)

    n = size(u,1);
      
    if(size(mesh.y,1)~=n)
        ddy = mesh.ddy(1:n-2,1:n-2); 
        ddybc = zeros(n,1);
        ddybc(1) =  mesh.ddybc(1);
        ddybc(n) = -ddy(n-2,n-3);
        y = mesh.y(1:n);
    else
        ddy = mesh.ddy;
        ddybc = mesh.ddybc;
        y = mesh.y;
    end

    dudy = zeros(n,1);
    dudy(2:n-1) = ddy(1:n-2,1:n-2) * u(2:n-1);
    dudy(2:n-3:n-1) = dudy(2:n-3:n-1) + ddybc(1:n-1:n).*u(1:n-1:n);
    dudy(1:n-1:n) = interp1(y(2:n-1),dudy(2:n-1),y(1:n-1:n),'pchip','extrap');
    

end