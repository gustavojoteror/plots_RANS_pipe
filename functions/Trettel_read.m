function [u,T,r,mu,viscstr,uv,kine,uh, mut] = Trettel_read(fname,ReT,utau,y,mesh)

% ddy = MESH.ddy;

    %ReT = 1.87612424e+03;  utau = 3.22850675e-02; 
    fname = '../RANSchannel/Trettel_data/compChannelTrettel/M3.0R600_data.csv';

    dat = dlmread(fname,',',100);
    
    y2 = [dat(:,1);2-dat(end:-1:1,1)];
    dat = [dat(1:end,:);dat(end:-1:1,:)];
    
    
    r   = dat(1:end,10);     r  = interp1(y2,r,y,'spline')/r(1);
    T   = dat(1:end,12);     T  = interp1(y2,T,y,'spline');
    u   = dat(1:end,6);      u  = interp1(y2,u,y,'spline');
    mu  = dat(1:end,14);     mu = interp1(y2,mu,y,'spline')/mu(1)/ReT;%*ReT;
    uh  = dat(1:end,22);     uh = interp1(y2,uh,y,'spline');
    uv  = dat(1:end,18);     uv = -interp1(y2,uv,y,'spline').*r/utau/utau; 
    uu  = dat(1:end,15);      uu = interp1(y2,uu,y,'spline')/utau/utau; 
    vv  = dat(1:end,16);      vv = interp1(y2,vv,y,'spline')/utau/utau; 
    ww  = dat(1:end,17);      ww = interp1(y2,ww,y,'spline')/utau/utau; 
    kine = 0.5*(uu+vv+ww);
    % mu  = 1/Reb.*T.^0.7;

    % ub = trapz(y,u)/2;
    % rb = trapz(y,r)/2;

    % calculate viscous scales 
    n = length(y);
    [dudy] = calcdudy(u,mesh);
    %dudy = zeros(n,1);
    %dudy(2:n-1) = ddy*u(2:n-1);     
    %dudy(1:n-1:n) = interp1(y(2:n-1),dudy(2:n-1),y(1:n-1:n),'pchip','extrap');
    viscstr = mu.*dudy;
    mut = abs(r.*uv./dudy);
    
    ReySt = mut.*dudy;

% trapz(y,mu)/2
% 
%     figure(12); hold off 
%     %plot(y,uv, '-k'); hold on
%     %plot(y,1-y, 'db'); hold on
%     plot(y,viscstr, '-b'); hold on
%     %plot(y,uv+viscstr,'rx','LineWidth',2); hold on
%     %plot(y,uv.*r+viscstr,'r-','LineWidth',2); hold on
%     plot(y, ReySt, '-k');
%     plot(y, ReySt+viscstr,'r-');
%     
%     %plot(y,uv.*r, 'ko'); hold on
%     %plot(y,viscstr); hold on
%     hud=-1;


end




