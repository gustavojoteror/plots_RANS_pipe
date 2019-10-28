

function [uvd] = velTransVD(u,r)

    n = size(u,1);
    uvd = zeros(n,1);
    uvd(1) = 0;
    
    for i=2:n
        uvd(i) = uvd(i-1) + sqrt(0.5*(r(i)+r(i-1))/r(1))*(u(i)-u(i-1));
    end

end


