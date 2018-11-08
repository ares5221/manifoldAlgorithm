function [y,landmarks] = computerNewY(X,list,Ws1,relationPs,relationPs1,sX,sY,d,DG,D1,center,edgePs);

sn = length(sX); allLength=0;
landmarks = []; cL = [];
for i = 1:sn
    allLength = allLength + length(sX{i});
    
    cL = [cL length(landmarks)+1];    
    landmarks = [landmarks center(i)];    %%%center
    nn = find(Ws1(:,i)); 
    for j = 1:length(nn)   
        temp = relationPs{i,nn(j)}; landmarks = [landmarks temp(1)];
        temp = relationPs1{i,nn(j)}; landmarks = [landmarks temp(1)];
    end;    
end;
cL = [cL length(landmarks)+1];

DE = ones(length(landmarks),length(landmarks))*Inf;
for i = 1:sn
    DE(cL(i):cL(i+1)-1,cL(i):cL(i+1)-1) = DG(landmarks(cL(i):cL(i+1)-1),landmarks(cL(i):cL(i+1)-1));
    
    nn = find(Ws1(:,i));
    for j = 1:length(nn)
        n2 = find(Ws1(:,nn(j))); loc = find(n2==i);
        s1 = cL(i)+2*j-1;  s2 = cL(nn(j))+2*loc-1;
         temp = relationPs{i,nn(j)};
        DE(s1,s2) = D1(temp(2),temp(1)); DE(s2,s1) = D1(temp(2),temp(1)); 
%         temp = relationPs1{i,nn(j)};
%         DE(s1+1,s2+1) = D1(temp(2),temp(1)); DE(s2+1,s1+1) = D1(temp(2),temp(1));         
    end;
end;
Ws = min(DE,DE'); Ws(find(Ws==Inf)) = 0;    Ws = sparse(Ws);
[tempD,tempP] = dijkstra(Ws,1:length(landmarks));
tempY = computeSY(tempD,d);
% % %%%%%%%%%%用来计算DC-ISOMAP算法在实际人脸数据X，X1-X6的残差%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  nN = size(tempD,2);R = zeros(1,1);
  A = reshape(tempD,nN^2,1); r2 = 1-corrcoef(reshape(real(L2_distance(tempY, tempY)),nN^2,1),A).^2;
      R = r2(2,1);
%  R;
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
newY = {};
for i = 1:sn
    sA = landmarks(cL(i):cL(i+1)-1);   tempC = tempY(:,cL(i):cL(i+1)-1);
    [gxfY bb] = transY(sX{i},sA,sY{i},tempC,d);
    newY{i} = gxfY; 
end;
y = ones(d,allLength)*Inf;
for i = 1:sn    y(:,sX{i}) = newY{i};end;


options.dims = 2; options.nntype=0; options.nn_nbr =10;
[Dset,DE,E] = gxf_compute_nn_graph(X,options);
tempD = Dset{1};
Ws = tempD; Ws(find(Ws==Inf)) = 0; Ws = sparse(Ws);
[gxfDG,tempP] = dijkstra(Ws, 1:size(X,2));
gxfDD = gxfDG(list,list);
tempD = gxfDD(landmarks,landmarks);
tempY = computeSY(tempD,d);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
newY = {};
for i = 1:sn
    sA = landmarks(cL(i):cL(i+1)-1);   tempC = tempY(:,cL(i):cL(i+1)-1);
    [gxfY bb] = transY(sX{i},sA,sY{i},tempC,d);
    newY{i} = gxfY; 
end;
y1 = ones(d,allLength)*Inf;
for i = 1:sn    y1(:,sX{i}) = newY{i};end;
