function clusters = getClusters(list,Ws)
clusters = {};
Idone =[]; unIdone = [];
while(length(list)>0)
    tempX = list(1); 
    neighbors = find(Ws(:,tempX));
    neighbors = setdiff(setdiff(neighbors, Idone),unIdone);
    Idone = [Idone tempX];
    if(size(neighbors,2)<size(neighbors,1)) neighbors = neighbors'; end;
    unIdone = [unIdone neighbors];
    list(1)=[];
    while(length(unIdone)>0)
        tempU = unIdone(1);
        neighbors = find(Ws(:,tempU));
        neighbors = setdiff(setdiff(neighbors, Idone),unIdone);
        if(size(neighbors,2)<size(neighbors,1)) neighbors = neighbors'; end;
        unIdone = [unIdone neighbors];
        Idone = [Idone tempU];
        unIdone(1)=[];
        aa = find(list==tempU);
        list(aa)=[];        
    end;
    clusters = [clusters Idone];
    Idone =[];
end;
