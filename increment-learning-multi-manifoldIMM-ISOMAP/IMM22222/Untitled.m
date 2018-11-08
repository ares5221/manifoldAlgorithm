for tt=1:size(sY,2);
    xx = sX{tt};
    yy = sY{tt};
    colx=col1(xx);
    figure; 
    hold on;        
    hin=scatter(yy(1,:),yy(2,:),50, colx,'filled'); 
    set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
    hold off;
end;


for tt=1:size(sY,2);
    xx = newsX{tt};
    yy = sY{tt};
    colx=newcol(xx);
    figure; 
    hold on;        
    hin=scatter(yy(1,:),yy(2,:),50, colx,'filled'); 
    set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
    hold off;
end;

tt=2;
gxf=sX{tt};
gxf1=newsX{tt};
ttt = setdiff(gxf1,gxf);
xx = newsX{tt};
yy = sY{tt};
aa=[];aa=newcol;aa=0.0001;aa(ttt)=0.999;colx=aa(xx);
figure; 
hold on;        
hin=scatter(yy(1,:),yy(2,:),50, colx,'filled'); 
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
hold off;
    


    cc=newcol;
    cc(1:N)=0.0001;
    cc(landmarks)=0.9999;
    figure; 
    hold on;        
    hin=scatter(y(1,:),y(2,:),50, cc','filled'); 
    set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]); 
    hold off;
 
  
    