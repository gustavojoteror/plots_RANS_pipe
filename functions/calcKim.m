
function [x_dir, T_w, m]= calcKim(data, init_cond)

    % conditions at the inflow of the domain
    rho_0 = init_cond(1);    mu_0 = init_cond(2);   cp_0 = init_cond(3);
    h_0   = init_cond(4);mass_flux= init_cond(5);    D   = init_cond(6);
    T_0   = init_cond(7);    
    w_0 = mass_flux/rho_0;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    kmax=size(data,2);

    T_w = zeros(kmax,1); x_dir = zeros(kmax,1); G_b = zeros(kmax,1);
    for i=1:kmax

        % reading the data from the file (all dimensionaless)
        
        rad     = reduced_vector (data(:,i,2));
        T       = T_0*reduced_vector(data(:,i,6))-273.15; % making it celsius
        
        n       = length(rad);
        
        % calculating 
        T_w(i)  = T(n);     % wall temperature 
        x_dir(i)     = data(1,i,1);      
    end

    m=kmax;

end
