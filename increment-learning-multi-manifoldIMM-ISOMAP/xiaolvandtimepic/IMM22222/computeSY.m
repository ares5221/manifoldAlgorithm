function sy = computeSY(DG,d)

opt.disp = 0; opt.isreal = 1; opt.issym = 1; 
N = size(DG,2);
M = -.5*(DG.^2 - sum(DG.^2)'*ones(1,N)/N - ones(N,1)*sum(DG.^2)/N + sum(sum(DG.^2))/(N^2));   
[vec, val] = eigs(M, d, 'LR', opt);    
sy = real(sqrt(val)*vec');