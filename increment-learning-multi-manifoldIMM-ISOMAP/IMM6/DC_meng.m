function [y,sX] = DC(X,d,k);
%%%%%%%%%%%%%%%%%%%%%decomposition process%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = size(X,2); D1 = L2_distance(X,X,1);
options.nntype = 0; options.nn_nbr = k;
[D,DE,E] = gxf_compute_nn_graph(X,options);
DE = DE{1};
Ws = min(DE,DE'); Ws(find(Ws==Inf)) = 0;    Ws = sparse(Ws);
sX=getClusters(1:N,Ws);

allNeighbor = {};
for i = 1:N    neighbor = find(Ws(:,i));  allNeighbor{i} = neighbor;  end;

sY={}; P=ones(N,N)*Inf;
for i = 1:length(sX)
    tempX = sX{i}; 
    tempDE = DE(tempX,tempX);  Ws = min(tempDE,tempDE');  Ws(find(Ws==Inf)) = 0;   Ws = sparse(Ws);
    [tempDG,tempP] = gxf_dijkstra(Ws,1:length(tempX)); 
    DG(tempX,tempX) = tempDG;   P(tempX,tempX) = tempP;
    tempY =[];    tempY =computeSY(tempDG,d); 
    sY = [sY tempY];  
end;
%%%%%%%%%%%%%%%%%%%%%composition process%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Get centers %%%%%%%%%%
center = [];edgePs = {};
for i = 1:length(sX)
    tp = sX{i};    sDG = DG(tp,tp);
    [temp,order] = sort(sDG);    [temp,order] = sort(temp(end,:));
    center = [center tp(order(1))];%%%中心点
end;

%%% 2 .块最近连接点 %%%%%%%%%%
sn = length(sX);
relationPs = cell(sn,sn);%%%块最近连接点
dcs = ones(sn,sn)*Inf;
for i = 1:sn
    dcs(i,i) = 0; 
    for j = i+1:sn
        temp = D1(sX{i},sX{j});
        [t1,t2] = min(temp); [t1,t3] = min(t1); 
        iEdge = sX{i}; jEdge = sX{j};
        relationPs{i,j} = [iEdge(t2(t3)) jEdge(t3)];%%%%%%%%%%块连接点
        relationPs{j,i} = [jEdge(t3) iEdge(t2(t3))];%%%%%%%%%%块连接点
        dcs(i,j) = t1; dcs(j,i) = t1;
    end;
end;

%%%3.DG of CX%%%
newDcs=ones(sn,sn)*Inf;
for i = 1:sn
    newDcs(i,i) = 0;
    for j = i+1:sn
        currR = relationPs{i,j};
        tempDD = DG(currR(1),center(i)) + dcs(i,j) +DG(center(j),currR(2));
        newDcs(i,j) = tempDD;newDcs(j,i) = tempDD;        
    end;
end;
[t1,t2] = sort(newDcs);
newDE = ones(sn,sn)*Inf;
for i=1:sn     newDE(t2(2:d+1,i),i)=t1(2:d+1,i); newDE(i,i)=0; end;
Ws1 = min(newDE,newDE'); Ws1(find(Ws1==Inf)) = 0;    Ws1 = sparse(Ws1);
[tempDG,tempP] = gxf_dijkstra(Ws1,1:sn); 
cY =computeSY(tempDG,d); 

%%%%%%%%%%%%%%%4.transformation%%%%%%%%%%%%%%%%%%
y = ones(d,N)*Inf;
for i = 1:sn
    nY=[]; tY=[];
    neighbors = find(Ws1(:,i));
    bb = sY{i};
    for j = 1:d
        currR = relationPs{i,neighbors(j)};
        aa = find(sX{i}==currR(1));
        nY=[nY bb(:,aa)];
        cc = cY(:,i)+DG(center(i),currR(1))/newDcs(i,neighbors(j))*(cY(:,neighbors(j))-cY(:,i));
        tY =[tY cc];
    end;
    aa = find(sX{i}==center(i));
    tempY = transY_meng(tY,cY(:,i),nY,bb(:,aa),sY{i});
    y(:,sX{i}) = tempY;
end;


