function [y,y1,sX] = multiManifold_ISOMAP(XX,col1,d,r,maxAngle,X1,col11)
%%list就是ss分块的列表
%%%%%%%%%%%%%%%%%%%%%decomposition process%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = size(XX,2); 
%D1是原来矩阵的欧氏距离矩阵
D1 = L2_distance(XX,XX,1);
%%% 找近邻关系
%%% 1. Get Neighborhood
%%% %%%%%%%%%%%############################################################################
[sX,allNeighbor,DE]= getNeighborhood(XX,D1,d,r,maxAngle);

%%% 2. Get the embeddings of sub-manifolds %%%%%%%%%%%
sY={}; 
for i = 1:length(sX)
    tempX = sX{i}; 
    tempDE = DE(tempX,tempX);  
    Ws = min(tempDE,tempDE');  
    Ws(find(Ws==Inf)) = 0;   
    Ws = sparse(Ws);
    
    [tempDG,tempP] = dijkstra(Ws,1:length(tempX)); 
    DG(tempX,tempX) = tempDG;  
    P(tempX,tempX) = tempP;
   
    tempY =[]; 
    tempY =computeSY(tempDG,d);   
    sY = [sY tempY];  
end;

%画出初始的1500个点的低维映射
%  Y = cell2mat(sY);   
% figure;   
% hin=scatter(Y(1,:),Y(2,:),50,list,'filled');  
% set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
% hold off;
%%% %%%%%%%%%%%#Incrementtal newPoint########################################################
%get new points
times=3;t = 200;
for ggg = 1:times
    XXX=X1(:,t*(ggg-1)+1:t*ggg);
    %col2 = col11(t*(ggg-1)+1:t*ggg);

    newPoints=XXX;
    
    if(ggg==1)
    %    newcol=[col1' col2']';
    end;
    if(ggg~=1)
        XX=newX;
    %    newcol=[newcol' col2']';
        DG=newDG;
        DE=newDE;
        P=newP;
        sX=newsX;
    end;

    %增量处理新的数据newX
    [newsX,allNeighbor,newDE,newDG,newP,newD1,newX] =ljf_increasePointsDNN(newPoints,XX,DG,DE,P,sX,allNeighbor,ggg);

    %[newX,newDG,thisDE,newP,newD1] = increasePointsKNN(newPoints,XX,DG,DE,P,8,newcol);
    %重新划分子流形sX
    %[sX,allNeighbor,newDE]= getNeighborhood1(newX,newDG,d,r,maxAngle,thisDE);

    %   figure;    
    %   thisC=newcol';
    %   hold on; 
    %         hin=scatter(thisY(1,:),thisY(2,:),50,thisC,'filled');
    %         set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);   
    %    hold off;
    %得到新的子流形
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
    %{ 
    Y1 = cell2mat(sY(1));Y2 = cell2mat(sY(2)); Y3 = cell2mat(sY(3));
     figure;
    hin=scatter(Y1(1,:),Y1(2,:),50,'filled');
    set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); hold on;
    hin=scatter(Y2(1,:),Y2(2,:),50,'filled');
    set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); hold on;
    hin=scatter(Y3(1,:),Y3(2,:),50,'filled');
    set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); hold on;
    %}
    %%%%%%%%%%%%%%%%%%%%%composition process%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [relationPs,relationPs1,Ws1,center,edgePs] = composition(d,newsX, allNeighbor,newDG,newP,newD1,sY);
    %%%4.transformation%%%
    [y,landmarks] = computerNewY(newX,1:1000,Ws1,relationPs,relationPs1,newsX,sY,d,newDG,newD1,center,edgePs);
end;
