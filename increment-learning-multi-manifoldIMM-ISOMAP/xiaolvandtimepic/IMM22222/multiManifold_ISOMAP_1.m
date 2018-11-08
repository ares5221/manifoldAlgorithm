function [y,y1,sX,sY,newAllNeighbor,newDE,newDG,newP] = multiManifold_ISOMAP_1(XX,d,r,maxAngle,X1,sX,sY,allNeighbor,DE,DG,P,T,ss)
    %%list就是ss分块的列表
    %%%%%%%%%%%%%%%%%%%%%decomposition process%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    newX=[XX X1];
    N = size(newX,2); 
    oldN = size(XX,2);
    %D1是原来矩阵的欧氏距离矩阵
    D1 = L2_distance(newX,newX,1);
    %%% 找近邻关系
    %%% 1. Get Neighborhood
    %%% %%%%%%%%%%%############################################################################
    [D2,D3] = sort(D1);
    newAllNeighbor = cell(N,1); newDE = ones(N,N)*Inf; newDG = ones(N,N)*Inf; newP =  ones(N,N)*Inf;
    for i=1:oldN
        newAllNeighbor{i} = allNeighbor{i};
    end;
    for i=oldN+1:N
        newDE(:,i)=D1(:,i);
    end;
   
    newDE(1:oldN,1:oldN) = DE;
    newDG(1:oldN,1:oldN) = DG;
    newP(1:oldN,1:oldN) = P;

    for i = oldN+1:N
        [neighbor,U,nSame] = getDNNofOnePoint(i,newX,D1(:,i),d,r,maxAngle);
        newAllNeighbor{i} = neighbor; 
    end;

    %增量处理新的数据newX
    [newsX,allNeighbor,newDE,newDG,newP] =ljf_increasePointsDNN(X1,XX,newDG,newDE,newP,sX,newAllNeighbor,D1,DE);

    % Get the embeddings of sub-manifolds %%%%%%%%%%%
    sY={}; 
    for i = 1:length(newsX)
        tempX = newsX{i}; 
        tempDE = newDE(tempX,tempX);  
        Ws = min(tempDE,tempDE');  
        Ws(find(Ws==Inf)) = 0;   
        Ws = sparse(Ws);

        [tempDG,tempP] = dijkstra(Ws,1:length(tempX)); 
        newDG(tempX,tempX) = tempDG;  
        newP(tempX,tempX) = tempP;

        tempY =[]; 
        tempY =computeSY(tempDG,d); 
        sY = [sY tempY];  
    end;    
    %%% %%%%%%%%%%%没有调整坐标系时候的低维映射图####################################################################
  
    %%%%%%%%%%%%%%%%%%%%%composition process%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [relationPs,relationPs1,Ws1,center,edgePs] = composition(d,newsX, allNeighbor,newDG,newP,D1,sY);
    %%%4.transformation%%%
    [y,y1,landmarks] = computerNewY(T,ss,Ws1,relationPs,relationPs1,newsX,sY,d,newDG,D1,center,edgePs);

