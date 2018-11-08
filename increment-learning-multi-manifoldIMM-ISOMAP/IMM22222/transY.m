function [newSY bb] = transY(X,L,Y,newY,d)

newSY = ones(size(Y,1),size(Y,2))*Inf; aa = newY-repmat(newY(:,1),1,size(newY,2)); [U1,P1,V1] = svd(aa);

bb = [];
for i = 1:length(L)     temp = find(X==L(i));  bb = [bb temp];  end;
dd = Y(:,bb)-repmat(Y(:,bb(1)),1,length(bb));
[U2,P2,V2] = svd(dd); ss2=[]; tt = dd(:,2:end);

%%%%%%%%%%ÅÐ¶ÏÐý×ª½Ç¶È%%%%%%%%%%%%%
T = getTvalue(aa,dd,d);

newSY = T*(Y-repmat(Y(:,bb(1)),1,size(Y,2)));
newSY = newSY+repmat(newY(:,1),1,size(newSY,2));
disp('');