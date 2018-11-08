function [neighbor,Ud1,nSame] = getDNNofOnePoint(i,X,Di,d,r,maxAngle,pre,initTan,allNeighbor);   
    N = size(Di,1); [tt,or] = sort(Di); 
    flag =1; nSame = 1; Ud1 = []; neighbor = [];
    if(nargin==6)      
        neighbor = or(2:d+2)';   location = d+2;
    elseif(nargin==9) 
        neighbor = or(2); location = 1; deviation=[];
        lable = zeros(N); lable(allNeighbor{pre}) = 1; lable(pre) = 1;
        lable(allNeighbor{neighbor}) = 1; lable(or(2:d+2))=1; lable([i neighbor])=0;
        [pp,qq] = sort(Di(logical(lable))); 
        threshold = find(lable); threshold = threshold(qq);
        while (length(neighbor) < d+1 & location < length(threshold))
            number = size(neighbor,2); radius = r*min(number^(1/d)*max(Di(neighbor)),min(Di(neighbor)));
            vec1 = X(:,threshold(location))-X(:,i); tVec = initTan(:,1:d)'*vec1;  tVec1 = initTan(:,1:d+1)'*vec1;
            d1D = sqrt(tVec1'*tVec1-tVec'*tVec);        angle = 90/1.57*asin(d1D/sqrt(vec1'*vec1));
            if(angle < maxAngle)  
                neighbor = [neighbor threshold(location)]; 
                lable = zeros(N); 
                lable(allNeighbor{threshold(location)}) = 1; threshold(location)=[];
                lable(threshold) = 1; lable(neighbor) = 0; lable(threshold(1:location-1)) = 0;    lable(i)=0;
                [pp,qq] = sort(Di(logical(lable)));    temp = find(lable); temp = temp(qq);
                threshold(location:end) = [];
                if(size(threshold,2)< size(threshold,1))     threshold = threshold';        end;
                if(size(temp,2)< size(temp,1))     temp = temp';        end;
                threshold = [threshold temp];       
            else  vvv = [angle;threshold(location)]; deviation = [deviation vvv];  location = location+1; end;
        end;
        
        num = d+1-length(neighbor);
        if(num>0 & size(deviation,2) >= num)
            [pp,qq] = sort(deviation(1,:));   neighbor = [neighbor deviation(2,qq(1:num))];
        elseif(num>0)
            ss = find(neighbor==pre);
            if(length(ss)==0)   
                neighbor = [neighbor pre]; num = num-1;
                if(num>0)   ss = setdiff(or(2:d+2)', neighbor); neighbor = [neighbor ss(1:num)];    end;
            end;                
        end;
        cc = setdiff(neighbor, or(2:d+2)'); if(length(cc) == 0) nSame = 0; end; 
    end;
if (nSame)             
    for j = location:N-1
        if(flag)
            number = size(neighbor,2);
            radius = r*min(number^(1/d)*max(Di(neighbor)),min(Di(neighbor)));
            thisx = X(:,neighbor);    thisx = thisx - repmat(mean(thisx')',1,number);
            [U,P,Vpr] = svd(thisx); nvals = diag(P); namidaD = nvals(d); Upr = U(:,1:d);Ud1 = U(:,1:d+1);
            vec1 = X(:,or(j+1))-X(:,i);   tVec = Upr'*vec1;    tVec1 = Ud1'*vec1;
            d1D = sqrt(tVec1'*tVec1-tVec'*tVec);        angle = 90/1.57*asin(d1D/sqrt(vec1'*vec1));
            if(angle < maxAngle)      neighbor = [neighbor or(j+1)];    end;
            if(namidaD > radius)      flag = 0;      end;
            clear U P Vpr thisx;
        else
            vec1 = X(:,or(j+1))-X(:,i); 
            %m = size(Upr,1);  vec2 = (eye(m)-Upr*Upr')*vec1; maxD = sqrt(vec2'*vec2);   angle = 90/1.57*asin(maxD/sqrt(vec1'*vec1));
            tVec = Upr'*vec1;      maxD = sqrt((vec1'*vec1)-tVec'*tVec);
            tVec1 = Ud1'*vec1;      d1D = sqrt(tVec1'*tVec1-tVec'*tVec);
            angle = 90/1.57*asin(d1D/sqrt(vec1'*vec1));
            if(angle < maxAngle & maxD < radius)    
                neighbor = [neighbor or(j+1)];
            elseif(maxD > radius)    break;  end; 
        end;
    end;
end;
