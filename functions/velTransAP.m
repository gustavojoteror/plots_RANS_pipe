


function [ustar, ystar] = velTransAP(uvd,r,mu,utau,mesh)

    n = size(uvd,1);
    %y = min(mesh.y,2-mesh.y);
    y = mesh.y;

    ReTau  = utau*r(1)/mu(1); 
    
    RTS = ReTau*sqrt(r/r(1))./(mu/mu(1));  %sqrt(r)./mu;
    dRTSdy = calcdudy(RTS,mesh);
    %dRTSdy = zeros(n,1);
    %dRTSdy(2:n-1) = mesh.ddy*RTS(2:n-1);
    %dRTSdy(2:n-3:n-1) = dRTSdy(2:n-3:n-1) + mesh.ddybc(1:n-1:n).*RTS(1:n-1:n);
    %dRTSdy(1:n-1:n) = interp1(y(2:n-1),dRTSdy(2:n-1),y(1:n-1:n),'pchip','extrap');
    tmp = 1 + y./RTS.*dRTSdy;

    ustar = zeros(n,1);
    for i=2:n
        ustar(i) = ustar(i-1) + 0.5*(tmp(i)+tmp(i-1))*(uvd(i)-uvd(i-1));
    end
    
    ystar = y.*RTS;
end




