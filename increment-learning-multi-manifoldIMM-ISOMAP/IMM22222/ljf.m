 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  %%%其余差集的点  
ccc=setdiff(1:2000,ss);
X11=T(:,ccc);
 figure;   
hin=scatter3(X11(1,:),X11(2,:),X11(3,:),50,'filled');  
 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
hold off;
jj=[];
    for i=1:700
        if((-3<X11(3,i))&(X11(3,i)<4))
            if((0<X11(1,i))&(X11(1,i)<10))
                jj=[jj i];
            end;
        end;
       
    end;
     disp('');
     for jjj=1:size(jj)
         jjjj=ccc(jj);
     end;
     
      X111=T(:,jjjj);
 figure;   
hin=scatter3(X11(1,:),X11(2,:),X11(3,:),50,'filled');  
 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);hold on;
hin=scatter3(X111(1,:),X111(2,:),X111(3,:),50,'filled');  
 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);hold on;
 jjjj=jjjj(1:100);
  newss=[ss' jjjj]';