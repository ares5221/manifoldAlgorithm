clear;
clc;
%    load XAll.mat;
%    open XAll.mat;
%   load newall.mat;
%    open newall.mat;
%    load matlab.mat;
%   open matlab.mat;

% 点击导入矩阵数据XandXin; 

%#######原数据是全部取样，只取ss的点就是分块的流形################

% XX;%swiss中取1500个点
% col1;%swiss中取1500个点对应的col
% XXX;%swiss中l取剩下的500个点
%  col2;%swiss中取剩下的500点对应的col
% newcol=[col1' col2']';%
% 
% 修改颜色
%  col1(1:1500)=0.85;col2(1:500)=0.35;col=[col1' col2']';
%#######先画出X原本的流形形状。################
% figure;   
% hin=scatter3(X(1,:),X(2,:),X(3,:),50,col,'filled');  
% set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
% hold off;


swiss2000; T = X;
XAll = X(:,ss);
col = col(ss);

%###############采用多流形的算法画出经过多流形处理后降维的图像##############
tic;
d=2;
r=0.6;
maxAngle = 20;

n = 700;t = 200;times = 3;
m = n+times*t;
XX = XAll(:,1:n);
X1 = XAll(:,n+1:m);
col1 = col(1:n);col11=col(n+1:m);

    %画出初始的1500个点的三维图
     figure;   
    hin=scatter3(XX(1,:),XX(2,:),XX(3,:),50,col1,'filled');  
     set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
    hold off;

   
    [y] = multiManifold_ISOMAP(XX,col1,d,r,maxAngle,X1,col11);
    

%{
figure; 
  hold on;        
    hin=scatter(y1(1,:),y1(2,:),50, col,'filled'); 
    set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
  hold off;
  
 %}
disp('');
runtime=toc;
disp('runtime='+runtime);
