
figure('color','w');
load residualvariance;
x=1:1:7;
%y1--ISOMAP y2--DC y3--DCISOMAP y4--IMMISOMAP
y1=bb(1,:);y2=bb(2,:);y3=bb(3,:);y4=bb(4,:);
hold on;
plot(x,y1,'-* m',x,y2,'-o g',x,y3,'-^ b',x,y4,'-p r','LineWidth',2 );

legend('ISOMAP','D-C','DC-ISOMAP','IMM-ISOMAP','location','northwest');
xlabel('The iteration of running four approaches','fontsize',12);
ylabel('The accuracy of the decomposed submanifolds','fontsize',12);



    
