function [ddy,ddybc,d2dy2,d2dy2bc] = calcDerivativMatrices(di,didy,d2ydi2)

    n = size(didy,2);
    
    % set matrix for single derivative ddy
    % dudy = didy*du/di 
    % Central difference dudi= (u_i+1-u_i-1)/2di
    ud =  didy(2:n-2)/(2*di);
    ud =  sparse(1:n-3,2:n-2,ud,n-2,n-2);
    ld = -didy(3:n-1)/(2*di);   
    ld =  sparse(2:n-2,1:n-3,ld,n-2,n-2);
    ddy = ud+ld;
    ddybc = zeros(n,1);
    ddybc(1) = -ddy(1,2);
    ddybc(n) = -ddy(n-2,n-3);

    % set matrix for second derivative d2dy2
    % d2udy2 = didy^2*du2/di2  - didy^3*dudi*d2ydi2
    % Second order finite difference d2udi2= (u_i+1-2*u_i+u_u-1)/di^2
    ud = didy(2:n-2).^2/di^2 - d2ydi2(2:n-2).*didy(2:n-2).^3/(2*di);
    ud = sparse(1:n-3,2:n-2,ud,n-2,n-2);
    ld = didy(3:n-1).^2/di^2 + d2ydi2(3:n-1).*didy(3:n-1).^3/(2*di);
    ld = sparse(2:n-2,1:n-3,ld,n-2,n-2);
    d  = -2*didy(2:n-1).^2/di^2;
    d  = sparse(diag(d));
    d2dy2 = ud+ld+d;
    d2dy2bc    =  zeros(n,1);
    d2dy2bc(1) = -(d2dy2(1,2)+d2dy2(1,1));
    d2dy2bc(n) = -(d2dy2(n-2,n-3)+d2dy2(n-2,n-2)); %d2dy2bc(1);
    
end

