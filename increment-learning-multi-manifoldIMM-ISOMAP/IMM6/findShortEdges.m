function allEdges = findShortEdges(j,k,Ws,DG,P); 
%delete e(j,k) and the k-th point is the neighbor of the j-th point
    allEdges = [];
    oldOrder = 1:size(P,2);
    kChildren = oldOrder(P(oldOrder,j)==P(k,j));
    jChildren = oldOrder(P(oldOrder,k)==P(j,k));
    [mmm,nnn] = find(sparse(P(kChildren,jChildren)==ones(length(kChildren),1)*P(k,jChildren) ...
        & P(jChildren,kChildren)'==P(j,kChildren)'*ones(1,length(jChildren))...
        & ~Ws(kChildren,jChildren)));

    if(~isempty(mmm) & ~isempty(nnn))
        kChildren = kChildren(mmm);     jChildren = jChildren(nnn);
        if(size(kChildren,2)<size(kChildren,1))      kChildren = kChildren';        end;
        if(size(jChildren,2)<size(jChildren,1))      jChildren = jChildren';        end;
        edges = [kChildren;jChildren];
    end;
    if(~isempty(edges))    allEdges = [allEdges edges]; end;
   
    