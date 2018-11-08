function [sX,newAllNeighbor,newDE,newDG,newP] =ljf_increasePointsDNN(X1,XX,newDG,newDE,newP,sX,newAllNeighbor,D1,DE);
    %step 1: 增量处理新点属于哪一个子流形或者自成一个子流形
   %交集比较新点的近邻中每一个点属于哪一个分好的子流形  
    for i=size(XX,2)+1:size(XX,2)+size(X1,2)
         allold=cell2mat(sX);  
         allold=unique(allold);
         if(length(  intersect(newAllNeighbor{i},  allold) )>0)   %新点的近邻与旧点有交集，接下来看属于哪一个子流形
                for j=1:length(sX)
                     lable=0;%标记该点是属于一个子流形还是多个，多个的话融合子流形
                     if(length(intersect(newAllNeighbor{i},sX{j}))>0)
                        sX{j}=union(sX{j},i);  %重复出现的点就不添加进去

                        cj=[j];%存放属于哪一个子流形,如果属于下一个子流形，那么将这个子流形融合到原来的子流形当中，并且后面这个子流形置空
                        lable=lable+1;
                        if(lable>1)
                            sX{cj}=[sX{cj} sX{j}];
                            sX(j)=[];
                        end;
                     end;          
           end;   
         else    sX{length(sX)+1}=[i];%如果新点近邻与旧点没交集，那么成为一个新子流形
         end;  
    end;    
    %比较子流形有没有交集，有的话融合
    cjj=[];
      for 	p=1:(length(sX)-1)
          for q=p+1:length(sX)
                if(length(intersect(sX{p},sX{q}))>0)
                    sX{p}=union(sX{p} ,sX{q});
                   cjj=union(cjj ,q);
                end;
          end;     
      end;
 ii=length(cjj);
while(ii>=1)
  sX(cjj(ii))=[];
ii=ii-1;
end;
 disp('增量新来的点已经全部处理完毕子流形信息保存在sX{}中，属于子流形则划分到子流形，不属于的成为新的子流形，相交的子流形进行融合');        
%step 2: 更新DE，newAllNeighbor
 oldOrder = 1:size(XX,2);    jList = size(XX,2)+size(X1,2);    
    for i=size(XX,2)+1:size(XX,2)+size(X1,2)
        dd=newAllNeighbor{i};
        ddd=setdiff(oldOrder,dd);
        for j=1:length(ddd)
            newDE(ddd(j),i) = Inf; 
            
        end;
    end;
  %{
    %step 3  ：处理短路以及路径冲突问题%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %ws新的全部点的DE信息规范，ws1旧的点的DE
    Dset = min(newDE,newDE');  Ws = Dset;    Ws(find(Ws==Inf)) = 0;    Ws = sparse(Ws);    Ws = Ws';
    Dset = min(DE,DE');  Ws1 = Dset;    Ws1(find(Ws1==Inf)) = 0;    Ws1 = sparse(Ws1);    Ws1 = Ws1';
    oldDE = min(oldDE,newDE');
    %此处是将newDG，newP新增加的部分的距离更新，
    %比较AB矩阵是否一样，c=A-B;[x,y]=find(c~=0);x,y为矩阵不一样的地方的行，列数。
    [newDG,newP] = computeOneDG(size(XX,2)+1:size(XX,2)+size(X1,2),Ws,newDG,newP);
    shortEs = judgeShortCs(size(XX,2)+1:size(XX,2)+size(X1,2),Ws1,Ws,newDG,newP);
    if(size(shortEs,1)>0)%没有回路跳出
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
   %为了提高精度，暂时先不考虑，注释掉
 %   [newDG,newP] = updateNewOne(jList,Ws2,newDG,newP);
    
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
    %}
