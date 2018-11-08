function [DG,P] = computeOneDG(List,Ws,DG,P);
for s = 1:length(List)
   i = List(s);
   Di = Inf*ones(size(DG,2),1);    
   Di(i)=0;
    
   nLab = 0;
   UnLab = 1:length(Di);
   isUnLab = logical(ones(length(Di),1));
     
   while nLab < length(Di)
      [Dj,jj] = min(Di(isUnLab));
       t = UnLab(jj);
      UnLab(jj) = [];
      isUnLab(t) = 0;   
      nLab = nLab + 1;
      
      [jA,kA,Aj] = find(Ws(:,t));
      if (~isempty(jA))
          Dk = Dj + Ws(jA,t);
          newIndex = jA(Di(jA) > Dk);
          Di(jA) = min(Di(jA),Dk);
          P(i,newIndex) = t;
          if(t==i)
              P(newIndex,i) = newIndex;
          else              
              P(newIndex,i) = P(t,i);       
          end;
      end;
   end;
   DG(:,i) = Di;   DG(i,:) = Di';
end;
