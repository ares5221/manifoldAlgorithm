clear;
load X5.mat;
open X5.mat;
d=3;r=0.5;maxAngle = 20;
k=20;
 n = 195;t = 24;times =1;
% n = 60;t = 22;times =1;
m = n+times*t;
XX = X5(:,1:n);X1 = X5(:,n+1:m);
tic;
[y,y1,sX,sY,allNeighbor,DE,DG,P] = multiManifold_ISOMAP_start(XX,1:size(XX,2),XX,d,r,maxAngle);
   toc;
for ggg = 1:times
    [y,y1,sX,sY,allNeighbor,DE,DG,P] = multiManifold_ISOMAP_1(XX,d,r,maxAngle,X1,sX,sY,allNeighbor,DE,DG,P);
toc;
end;
figure('color','w');
scatter3(y(1,sX{1}),y(2,sX{1}),y(3,sX{1}),50,'r+');hold on;
scatter3(y(1,sX{2}),y(2,sX{2}),y(3,sX{2}),50,'g>');hold on;
scatter3(y(1,sX{3}),y(2,sX{3}),y(3,sX{3}),50,'b<');hold on;
scatter3(y(1,sX{4}),y(2,sX{4}),y(3,sX{4}),50,'b+');hold on;
scatter3(y(1,sX{5}),y(2,sX{5}),y(3,sX{5}),50,'m*');hold on;
scatter3(y(1,sX{6}),y(2,sX{6}),y(3,sX{6}),50,'c.');hold on;
scatter3(y(1,sX{7}),y(2,sX{7}),y(3,sX{7}),50,'y^');hold on;
scatter3(y(1,sX{8}),y(2,sX{8}),y(3,sX{8}),50,'ko');hold on;
title(' IMM-ISOMAP(¦È =20/¦Î=0.5)','fontsize',14);
 