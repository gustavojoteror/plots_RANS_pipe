

function [MESH] = mesh(n, fact)

    dy = 2.0/(n-1);     %di for gus
    di = dy;

    %fact = 4.0; %4.0;
    yi = ((0:n-1))/(n-1) - 0.5;
    y = 1.0 + tanh(fact*yi)/tanh(fact*0.5);
    y = y';

    didy = 2.0*tanh(fact/2.0)/fact*cosh(fact*yi).^2.0;
    d2ydi2 = -0.5*fact^2/tanh(fact/2.)*tanh(fact*yi)./cosh(fact*yi).^2;
    
    [ddy,ddybc,d2dy2,d2dy2bc] = calcDerivativMatrices(dy,didy,d2ydi2);
    
    MESH = struct('y',y,'dy',dy,'ddy',ddy,'ddybc',ddybc,'d2dy2',d2dy2,'d2dy2bc',d2dy2bc, 'di', di, 'yprime', 1./didy, 'd2ydi2',d2ydi2);
    
end

