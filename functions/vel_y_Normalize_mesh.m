function [un,utau, yn] = vel_y_Normalize_mesh(u,r,mu,mesh)

    [dudy, y] = calcdudy(u,mesh);
    utau = sqrt(mu(1)*dudy(1)/r(1));
    
    un = u/utau;
    yn = y*utau*r(1)/mu(1);
    
end

