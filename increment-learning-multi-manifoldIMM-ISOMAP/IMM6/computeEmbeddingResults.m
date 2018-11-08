function newY = computeEmbeddingResults(Y,newDG);
nN = size(newDG,2);
[dims,number] = size(Y);
M = -.5*(newDG.^2 - sum(newDG.^2)'*ones(1,nN)/nN - ones(nN,1)*sum(newDG.^2)/nN + sum(sum(newDG.^2))/(nN^2));
  
f = M(1:number,number+1:end);
eV = zeros(dims,dims);
for i = 1:dims
    eV(i,i) = Y(i,:)*Y(i,:)';
end;

U = f'*Y'*inv(eV);
tempU = sum(U)/size(U,1);
U = U-ones(size(U,1),1)*tempU;
for i=1:size(U,2)
    for j=1:i-1
        U(:,i)=U(:,i)-(U(:,i)'*U(:,j))*U(:,j);
    end
    U(:,i)=U(:,i)/norm(U(:,i));
end;
UN = [inv(eV^(1/2))*Y U']';
newU = 1/sqrt(2)*UN;

%{
U =Y'*inv(eV^(1/2));
newU = [Y inv(eV^(1/2))*U'*f]';
%}

Z = M * newU;
[Q,R] = qr(Z);
Q = Q(:,1:dims);
newZ = Q' * M * Q;
opt.disp = 0; opt.isreal = 1; opt.issym = 1; 
[vec, val] = eigs(newZ, dims, 'LR', opt);
newV = Q* vec;
newY = real(sqrt(val) * newV');
%}
%%%%%%%%%%%%%%%%%%%%%%%%%