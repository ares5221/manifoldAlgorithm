function [relationPs,relationPs1,Ws1,center,edgePs]=composition(d,newsX,allNeighbor,newDG,newP,newD1,sY);
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