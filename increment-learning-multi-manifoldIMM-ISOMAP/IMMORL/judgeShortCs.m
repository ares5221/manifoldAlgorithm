function edges = judgeShortCs(jList,oldWs,newWs,newDG,newP); 
edges = [];
oldOrder = 1:size(oldWs,2);
for i = 1:size(oldWs,2)
    oldN = find(oldWs(:,i));   newN = find(newWs(:,i));
    delN = gsetdiff(oldN,newN,size(newDG,2));   updateN = gsetdiff(newN,oldN,size(newDG,2));
    if(length(delN)>0 & length(updateN)>0)                
        tempDG = newDG; 
        delDG = repmat(tempDG(updateN,i),1,length(delN)) + tempDG(updateN,delN);
        delDG = min(delDG);
        
        delDG = delDG';
        thresholds = [];
        for j = 1:length(delN)
            tempN = find(newWs(:,delN(j)));
            temp = max(newDG(newN,i))+max(newDG(tempN,delN(j)))+newDG(i,delN(j))+max(newDG(updateN,i));
            %temp = max(newDG(oldN,i))+newDG(i,delN(j))+max(newDG(updateN,i));
            thresholds = [thresholds;temp];
        end;        

        aa = find(delDG > thresholds);        
        if(~isempty(aa)) 
            edge = [repmat(i,length(aa),1) delN(aa)];      edges = [edges;edge];
            
            for j = 1:length(aa)
                currI = i;      currJ = delN(aa(j)); 
                iN = find(oldWs(:,currI));    iN = setdiff(iN,currJ);
                jN = find(oldWs(:,currJ));    jN = setdiff(jN,currI);
                [aaa,bbb] = find(newDG(iN,jN) < repmat(newDG(iN,currI),1,length(jN))+newDG(currI,currJ)+repmat(newDG(j,jN),length(iN),1));
                tempIN = iN(aaa);tempJN = jN(bbb);
                for s = 1:length(tempIN)
                    if(tempJN(s)~=tempIN(s) & ~ismember(tempJN(s),find(newWs(:,tempIN(s)))) & ~ismember(tempIN(s),find(newWs(:,tempJN(s))))...
                            & newP(tempJN(s),tempIN(s))==tempJN(s) & newP(tempIN(s),tempJN(s))==tempIN(s))
                        bbb = [tempIN(s) tempJN(s)];       edges = [	; bbb];
                    end;
                end;
            end;
        end;
    end;
end;