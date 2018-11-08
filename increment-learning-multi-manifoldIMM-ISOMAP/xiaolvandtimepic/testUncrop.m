clear;
disp('-->Reading database');

options.nclass=[1 3 4 5 6 17 19 20];
M = load_images_dataset('umist_cropped', options);
M(:,:,[37 38])=[];
%得到M后，将每个人脸的后三张图片作为增量newM，在原来的M中删去其图片
 list7=[34 35 36 60 61 62 84 85 86 110 111 112 133 134 135 159 160 161 207 208 209 241 242 243];
newM7=M(:,:,list7);
 newM7(:,:,[9 15])=[];%将导致融合的人脸4 6最后一张图片删去
 
 list6=[31 32 33 57 58 59 81 82 83 107 108 109 130 131 132 156 157 158 204 205 206 238 239 240];
newM6=M(:,:,list6);
 
  list5=[28 29 30 54 55 56 78 79 80 104 105 106 127 128 129 153 154 155 201 202 203 235 236 237];
newM5=M(:,:,list5);
 
  list4=[25 26 27 51 52 53 75 76 77 101 102 103 124 125 126 150 151 152 198 199 200 232 233 234];
newM4=M(:,:,list4);
 
  list3=[22 23 24 48 49 50 72 73 74 98 99 100 121 122 123 147 148 149 195 196 197 229 230 231];
newM3=M(:,:,list3);

  list2=[19 20 21 45 46 47 69 70 71 95 96 97 118 119 120 144 145 146 192 193 194 226 227 228];
newM2=M(:,:,list2);


list=[list7 list6 list5 list4 list3 list2]
 M(:,:,list)=[]; 
 
 
a = size(M,1);b = size(M,2);n = size(M,3);X = reshape(M, a*b, n);


aa = size(newM2,1);bb = size(newM2,2);nn = size(newM2,3);XX = reshape(newM2, aa*bb, nn);
X1=[X XX]; 
aa = size(newM3,1);bb = size(newM3,2);nn = size(newM3,3);XX = reshape(newM3, aa*bb, nn);
X2=[X1 XX]; 
aa = size(newM4,1);bb = size(newM4,2);nn = size(newM4,3);XX = reshape(newM4, aa*bb, nn);
X3=[X2 XX]; 
aa = size(newM5,1);bb = size(newM5,2);nn = size(newM5,3);XX = reshape(newM5, aa*bb, nn);
X4=[X3 XX]; 
aa = size(newM6,1);bb = size(newM6,2);nn = size(newM6,3);XX = reshape(newM6, aa*bb, nn);
X5=[X4 XX]; 
aa = size(newM7,1);bb = size(newM7,2);nn = size(newM7,3);XX = reshape(newM7, aa*bb, nn);
X6=[X5 XX]; 
 
% 重新得到新的X
% a = size(M,1);b = size(M,2);n = size(M,3);X = reshape(M, a*b, n);
% aa = size(newM,1);bb = size(newM,2);nn = size(newM,3);XX = reshape(newM, aa*bb, nn);
% X=[X XX];
% newM=cat(3,M,newM);
d=3;
r=0.5;maxAngle = 20;
k=20;
 n = 99;t = 24;times =5;
% n = 60;t = 22;times =1;
m = n+times*t;
XX = X6(:,1:n);X1 = X6(:,n+1:m);
[y,y1,sX,sY,allNeighbor,DE,DG,P] = multiManifold_ISOMAP_start(XX,1:size(XX,2),XX,d,r,maxAngle);
   tic;
for ggg = 1:times
    [y,y1,sX,sY,allNeighbor,DE,DG,P] = multiManifold_ISOMAP_1(XX,d,r,maxAngle,X1,sX,sY,allNeighbor,DE,DG,P);
tic;
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
title(' IMM-ISOMAP(θ =20/ξ=0.5)','fontsize',14);
 