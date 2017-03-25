function [Y,D,DE,P,R,E] = gxf_isomap(X,options); 
%tic;
N = size(X,2);
dims = options.dims;
number = length(options.nn_nbr); 
Y = cell(number,1); D = cell(number,1);P = cell(number,1);R = zeros(1,number);

use_landmarks = 0;
points_list = 1:N;
if isfield(options, 'landmarks')
    use_landmarks = 1;
    landmarks = options.landmarks;
    nbr_landmarks = length(landmarks);
    points_list = landmarks;
end

%%%%% Compute Euclidean distance %%%%%
disp('Compute Euclidean distance');

[Dset,DE,E] = gxf_compute_nn_graph(X,options);
%runtime = toc;
%disp(runtime);
%%%%% Compute shortest paths %%%%%
disp('Compute shortest paths');
for i = 1:number
    %tic;
    tempD = Dset{i};
    Ws = tempD;
    Ws(find(Ws==Inf)) = 0;
    Ws = sparse(Ws);
    [tempD,tempP] = gxf_dijkstra(Ws, points_list);
    nN = N;
    if use_landmarks
        Dfull = tempD;
        tempD = tempD(:,landmarks);
        nN = nbr_landmarks;
    end
    %runtime = toc;
    %disp(runtime);
    %%%%% Construct low-dimensional embeddings (Classical MDS) %%%%%
    %tic;
    opt.disp = 0; opt.isreal = 1; opt.issym = 1; 
    M = -.5*(tempD.^2 - sum(tempD.^2)'*ones(1,nN)/nN - ones(nN,1)*sum(tempD.^2)/nN + sum(sum(tempD.^2))/(nN^2));   
    [vec, val] = eigs(M, dims, 'LR', opt);    
    tempY = real(sqrt(val)*vec');
    %runtime = toc;    disp(runtime);
    
    A = reshape(tempD,nN^2,1); r2 = 1-corrcoef(reshape(real(L2_distance(tempY, tempY)),nN^2,1),A).^2;
    R(i) = r2(2,1); D{i} = tempD;    P{i} = tempP;
    clear A;
    
    if use_landmarks
        xy1 = zeros(N,dims);
        % transpose of embedding
        LT = tempY; 
        for s=1:dims
            LT(s,:) = LT(s,:) / val(s);
        end
        deltan = mean(tempD,2);
        for t=1:N
            deltax = Dfull(:,t);
            xy1(t,:) = 1/2 * ( LT * ( deltan-deltax ) )';
        end
        tempY = xy1';
    end;
    
    Y{i} = tempY;
end;
fprintf(1,'- Done.\n');

