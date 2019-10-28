
function [ustar, ystar ,utau] = velTransAP_direct(u,r,mu,mesh)

    ur = real(u);

    [dudy] = calcdudy(ur,mesh);
    utau = sqrt(mu(1)*dudy(1)/r(1));
    [uvd] = velTransVD(ur/utau,r);
    [ustar, ystar] = velTransAP(uvd,r,mu,utau,mesh);
    
end

