
%%%%画出人脸实际数据上X X1---X7运行四种算法对比试验得到的残差变化以及需要消耗的时间的变化
figure('color','w');
%%%%Isomap
subplot(1,2,1)
load renzaoresidualvariance;
x=1:1:5;
%y1--ISOMAP y2--DC y3--DCISOMAP y4--IMMISOMAP
hold on;
y1=bb(1,:);y2=bb(2,:);y3=bb(3,:);y4=bb(4,:);
plot(x,y1,'-* m',x,y2,'-o g',x,y3,'-^ b',x,y4,'-p r','LineWidth',2 );

legend('ISOMAP','D-C','DC-ISOMAP','IMM-ISOMAP','location','northwest');
xlabel('The iteration of running four approaches');
ylabel('Residual variance');


subplot(1,2,2);
%%%%画出时间图
load renzaotimes;
x=1:1:5;
%y1--ISOMAP y2--DC y3--DCISOMAP y4--IMMISOMAP
hold on;
y1=aa(1,:);y2=aa(2,:);y3=aa(3,:);y4=aa(4,:);
plot(x,y1,'-* m',x,y2,'-o g',x,y3,'-^ b',x,y4,'-p r','LineWidth',2 );

legend('ISOMAP','D-C','DC-ISOMAP','IMM-ISOMAP','location','northwest');
xlabel('The iteration of running four approaches');
ylabel('Running time');
    
