function [DG,P] = computePairDG(i,anotherPs,Ws,DG,P);
    newOrder = 1:size(P,2);
    Di = DG(anotherPs,i);    
    for j = 1:length(anotherPs)
        thatPoint = anotherPs(j);
        if(thatPoint ~= i)
            tempNs = find(Ws(:,thatPoint));
            minDist = DG(i,tempNs)+DG(tempNs,thatPoint)';
            [ss,tt] = sort(minDist);
            
            tempNs1 = find(Ws(:,i));
            minDist = DG(i,tempNs1)+DG(tempNs1,thatPoint)';
            [ss1,tt1] = sort(minDist);
            
            if(~isinf(ss(1)) | ~isinf(ss1(1)))
                if(ss(1) < ss1(1))
                    Di(j) = ss(1); P(i,thatPoint) = tempNs(tt(1)); P(thatPoint,i) = P(tempNs(tt(1)),i);
                else
                    Di(j) = ss1(1); P(i,thatPoint) = P(tempNs1(tt1(1)),thatPoint); P(thatPoint,i) = tempNs1(tt1(1));
                end;
            end;
        end;
    end;
    
   nLab = 0; UnLab = 1:length(anotherPs);isUnLab = logical(ones(length(anotherPs),1));
   while nLab < length(anotherPs)
      [Dj,jj] = min(Di(isUnLab));
      t = UnLab(jj);    UnLab(jj) = [];    isUnLab(t) = 0;      nLab = nLab + 1;
      
      thisP = anotherPs(t);    jA = find(Ws(:,thisP));
      %%%%%%%%%%%%%%%%%%%%%%%%55
      %[ia,ib,ic] = intersect(jA,anotherPs);
      mmm = 1:length(anotherPs);
      isSetLab = logical(zeros(length(newOrder),1));
      isSetLab(jA) = 1;
      ic = mmm(isSetLab(anotherPs));
      ia = anotherPs(ic);                  
      %%%%%%%%%%%%%%%%%%%%%%%%%%%
      index = ic(isUnLab(ic));
      if(~isempty(index))
          ia = ia(isUnLab(ic));
          Dk = Dj + Ws(thisP,ia)';
          newIndex = index(Di(index) > Dk);
          if(~isempty(newIndex))
              Di(index) = min(Di(index),Dk);    P(i,anotherPs(newIndex)) = thisP;   
              if(thisP == i)    P(newIndex,i) = newIndex;    else  P(anotherPs(newIndex),i) = P(thisP,i);  end;
          end;
      end;
   end;
   DG(anotherPs,i) = Di;  DG(i,anotherPs) = Di';

