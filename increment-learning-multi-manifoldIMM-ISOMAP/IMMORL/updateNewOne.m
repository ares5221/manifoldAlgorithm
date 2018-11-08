function [DG,P] = updateNewOne(jList,Ws,DG,P);
% compute the DG of the j-th point
allNumber = size(DG,2);
newOrder = 1:allNumber;
oldOrder = 1:allNumber-length(jList);

for i = 1:length(jList)
   j = jList(i);
   List = [];
   jA = find(Ws(:,j));  jA = gsetdiff(jA,jList(1:i-1),allNumber);
   rjA = cell(length(jA),1); rjB = cell(length(jA)-1,1);

   for s = 1:length(jA)
       t = length(jA)-s+1;
       aEdge = [];
       if (ismember(jA(t),jList))
           aaa = jA(t);    bbb = j;
           while(~isempty(aaa))
               tempEs = find(Ws(:,aaa(1)));
               bbb = [bbb aaa(1)];        aaa(1) = [];
               tempEs = gsetdiff(tempEs,bbb,allNumber);               
               ccc = gintersect(jList,tempEs,allNumber);           
               aEdge = gunion(aEdge,gsetdiff(tempEs,ccc,allNumber),newOrder);
               aaa = gunion(aaa,ccc,newOrder);
           end;
       else           aEdge = jA(t);       end;
       rjA{t} = aEdge;
       if(t < length(jA))
           if(t==length(jA)-1)       rjB{t} = rjA{t+1};
           else      rjB{t} = gunion(rjB{t+1},rjA{t+1},newOrder);      end;
       end;
   end;
   for s = 1:length(jA)-1
       aEdge = rjA{s};   bEdge = rjB{s};
       [mmm,nnn] = find(sparse(DG(aEdge,bEdge) > DG(aEdge,j)*ones(1,length(bEdge))+ones(length(aEdge),1)*DG(j,bEdge)));
       if(~isempty(mmm))
           tempX = aEdge(mmm);         tempY = bEdge(nnn); 
           if(size(tempY,1)~=size(tempX,1))         tempY = tempY';          end;
           P((tempY-1)*allNumber+tempX) = P((tempY-1)*allNumber+j);
           P((tempX-1)*allNumber+tempY) = P((tempX-1)*allNumber+j);
           DG((tempY-1)*allNumber+tempX) = DG((j-1)*allNumber+tempX) + DG((tempY-1)*allNumber+j);
           DG((tempX-1)*allNumber+tempY) = DG((tempY-1)*allNumber+tempX);
       end;
       
       [mmm,nnn] = find(sparse(P(aEdge,bEdge)==ones(length(aEdge),1)*P(j,bEdge) ...
                             & P(bEdge,aEdge)'==P(j,aEdge)'*ones(1,length(bEdge))));
       if(~isempty(mmm))
           tempX = aEdge(mmm);        tempY = bEdge(nnn);
           if(size(tempX,1)>size(tempX,2)) tempX = tempX'; end;
           if(size(tempY,1)>size(tempY,2)) tempY = tempY'; end;
           newSet = [tempX;tempY];     List = [List newSet];
       end;
   end;
   if(~isempty(List))
       aaa = (List(1,:)-1)*allNumber+List(2,:);       aaa = gunique(aaa,1:allNumber^2);
       List = [];       List(1,:) = ceil(aaa/allNumber);       List(2,:) = mod(aaa,allNumber);
   end;
   for s = 1:size(List,2)
       aEdge = List(1,s);      bEdge = List(2,s);
       aChildren = oldOrder(P(oldOrder,j)==P(aEdge,j));
       bChildren = oldOrder(P(oldOrder,j)==P(bEdge,j));
       [mmm,nnn] = find(sparse(DG(aChildren,bChildren)>(DG(aChildren,j)*ones(1,length(bChildren))+ones(length(aChildren),1)*DG(j,bChildren)) ...
                         & DG(aChildren,bChildren)~=Inf));
       if(~isempty(mmm))
           tempX = aChildren(mmm);         tempY = bChildren(nnn); 
           if(size(tempY,1)~=size(tempX,1))        tempY = tempY';          end;
           P((tempY-1)*allNumber+tempX) = P((tempY-1)*allNumber+j);
           P((tempX-1)*allNumber+tempY) = P((tempX-1)*allNumber+j);
           DG((tempY-1)*allNumber+tempX) = DG((j-1)*allNumber+tempX) + DG((tempY-1)*allNumber+j);
           DG((tempX-1)*allNumber+tempY) = DG((tempY-1)*allNumber+tempX);
       end;
   end;
end;