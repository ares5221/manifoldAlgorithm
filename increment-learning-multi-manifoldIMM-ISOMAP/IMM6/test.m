clear;
disp('-->Reading database');
% options.nclass=[3 4 5 6 8 16 17 20];
% options.nclass=[1 3 4 5 6 17 19 20 ];
options.nclass=[1 3 4 5 6 17 19 20];
M = load_images_dataset('umist_cropped', options);
M(:,:,[37 38])=[];
%得到M后，将每个人脸的后三张图片作为增量newM，在原来的M中删去其图片
 list=[34 35 36 60 61 62 84 85 86 110 111 112 133 134 135 159 160 161 207 208 209 241 242 243];
newM=M(:,:,list);
newM(:,:,[9 15])=[];%将导致融合的人脸4 6最后一张图片删去
 M(:,:,list)=[]; 
% 重新得到新的X
a = size(M,1);b = size(M,2);n = size(M,3);X = reshape(M, a*b, n);
aa = size(newM,1);bb = size(newM,2);nn = size(newM,3);XX = reshape(newM, aa*bb, nn);
X=[X XX];
newM=cat(3,M,newM);
d=3;
tic;
r=0.5;maxAngle = 20;
k=20;

n = 219;t = 22;times =1;
m = n+times*t;
XX = X(:,1:n);X1 = X(:,n+1:m);
% col1 = col5(1:n);col11=col5(n+1:m);
col1=size(XX,2);col11=size(X1,2);
 col11=n+1:243;  
 
  [y,sX] = multiManifold_ISOMAP(XX,col1,d,r,maxAngle,X1,col11,M,k,newM);
    
toc;

% figure; 
%   hold on;        
%     hin=scatter3(y(1,:),y(2,:),y(3,:),50,'filled'); 
%     set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
%   hold off;

figure;
scatter3(y(1,sX{1}),y(2,sX{1}),y(3,sX{1}),50,'r+');hold on;
scatter3(y(1,sX{2}),y(2,sX{2}),y(3,sX{2}),50,'g>');hold on;
scatter3(y(1,sX{3}),y(2,sX{3}),y(3,sX{3}),50,'b<');hold on;
scatter3(y(1,sX{4}),y(2,sX{4}),y(3,sX{4}),50,'b+');hold on;
scatter3(y(1,sX{5}),y(2,sX{5}),y(3,sX{5}),50,'m*');hold on;
scatter3(y(1,sX{6}),y(2,sX{6}),y(3,sX{6}),50,'c.');hold on;
scatter3(y(1,sX{7}),y(2,sX{7}),y(3,sX{7}),50,'y^');hold on;
scatter3(y(1,sX{8}),y(2,sX{8}),y(3,sX{8}),50,'ko');hold on;

 