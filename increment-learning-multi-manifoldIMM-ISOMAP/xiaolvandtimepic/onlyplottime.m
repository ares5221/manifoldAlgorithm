
%%%%result pitcure
figure('color','w');
%%%%»­³öÊ±¼äÍ¼
load times;
x=1:1:7;
%y1--ISOMAP y2--DC y3--DCISOMAP y4--IMMISOMAP
y1=aa(1,:);y2=aa(2,:);y3=aa(3,:);y4=aa(4,:);
hold on;
plot(x,y1,'-* m',x,y2,'-o g',x,y3,'-^ b',x,y4,'-p r','LineWidth',2 );

legend('ISOMAP','D-C','DC-ISOMAP','IMM-ISOMAP','location','northwest');
xlabel('The iteration of running four approaches','fontsize',12);
ylabel('Running time','fontsize',12);

    
