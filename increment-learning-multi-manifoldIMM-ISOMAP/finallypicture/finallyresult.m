%%%%result pitcure
figure('color','w');
%%%%Isomap
subplot(4,5,1)
load ISO0.mat;
open ISO0.mat;       
hin=scatter(Y(1,:),Y(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
title(' ISOMAP(n=1000)','fontsize',12);  hold on; 
subplot(4,5,2);
load ISO00.mat;
open ISO00.mat;       
hin=scatter(Y(1,:),Y(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
title(' ISOMAP(n=1100)','fontsize',12);hold on; 
subplot(4,5,3)
load ISO1.mat;
open ISO1.mat;       
hin=scatter(Y(1,:),Y(2,:),30, col,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
title(' ISOMAP(n=1200)','fontsize',12);  hold on; 
subplot(4,5,4);
load ISO2.mat;
open ISO2.mat;       
hin=scatter(Y(1,:),Y(2,:),30, col,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
title(' ISOMAP(n=1300)','fontsize',12);hold on; 
subplot(4,5,5);
load ISO3.mat;
open ISO3.mat;       
hin=scatter(Y(1,:),Y(2,:),30, col,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);   
title(' ISOMAP(n=1400)','fontsize',12);hold on; 

%%%DC
subplot(4,5,6)
load DC0.mat;
open DC0.mat;       
hin=scatter(y(1,:),y(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
title(' DC(n=1000)','fontsize',12);  hold on; 
subplot(4,5,7);
load DC00.mat;
open DC00.mat;       
hin=scatter(y(1,:),y(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
title(' DC(n=1100)','fontsize',12);hold on; 
subplot(4,5,8)
load DC1.mat;
open DC1.mat;       
hin=scatter(y(1,:),y(2,:),30, col,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
title(' DC(n=1200)','fontsize',12);  hold on; 
subplot(4,5,9);
load DC2.mat;
open DC2.mat;       
hin=scatter(y(1,:),y(2,:),30, col,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
title(' DC(n=1300)','fontsize',12);hold on; 
subplot(4,5,10);
load DC3.mat;
open DC3.mat;       
hin=scatter(y(1,:),y(2,:),30, col,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);   
title(' DC(n=1400)','fontsize',12);hold on; 

%%%DCISO
subplot(4,5,11)
load DCISO0.mat;
open DCISO0.mat;       
hin=scatter(y1(1,:),y1(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
title(' DC-ISOMAP(n=1000)','fontsize',12);  hold on; 
subplot(4,5,12);
load DCISO00.mat;
open DCISO00.mat;       
hin=scatter(y1(1,:),y1(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
title(' DC-ISOMAP(n=1100)','fontsize',12);hold on; 
subplot(4,5,13)
load DCISO1.mat;
open DCISO1.mat;       
hin=scatter(y1(1,:),y1(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
title(' DC-ISOMAP(n=1200)','fontsize',12);  hold on; 
subplot(4,5,14);
load DCISO2.mat;
open DCISO2.mat;       
hin=scatter(y1(1,:),y1(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
title(' DC-ISOMAP(n=1300)','fontsize',12);hold on; 
subplot(4,5,15);
load DCISO3.mat;
open DCISO3.mat;       
hin=scatter(y1(1,:),y1(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);   
title(' DC-ISOMAP(n=1400)','fontsize',12);hold on; 
%%%immiso
subplot(4,5,16)
load IMM10.mat;
open IMM10.mat;       
hin=scatter(y1(1,:),y1(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
title(' IMM-ISOMAP(n=1000 m=100)','fontsize',11);  hold on; 
subplot(4,5,17);
load IMM11.mat;
open IMM11.mat;       
hin=scatter(y1(1,:),y1(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
title(' IMM-ISOMAP(n=1100 m=100)','fontsize',11);hold on; 
subplot(4,5,18)
load IMM12.mat;
open IMM12.mat;       
hin=scatter(y1(1,:),y1(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
title(' IMM-ISOMAP(n=1200 m=100)','fontsize',11);  hold on; 
subplot(4,5,19);
load IMM13.mat;
open IMM13.mat;       
hin=scatter(y1(1,:),y1(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
title(' IMM-ISOMAP(n=1300 m=100)','fontsize',11);hold on; 
subplot(4,5,20);
load IMM3.mat;
open IMM3.mat;       
hin=scatter(y1(1,:),y1(2,:),30, col1,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);   
title(' IMM-ISOMAP(n=1400 m=100)','fontsize',11);hold on; 
disp('');