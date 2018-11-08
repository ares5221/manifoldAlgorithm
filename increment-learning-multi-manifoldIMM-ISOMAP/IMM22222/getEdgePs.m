function edges = getEdgePs(nonEdges,center,tp,P,d,sY)

edges = 1:length(tp);
list = [];
for s = 1:length(tp)
    endE = s;
    while(endE~=center)  
        tempE = P(center,endE);  list = [list tempE];
        if(tempE==center) list = [list endE];end;
        endE = tempE;
    end;
end;
list = union(list,list);
flag = true;
while (flag)
    inList = union(nonEdges,setdiff(reshape(P(list,list),1,length(list)^2),0));
    %inList = setdiff(reshape(P(list,list),1,length(list)^2),0);
    tempList = setdiff(inList,list);
    if(length(tempList)>0)      list = inList;
    else       flag = false;    end;
end;
edges = setdiff(edges,union(inList,list));

for i = 1:d
    [aa,bb] = max(sY(i,:)); edges = union(edges,bb);
    [aa,bb] = min(sY(i,:)); edges = union(edges,bb);
end;