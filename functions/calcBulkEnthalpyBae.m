
function [h_b, T_w, m]= calcBulkEnthalpyBae(data, init_cond, fin)

    % conditions at the inflow of the domain
    rho_0 = init_cond(1);    mu_0 = init_cond(2);   cp_0 = init_cond(3);
    h_0   = init_cond(4);mass_flux= init_cond(5);    D   = init_cond(6);
    T_0   = init_cond(7);    
    w_0 = mass_flux/rho_0;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    kmax=size(data,2);

    T_w = zeros(kmax,1); h_b = zeros(kmax,1); G_b = zeros(kmax,1);
    for i=1:kmax

        % reading the data from the file (all dimensionaless)
        rad     = reduced_vector (data(:,i,2));
        rho     = rho_0*reduced_vector(data(:,i,13));
        T       = T_0*reduced_vector(data(:,i,6))-273.15; % making it celsius
        w       = w_0* reduced_vector (data(:,i,4));
        h       = cp_0*T_0*reduced_vector (data(:,i,5)) + h_0;
        
        n       = length(rad);
        
        % calculating 
        T_w(i)  = T(n);     % wall temperature 
        rho_u   = rho.* w;  % momentum
        rho_u_h = rho_u.*h; % enthalpy transported
        
        % calculating bulks
        rhoub  = trapz(rad,rho_u)/2;
        rhouhb = trapz(rad,rho_u_h)/2;
        
        h_b(i) = rhouhb/rhoub;        
    end

    m=kmax-fin;

end
