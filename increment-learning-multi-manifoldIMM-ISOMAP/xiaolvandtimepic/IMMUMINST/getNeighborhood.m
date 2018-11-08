function [sX,allNeighbor,DE] = getNeighborhood(X,D1,d,r,maxAngle)

N = size(X,2);
%对距离矩阵排序，得到其排序信息
[D2,D3] = sort(D1);
nearP = D3(2,:);
%初始化变量信息
allNeighbor = cell(N); 
tangent = cell(N);
DE = ones(N,N)*Inf; 
DG = ones(N,N)*Inf; 
P =  ones(N,N)*Inf;
%分别确定每个点的近邻点，所以用循环，每次找第i个点的近邻点放在neighbor中，存放的是第i个点的近邻的点的下标，U是第i个点的切空间信息
for i = 1:N
    [neighbor,U] = getDNNofOnePoint(i,X,D1(:,i),d,r,maxAngle);
    allNeighbor{i} = neighbor;    
    tangent{i} = U;
end;
%公式（4）确定每个点的采样密度
disK = sum(D2(2:d+2,:));
[temp,order] = sort(disK); 
%公式（5）将采样密度最大的点作为开始点
currentP = order(1);
currentT = order(1);
Idone = [currentT]; 
deviation = []; 
DE(allNeighbor{currentT},currentT) = D1(allNeighbor{currentT},currentT);
DE(currentT,currentT) = 0;
neighbor = setdiff(allNeighbor{currentT},Idone);
%公式（6）xi与他的各个近邻之间的夹角偏差dev的计算，然后选最小的进行扩展
for j = 1:length(neighbor)
    if(length(Idone(Idone==neighbor(j)))==0)
        aa = tangent{currentT}; 
        bb= tangent{neighbor(j)};   
        ss = aa(:,1:d)'* bb(:,1:d);
        [U,gM,V] = svd(ss);   
        dev = sqrt(1-min(diag(gM)).^2);
        vvv = [dev currentT neighbor(j)]';  
        deviation =[deviation vvv];
    end;
end;

%开始扩展
lastLocation=0; sX={};
while(length(Idone) < N)
    if(size(deviation,2)==0)
        disp('%%%%%%%%%%%%%%%%deviation为空，找毗邻点或者重新找起点%%%%%%%%%%%%%%%%%%%%%%');
        otherIdone = setdiff(1:N,Idone);
        tempSX = Idone(lastLocation+1:end);
        tempNeighbor = nearP(otherIdone);
        aaa = intersect(tempSX,tempNeighbor);
        if (length(aaa)==0)
            tempX = Idone(lastLocation+1:end); sX= [sX tempX];
            noDone = setdiff(1:N,Idone);
            disK = sum(D2(2:d+2,noDone));[temp,order] = sort(disK); 
            noDone = noDone(order);    currentP = noDone(1);; currentT = currentP;
            lastLocation = length(Idone);
        else
            for bb = 1:length(aaa)
                ccc = find(tempNeighbor==aaa(bb));
                vvv = [repmat(0,1,length(ccc)); repmat(aaa(bb),1,length(ccc)); otherIdone(ccc)];  
                deviation =[deviation vvv];
                [pp,qq] = sort(deviation(1,:));  currentP = deviation(2,qq(1));  currentT = deviation(3,qq(1));
                deviation(:,qq(1))=[];  temp = find(deviation(3,:)==currentT); deviation(:,temp)=[];
            end;
        end;
    else
        [pp,qq] = sort(deviation(1,:)); 
        currentP = deviation(2,qq(1)); 
        currentT = deviation(3,qq(1));
        deviation(:,qq(1))=[];  
        temp = find(deviation(3,:)==currentT); 
        deviation(:,temp)=[];
    end;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#############
    Idone = [Idone currentT];
    %精确计算currentT的切空间和邻域 
  [neighbor,U,nSame] = getDNNofOnePoint(currentT,X,D1(:,currentT),d,r,maxAngle,currentP,tangent{currentP},allNeighbor);    
    if(nSame)  allNeighbor{currentT} = neighbor;     tangent{currentT} = U;    end;
        
    neighbor = setdiff(allNeighbor{currentT},Idone);
    for j = 1:length(neighbor)
        if(length(Idone(Idone==neighbor(j)))==0)
            aa = tangent{currentT}; bb= tangent{neighbor(j)};     ss = aa(:,1:d)'* bb(:,1:d);
            [U,gM,V] = svd(ss);    dev = sqrt(1-min(diag(gM)).^2);
            vvv = [dev currentT neighbor(j)]';    deviation =[deviation vvv];
        end;
    end;
    DE(allNeighbor{currentT},currentT) = D1(allNeighbor{currentT},currentT); DE(currentT,currentT) = 0;
end;
tempX = Idone(lastLocation+1:end); sX= [sX tempX];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
newSX = {};
for i = 1:length(sX)
    tempSX = sX{i};
    if(length(tempSX)<d+2)
        flag = true;
        for j = 1:length(sX) 
            if(length(intersect(tempSX,sX{j}))>0 & j~=i)  
                sX{j} = union(sX{j},tempSX); sX{i} = []; flag = false; break;
            end;
        end;
        if(flag)
            otherSX = setdiff(1:N,tempSX);
            minD = Inf; minL = Inf;
            for j = 1:length(tempSX)
                tempDD = D1(tempSX(j),otherSX); [D2,D3] = min(tempDD);
                if(minD > D2) minD = D2; minL = D3; end;
            end;
            for j = 1:length(sX)
                aa = find(sX{j}==otherSX(minL));
                if(length(aa)>0) break; end;
            end;
            sX{j} = [sX{j} sX{i}]; sX{i} = []; 
        end;
    end;
end;
for i = 1:length(sX)
    tempSX = sX{i};
    if(length(tempSX)>0)
        newSX = [newSX tempSX];
    end;
end;
sX = newSX;


