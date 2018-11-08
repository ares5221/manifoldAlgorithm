%{
%%%得到ISOMAP的3维结果C:\Program Files\MATLAB\R2011a\work\MultiManifold1
options.nntype = 0;options.nn_nbr = 9;options.dims=3;
y = gxf_isomap(X,options);
y = y{1};
figure('color','w');
scatter3(y(1,:),y(2,:),y(3,:),50,'bo');hold on;


%%%得到DC的3维结果C:\Program Files\MATLAB\R2011a\work\MultiManifold1
d=3;k=3;
[y,sX]=DC_meng(X,d,k);
figure;
scatter3(y(1,sX{1}),y(2,sX{1}),y(3,sX{1}),50,'r+');hold on;
scatter3(y(1,sX{2}),y(2,sX{2}),y(3,sX{2}),50,'g>');hold on;
scatter3(y(1,sX{3}),y(2,sX{3}),y(3,sX{3}),50,'b<');hold on;
scatter3(y(1,sX{4}),y(2,sX{4}),y(3,sX{4}),50,'b+');hold on;
scatter3(y(1,sX{5}),y(2,sX{5}),y(3,sX{5}),50,'m*');hold on;
scatter3(y(1,sX{6}),y(2,sX{6}),y(3,sX{6}),50,'c.');hold on;
scatter3(y(1,sX{7}),y(2,sX{7}),y(3,sX{7}),50,'y^');hold on;
%%%得到DC的3维结果C:\Program Files\MATLAB\R2011a\work\MultiManifold1
% aa=sX{2};aa=sort(aa);
% clear;
% disp('-->Reading database');
%  options.nclass=[1 2 3 4 5 6 17 19 20 ];
% M = load_images_dataset('umist_cropped', options);
% %  list=[34 35 36 60 61 62 84 85 86 110 111 112 133 134 135 159 160 161 207 208 209 241 242 243];
% % newM=M(:,:,list); 
%  k=9;
% figure; hold on; plot_flattened_dataset(y,M,k); hold off;
%}
figure('color','w');

subplot(3,4,1);
load ISOMAPpic.mat;
open ISOMAPpic.mat;       
scatter3(y(1,:),y(2,:),y(3,:),50,'bo');hold on;
title(' ISOMAP(k=10)','fontsize',12);hold on; 
subplot(3,4,2);
load DC.mat;
open DC.mat;       
scatter3(y(1,sX{1}),y(2,sX{1}),y(3,sX{1}),50,'r+');hold on;
scatter3(y(1,sX{2}),y(2,sX{2}),y(3,sX{2}),50,'g>');hold on;
scatter3(y(1,sX{3}),y(2,sX{3}),y(3,sX{3}),50,'b<');hold on;
scatter3(y(1,sX{4}),y(2,sX{4}),y(3,sX{4}),50,'b+');hold on;
scatter3(y(1,sX{5}),y(2,sX{5}),y(3,sX{5}),50,'m*');hold on;
scatter3(y(1,sX{6}),y(2,sX{6}),y(3,sX{6}),50,'c.');hold on;
scatter3(y(1,sX{7}),y(2,sX{7}),y(3,sX{7}),50,'y^');hold on;
title(' DC(k=3)','fontsize',12);hold on; 
subplot(3,4,3)
load dcisomap.mat;
open dcisomap.mat;       
scatter3(y(1,sX{1}),y(2,sX{1}),y(3,sX{1}),50,'r+');hold on;
scatter3(y(1,sX{2}),y(2,sX{2}),y(3,sX{2}),50,'g>');hold on;
scatter3(y(1,sX{3}),y(2,sX{3}),y(3,sX{3}),50,'b<');hold on;
scatter3(y(1,sX{4}),y(2,sX{4}),y(3,sX{4}),50,'b+');hold on;
scatter3(y(1,sX{5}),y(2,sX{5}),y(3,sX{5}),50,'m*');hold on;
scatter3(y(1,sX{6}),y(2,sX{6}),y(3,sX{6}),50,'c.');hold on;
scatter3(y(1,sX{7}),y(2,sX{7}),y(3,sX{7}),50,'y^');hold on;
scatter3(y(1,sX{8}),y(2,sX{8}),y(3,sX{8}),50,'ko');hold on;
title(' DC-ISOMAP(θ =20/ξ=0.5)','fontsize',12);  hold on; 
subplot(3,4,4);
load imm.mat;
open imm.mat;       
scatter3(y(1,sX{1}),y(2,sX{1}),y(3,sX{1}),50,'r+');hold on;
scatter3(y(1,sX{2}),y(2,sX{2}),y(3,sX{2}),50,'g>');hold on;
scatter3(y(1,sX{3}),y(2,sX{3}),y(3,sX{3}),50,'b<');hold on;
scatter3(y(1,sX{4}),y(2,sX{4}),y(3,sX{4}),50,'b+');hold on;
scatter3(y(1,sX{5}),y(2,sX{5}),y(3,sX{5}),50,'m*');hold on;
scatter3(y(1,sX{6}),y(2,sX{6}),y(3,sX{6}),50,'c.');hold on;
scatter3(y(1,sX{7}),y(2,sX{7}),y(3,sX{7}),50,'y^');hold on;
scatter3(y(1,sX{8}),y(2,sX{8}),y(3,sX{8}),50,'ko');hold on;
title(' IMM-ISOMAP(θ =20/ξ=0.5)','fontsize',12);hold on; 
disp('');