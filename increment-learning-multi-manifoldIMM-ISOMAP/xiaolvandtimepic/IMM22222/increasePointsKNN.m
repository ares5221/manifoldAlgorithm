function [newX,newDG,oldDE,newP,pD] = increasePointsKNN1(newPoints,X,DG,DE,P,K,newcol); 
    %step 1: initial DE and get the Edges which will be deleted
    %tic;
    number = size(X,2);    addN = size(newPoints,2);
    oldOrder = 1:number;    jList = number+1:number+addN;
    
    newX = [X newPoints];
    
%#######画出newX原本的流形形状。################
figure;   
hin=scatter3(newX(1,:),newX(2,:),newX(3,:),50,newcol,'filled');  
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
hold off;

    newDE =ones(number+addN,number+addN)*Inf;
    newDG =ones(number+addN,number+addN)*Inf;    newDG(oldOrder,oldOrder) = DG;
    newP =zeros(number+addN,number+addN);    newP(oldOrder,oldOrder) = P;
    
    oldDE = newDE;    oldDE(oldOrder,oldOrder) = DE;
    % update DE and select the delete edges in Graph
    pD = L2_distance(newX,newX,1);
    [mmm,nnn] = sort(pD');
    for i = 1:number+addN        newDE(nnn(1:K+1,i),i) = mmm(1:K+1,i);    end;
    
    
    Dset = min(newDE,newDE');  Ws = Dset;    Ws(find(Ws==Inf)) = 0;    Ws = sparse(Ws);    Ws = Ws';
    Dset = min(DE,DE');  Ws1 = Dset;    Ws1(find(Ws1==Inf)) = 0;    Ws1 = sparse(Ws1);    Ws1 = Ws1';
    oldDE = min(oldDE,newDE');
    
    [newDG,newP] = computeOneDG(number+1:number+addN,Ws,newDG,newP);
    shortEs = judgeShortCs(number+1:number+addN,Ws1,Ws,newDG,newP);
    if(size(shortEs,1)>0)
        tempS = shortEs; shortEs = [];
        while size(tempS,1)>0
            c1 = tempS(1,1); c2 = tempS(1,2);
            aa = find((tempS(:,1)==c2 & tempS(:,2)==c1) | (tempS(:,1)==c1 & tempS(:,2)==c2));
            if(~isempty(aa))   shortEs = [shortEs;tempS(aa(1),:)]; tempS(aa,:) = [];   end;
        end;
    end;
    
    allEdges = [];
    for i = 1:size(shortEs,1)
        oldDE(shortEs(i,2),shortEs(i,1))=Inf;   oldDE(shortEs(i,1),shortEs(i,2))=Inf; 
    end;
    
    Dset = min(oldDE,oldDE');  Ws2 = Dset;    Ws2(find(Ws2==Inf)) = 0;    Ws2 = sparse(Ws2);    Ws2 = Ws2';
    [newDG,newP] = computeOneDG(number+1:number+addN,Ws2,newDG,newP);
    [newDG,newP] = updateNewOne(jList,Ws2,newDG,newP);
    
    for i = 1:size(shortEs,1)
        edges = findShortEdges(shortEs(i,1),shortEs(i,2),Ws,DG,P);   allEdges = [allEdges edges];
    end;  
    if(~isempty(allEdges))
       currJ = (allEdges(1,:)-1)*(number+addN)+allEdges(2,:);
       currJ1 = (allEdges(2,:)-1)*(number+addN)+allEdges(1,:);
       currJ = gunion(currJ,currJ1,1:(number+addN)^2);
       newP(currJ) = 0;   newDG(currJ) = Inf;
    end;
    
    tempDG = tril(newDG);
    [aaa,bbb] = find(tempDG(oldOrder,oldOrder)==Inf);
    aaa = gunique(aaa,oldOrder);  bbb = gunique(bbb,oldOrder);
    if(length(aaa)>length(bbb))       aaa = bbb;    end; 
    for a = 1:length(aaa)
       jFather = oldOrder(newDG(oldOrder,aaa(a))==Inf);        
       if(length(jFather) > 0)   [newDG,newP] = computePairDG(aaa(a),jFather,Ws2,newDG,newP);       end;
    end;
    
