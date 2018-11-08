function [X,col,DG] = load_points_set( name, n, options )

% load_points_set - load a 3D sample dataset
%
%   name is either
%   'swissroll','square','scurve','swisshole','corner_plane',
%   'puncted_sphere','twin_peaks','3d_cluster','toroidal_helix','rand_gaussian'
%   'spiral', 'circles'
%   n is the number of points
%   options.sampling can be 'rand' or 'uniform'
%   options.noise_level is to add some jitter.
%
%   Copyright (c) 2005 Gabriel Peyr?

options.null = 0;

if isfield(options, 'noise_level')
    noise_level = options.noise_level;
else
    noise_level = 0;
end

if isfield(options, 'sampling')
    sampling = options.sampling;
else
    sampling = 'rand';
end

if strcmp( name, 'scurve' )
    n = round(n/2);
end

if strcmp(sampling, 'rand')
    x = rand(n,1);
    y = rand(n,1);
else
    n = ceil(sqrt(n))^2;
    x = linspace(0,1,sqrt(n));
    [y,x] = meshgrid(x,x);
    x = x(:); y = y(:);
end

if (strcmp(name, 'test1') | strcmp(name, 'test2') | strcmp(name, 'test3'))
    X = zeros(2,n);
else
    col = x;
    X = zeros(3,n);
    X(1,:) = x;
    X(2,:) = y;
end;

ExParam = 1;

DG = zeros(n,n);
switch lower(name)
    case 'sinline'
        v= 3*pi/2 * (1 + 2*x');
        X(1,:) = sin( v );
        X(3,:) = v;
        X(2,:) = 5* y';
    case 'swissroll'
        s = 1.5; % # tours
        L = 21; % width
        v = 3*pi/2 * (1 + 2*x');
        X(2,:) = L * y';
        X(1,:) = cos( v ) .* v;
        X(3,:) = sin( v ) .* v;
        
    case 'swissrollhole'
        tt = (3*pi/2)*(1+2*rand(1,2*n));  
        height = 21*rand(1,2*n);
        kl = repmat(0,1,2*n);
        for ii = 1:2*n
            if ( (tt(ii) > 9)&(tt(ii) < 12))
                if ((height(ii) > 9) & (height(ii) <14))
                    kl(ii) = 1;
                end;
            end;
        end;
        kkz = find(kl==0);
        tt = tt(kkz(1:n));
        height = height(kkz(1:n));
        X = [tt.*cos(tt); height; ExParam*tt.*sin(tt)]';     
        col = tt';
        X = X';
        
    case 'square'
        X(1,:) = x';
        X(2,:) = y';
        
    case  'scurve'
        X = zeros(3,2*n);
        tt = (1.5*x-1)*pi; uu = tt(end:-1:1); hh = [y;y]*5;
        X(1,:) = [cos(tt); -cos(uu)]';
        X(2,:) = hh';
        X(3,:) = [sin(tt); 2-sin(uu)]';
        col = [tt;uu]';
        
    case 'puncted_sphere'
        height = 0.5;
        % generate point on a sphere
        X = randn(3,n);
        d = sqrt( X(1,:).^2 + X(2,:).^2 + X(3,:).^2 );
        X(1,:) = X(1,:)./d;
        X(2,:) = X(2,:)./d;
        X(3,:) = X(3,:)./d;
        % truncate
        I = find(X(3,:)<height);
        X = X(:,I);
        col = X(3,:);
        
    case 'twin_peaks'
        inc = 1.5 / sqrt(n);  % inc = 0.1;
        xx2 = 2*x-1;
        yy2 = 2*y-1;
        zz2 = sin(pi*xx2).*tanh(3*yy2);
        xy = 1-2*rand(2,n);
        X = [xy; sin(pi*xy(1,:)).*tanh(3*xy(2,:))]';
        X(:,3) = ExParam * X(:,3);
        col = X(:,3);
        X=X';        
             
    case '3d_cluster'
        numClusters = 3;
        numClusters = max(1,numClusters);
        Centers = 10*rand(numClusters,3);
        D = compute_distance_to_points(Centers',Centers');
        minDistance = min(D(find(D>0)));
        k = 1;
        N2 = n - (numClusters-1)*9;
        for i = 1:numClusters
            for j = 1:ceil(N2/numClusters)
                X(1:3,k) = Centers(i,1:3)'+(rand(3,1)-0.5)*minDistance/(12);
                ColorVector(k) = i;
                k = k + 1;
            end;
            % Connect clusters with straight line.
            if i < numClusters
                for t = 0.1:0.1:0.9
                    X(1:3,k) = Centers(i,1:3)' + (Centers(i+1,1:3)'-Centers(i,1:3)')*t;
                    ColorVector(k) = 0;
                    k = k+1;
                end;
            end;
        end;
        X = X;
        col = ColorVector;
        
    case 'toroidal_helix'  % Toroidal Helix by Coifman & Lafon
        noiseSigma=0.05;   %noise parameter
        t = (1:n)'/n;
        t = t.^(ExParam)*2*pi;
        X = [(2+cos(8*t)).*cos(t) (2+cos(8*t)).*sin(t) sin(8*t)]+noiseSigma*randn(n,3);
        col = t;
        
    case 'gaussian'  % Gaussian randomly sampled
        x = 2*x-1;
        y = 2*y-1;
        X(3,:) = 3.9 * exp ( (-x.^2 - y.^2) / (2*ExParam^2) );
        col = X(3,:);

    case 'circles'
        r1 = 1;
        r2 = 0.5;
        theta = rand(n/2,1)*2*pi;
        % theta = linspace(0,2*pi-2*pi/n,n)';
        X1 = r1 * [ cos(theta), sin(theta) ];
        theta = rand(n/2,1)*2*pi;
        % theta = linspace(0,2*pi-2*pi/n,n)';
        X2 = r2 * [ cos(theta), sin(theta) ];
        X = [ X1; X2 ]';

    case 'spiral'
        % spiral
        theta = linspace(0,2*pi-2*pi/n,n)';
        r = linspace(0,1,n)';
        m = 3;
        X = [ r.*cos(m*theta), r.*sin(m*theta) ]';
	case 'test1'
        data = zeros(1,n); 
        data(1,1) = 0;
        for i = 2:n
            data(1,i) = data(1,i-1) + 0.10 * (0.001 + abs(cos(data(1,i-1))));
        end;
        X(1,:) = cos(data);
        X(2,:) = sin(data);
        col = data;
    case 'test2'
        s = 12/(n-1);
        tt = [-6:s:6];
        X(1,:) = tt;
        X(2,:) = 10 * exp (-tt.^2);
        col = tt;
    case 'test3'
        v = 1.7*pi * (1 + 2*x');
        X(1,:) = cos( v ) .* v;
        X(2,:) = sin( v ) .* v;
        col =x;
    otherwise
        error('Unknown point set.');
end

% X = reshape(X,3,max(size(X)));

X = X + randn(size(X))*noise_level;