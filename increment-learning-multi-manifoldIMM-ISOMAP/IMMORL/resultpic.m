clear;
disp('-->Reading database');
 options.nclass=[1 3 4 5 6 17 19 20 ];
M = load_images_dataset('umist_cropped', options);
M(:,:,[37 38])=[];
% turn it into a set of points
a = size(M,1);b = size(M,2);n = size(M,3);X = reshape(M, a*b, n);
r=0.5;maxAngle = 20;
k=20;d=3;
 n = 243;t =0;times =1;
% n = 60;t = 22;times =1;
m = n+times*t;
XX = X(:,1:n);X1 = X(:,n+1:m);

[y,y1,sX,sY,allNeighbor,DE,DG,P] = multiManifold_ISOMAP_start(XX,1:size(XX,2),XX,d,r,maxAngle);
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