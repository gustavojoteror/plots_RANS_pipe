function [Tstar, ystar, Ttau] = tempTransAP_direct(T,Tw,u,r,mu,mesh)

    %dTdy= mesh.ddy*T(2:n-1);                                                    
    %dTdy(1:n-3:n-2) = dTdy(1:n-3:n-2) + mesh.ddybc(1:n-1:n).*T(1:n-1:n);
    cp = 1;
    Pr = 1;
    lambda = mu/Pr;
    dudy = calcdudy(u,mesh);
    utau = sqrt(mu(1)*dudy(1)/r(1));
    
    
    [dTdy] = calcdudy(T,mesh);
    
    dTdy_w = dTdy(1);

    qw   = lambda(1)*dTdy_w;
    Ttau = qw/(r(1)*cp(1)*utau);
    
    [Tvd] = velTransVD((T-Tw)/Ttau,r);
    [Tstar, ystar] = velTransAP(Tvd,r,mu,mesh);
    
end

