clear;
disp('-->Reading database');
options.nclass=[1 3 4 5 6 17 19 20];
M = load_images_dataset('umist_cropped', options);
M(:,:,[37 38])=[];
% turn it into a set of points
a = size(M,1);b = size(M,2);n = size(M,3);X = reshape(M, a*b, n);


d=3;
r=0.5;
maxAngle = 20;
n = 36;t = 23;times =6;
m = n+times*t;
XX = X(:,1:n);X1 = X(:,n+1:m);

for i=1:times+1
    if(i~=1)
         XXX=X1(:,t*(i-1)+1:t*i);
         XX=[XX XXX];
    end;
    [y,y1,sX]=multiManifold_ISOMAP(XX,d,r,maxAngle,X1);
end;


figure;
scatter3(y(1,sX{1}),y(2,sX{1}),y(3,sX{1}),50,'r+');hold on;
scatter3(y(1,sX{2}),y(2,sX{2}),y(3,sX{2}),50,'g>');hold on;
scatter3(y(1,sX{3}),y(2,sX{3}),y(3,sX{3}),50,'b<');hold on;
scatter3(y(1,sX{4}),y(2,sX{4}),y(3,sX{4}),50,'b+');hold on;
scatter3(y(1,sX{5}),y(2,sX{5}),y(3,sX{5}),50,'m*');hold on;
scatter3(y(1,sX{6}),y(2,sX{6}),y(3,sX{6}),50,'c.');hold on;
scatter3(y(1,sX{7}),y(2,sX{7}),y(3,sX{7}),50,'y^');hold on;
%scatter3(y(1,sX{8}),y(2,sX{8}),y(3,sX{8}),50,'kd');

k=20;
figure; hold on; plot_flattened_dataset(y,M,k); hold off;
