clear;
%    load XAll1.mat;
%      open XAll1.mat;
tic;

d=2;
r=0.6;maxAngle = 20;

 swiss2000; T = X;
%  X = X(:,ss);col = col(ss);
load newss2.mat;
open newss2.mat;
X=X(:,newss);col=col(newss);
n = 1300;t = 0;times =1 ;
m = n+times*t;
XX = X(:,1:n);X1 = X(:,n+1:m);
 col1 = col(1:n);col11=col(n+1:m);
 col11=[col1' col11']';

[y,y1,sX,sY,allNeighbor,DE,DG,P] = multiManifold_ISOMAP_start(T,newss,XX,d,r,maxAngle);

figure;      hold on;        
hin=scatter(y1(1,:),y1(2,:),50, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);       hold off;
 tic;
for ggg = 1:times
    [y,y1,sX,sY,allNeighbor,DE,DG,P] = multiManifold_ISOMAP_1(XX,d,r,maxAngle,X1,sX,sY,allNeighbor,DE,DG,P,T,newss);
    toc;
 figure;      hold on;        
hin=scatter(y1(1,:),y1(2,:),50, col11,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);       hold off;
end;
  
toc;

% figure('color','w');
% scatter3(y(1,sX{1}),y(2,sX{1}),y(3,sX{1}),50,'r+');hold on;
% scatter3(y(1,sX{2}),y(2,sX{2}),y(3,sX{2}),50,'g>');hold on;
% scatter3(y(1,sX{3}),y(2,sX{3}),y(3,sX{3}),50,'b<');hold on;
% scatter3(y(1,sX{4}),y(2,sX{4}),y(3,sX{4}),50,'b+');hold on;
% scatter3(y(1,sX{5}),y(2,sX{5}),y(3,sX{5}),50,'m*');hold on;
% scatter3(y(1,sX{6}),y(2,sX{6}),y(3,sX{6}),50,'c.');hold on;
% scatter3(y(1,sX{7}),y(2,sX{7}),y(3,sX{7}),50,'y^');hold on;
% scatter3(y(1,sX{8}),y(2,sX{8}),y(3,sX{8}),50,'ko');hold on;
% title(' IMM-ISOMAP(¦È =20/¦Î=0.5)','fontsize',14);
%  