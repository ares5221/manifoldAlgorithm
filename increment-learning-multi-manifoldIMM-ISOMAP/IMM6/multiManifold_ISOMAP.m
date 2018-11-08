function [y,newsX] = multiManifold_ISOMAP(XX,col1,d,r,maxAngle,X1,col11,M,k,newM)
%%list就是ss分块的列表
tic;
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
toc;
%第一次的图
 Y = cell2mat(sY);   
figure; hold on; plot_flattened_dataset(Y,M,k); hold off;
%%% %%%%%%%%%%%#Incrementtal newPoint########################################################
%get new points
times=1;t = 22;
for ggg = 1:times
    
     XXX=X1(:,t*(ggg-1)+1:t*ggg);
    col2 = col11(t*(ggg-1)+1:t*ggg);
tic;
   
    newPoints=XXX;
    if(ggg==1)
     newcol=[col1 col2];
    end;
if(ggg~=1)
    XX=newX;
    newcol=[newcol col2];
    DG=newDG;
    DE=newDE;
    P=newP;
    sX=newsX;
end;

%增量处理新的数据newX
[newsX,allNeighbor,newDE,newDG,newP,newD1,newX] =ljf_increasePointsDNN(newPoints,XX,DG,DE,P,sX,allNeighbor,ggg);


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

y=cell2mat(sY);
figure; hold on; plot_flattened_dataset(y,newM,k); hold off;
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
%{
%%%%%%%%%%%%%%%%%%%%%composition process%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% 1.Get centers  and  out-layer points %%%%%%%%%%
center = [];edgePs = {};
for i = 1:length(newsX)
    tp = newsX{i};    sDG = newDG(tp,tp);
    [temp,order] = sort(sDG);    
    [temp,order] = sort(temp(end,:));
    center = [center tp(order(1))];%%%中心点
    
    neighbors = allNeighbor{tp(order(1))};
    nonEdges = [];
    for j = 1:length(neighbors)
        temp = find(tp==neighbors(j));
        nonEdges = [nonEdges temp];
    end;
    
    edges = getEdgePs(nonEdges,order(1),tp,newP(tp,tp),d,sY{i});
    edgePs{i} = tp(edges);
end;
%%% 2 .块最近连接点&块中心最近连接点 %%%%%%%%%%
sn = length(newsX);
relationPs = cell(sn,sn);%%%块最近连接点
relationPs1 = cell(sn,sn);%%%块中心最近连接点
dcs = ones(sn,sn)*Inf;
for i = 1:sn
    dcs(i,i) = 0; 
    for j = i+1:sn
        temp = newD1(edgePs{i},edgePs{j});  %%%%newD1=newDE = L2_distance(newX,newX,1);
        [t1,t2] = min(temp); [t1,t3] = min(t1); 
        iEdge = edgePs{i}; jEdge = edgePs{j};
        relationPs{i,j} = [iEdge(t2(t3)) jEdge(t3)];%%%%%%%%%%块连接点
        relationPs{j,i} = [jEdge(t3) iEdge(t2(t3))];%%%%%%%%%%块连接点
        dcs(i,j) = t1; dcs(j,i) = t1;
        
        tempDD = repmat(newDG(iEdge,center(i)),1,length(jEdge)) + newD1(iEdge,jEdge) + ...
            + repmat(newDG(center(j),jEdge),length(iEdge),1);
        [t1,t2] = min(tempDD); [t1,t3] = min(t1);
        relationPs1{i,j} = [iEdge(t2(t3)) jEdge(t3)];%%%%%%%%%%块连接点
        relationPs1{j,i} = [jEdge(t3) iEdge(t2(t3))];%%%%%%%%%%块连接点
    end;
end;

%%%3.块聚类%%%
Ws1=[];
if (sn < d+1) 
    Ws1 = dcs;
else
    DE1 = ones(sn,sn)*Inf;
    [sss,tt] = sort(dcs);
    for i = 1:sn
        DE1(i,i) = 0;        DE1(tt(2:d+1,i),i) = sss(2:d+1,i);    
    end;
    Ws1 = min(DE1,DE1'); Ws1(find(Ws1==Inf)) = 0;    Ws1 = sparse(Ws1);
    clusters=getClusters(1:length(newsX),Ws1);

    clusterLength = length(clusters);
    while(clusterLength>=1)    
        if(clusterLength==1) break; end;
        for i = 1:clusterLength
            currCluster = clusters{i};
            otherCluster = setdiff(1:length(newsX),currCluster);
            tempDCS = dcs(currCluster,otherCluster);
            [t1,t2] = min(tempDCS); [t1,t3] = min(t1); 
            min1= currCluster(t2(t3)); min2 = otherCluster(t3);
            DE1(min1,min2) = t1;
        end;
        Ws1 = min(DE1,DE1'); Ws1(find(Ws1==Inf)) = 0;    Ws1 = sparse(Ws1);
        clusters=getClusters(1:length(newsX),Ws1);
        clusterLength = length(clusters);
    end;
end;
%%%4.transformation%%%
[y] = computerNewY(newX,1:newcol,Ws1,relationPs,relationPs1,newsX,sY,d,newDG,newD1,center,edgePs);
%}

end;
