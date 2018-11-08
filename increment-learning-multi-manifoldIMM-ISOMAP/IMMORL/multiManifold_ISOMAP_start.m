function [y,y1,sX,sY,allNeighbor,DE,DG,P] = multiManifold_ISOMAP_start(T,list,X,d,r,maxAngle);

%%%%%%%%%%%%%%%%%%%%%decomposition process%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = size(X,2); D1 = L2_distance(X,X,1);
allNeighbor = cell(N);
sX={};
%%% 1. Get Neighborhood %%%%%%%%%%%
[sX,allNeighbor,DE]= getNeighborhood(X,D1,d,r,maxAngle);

%%% 2. Get the embeddings of sub-manifolds %%%%%%%%%%%
sY={}; 
for i = 1:length(sX)
    tempX = sX{i}; 
    tempDE = DE(tempX,tempX);  Ws = min(tempDE,tempDE');  Ws(find(Ws==Inf)) = 0;   Ws = sparse(Ws);
    [tempDG,tempP] = dijkstra(Ws,1:length(tempX)); 
    DG(tempX,tempX) = tempDG;   P(tempX,tempX) = tempP;
    tempY =[];    tempY =computeSY(tempDG,d); 
    sY = [sY tempY];  
end;

%%%%%%%%%%%%%%%%%%%%%composition process%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1.Get centers  and  out-layer points %%%%%%%%%%
center = [];edgePs = {};
for i = 1:length(sX)
    tp = sX{i};    sDG = DG(tp,tp);
    [temp,order] = sort(sDG);    [temp,order] = sort(temp(end,:));
    center = [center tp(order(1))];%%%中心点
    
    neighbors = allNeighbor{tp(order(1))};
    nonEdges = [];
    for j = 1:length(neighbors)
        temp = find(tp==neighbors(j));
        nonEdges = [nonEdges temp];
    end;
    
    edges = getEdgePs(nonEdges,order(1),tp,P(tp,tp),d,sY{i});
    edgePs{i} = tp(edges);
end;
%%% 2 .块最近连接点&块中心最近连接点 %%%%%%%%%%
sn = length(sX);
relationPs = cell(sn,sn);%%%块最近连接点
relationPs1 = cell(sn,sn);%%%块中心最近连接点
dcs = ones(sn,sn)*Inf;
for i = 1:sn
    dcs(i,i) = 0; 
    for j = i+1:sn
        temp = D1(edgePs{i},edgePs{j});
        [t1,t2] = min(temp); [t1,t3] = min(t1); 
        iEdge = edgePs{i}; jEdge = edgePs{j};
        relationPs{i,j} = [iEdge(t2(t3)) jEdge(t3)];%%%%%%%%%%块连接点
        relationPs{j,i} = [jEdge(t3) iEdge(t2(t3))];%%%%%%%%%%块连接点
        dcs(i,j) = t1; dcs(j,i) = t1;
        
        tempDD = repmat(DG(iEdge,center(i)),1,length(jEdge)) + D1(iEdge,jEdge) + ...
            + repmat(DG(center(j),jEdge),length(iEdge),1);
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
    [ss,tt] = sort(dcs);
    for i = 1:sn
        DE1(i,i) = 0;        DE1(tt(2:d+1,i),i) = ss(2:d+1,i);    
    end;
    Ws1 = min(DE1,DE1'); Ws1(find(Ws1==Inf)) = 0;    Ws1 = sparse(Ws1);
    clusters=getClusters(1:length(sX),Ws1);

    clusterLength = length(clusters);
    while(clusterLength>=1)    
        if(clusterLength==1) break; end;
        for i = 1:clusterLength
            currCluster = clusters{i};
            otherCluster = setdiff(1:length(sX),currCluster);
            tempDCS = dcs(currCluster,otherCluster);
            [t1,t2] = min(tempDCS); [t1,t3] = min(t1); 
            min1= currCluster(t2(t3)); min2 = otherCluster(t3);
            DE1(min1,min2) = t1;
        end;
        Ws1 = min(DE1,DE1'); Ws1(find(Ws1==Inf)) = 0;    Ws1 = sparse(Ws1);
        clusters=getClusters(1:length(sX),Ws1);
        clusterLength = length(clusters);
    end;
end;
%%%4.transformation%%%
[y,y1] = computerNewY(T,list,Ws1,relationPs,relationPs1,sX,sY,d,DG,D1,center,edgePs);
