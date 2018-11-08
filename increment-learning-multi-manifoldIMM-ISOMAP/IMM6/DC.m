function y = DC(X,d,k);
N = size(X,2); D1 = L2_distance(X,X,1);
sX={};


sY={}; 
for i = 1:length(sX)
    tempX = sX{i}; 
    tempDE = DE(tempX,tempX);  Ws = min(tempDE,tempDE');  Ws(find(Ws==Inf)) = 0;   Ws = sparse(Ws);
    [tempDG,tempP] = gxf_dijkstra(Ws,1:length(tempX)); 
    DG(tempX,tempX) = tempDG;   P(tempX,tempX) = tempP;
    tempY =[];    tempY =computeSY(tempDG,d); 
    sY = [sY tempY];  
end;

%y = composition(T,list,X,sX,sY,DG,P,D1,allNeighbor,d);
y = composition(X,sX,sY,DG,P,D1,allNeighbor,d);
