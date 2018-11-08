clc
clear;
n=8000;
 tt = (3*pi/2)*(1+2*rand(1,n));  %x
 height = 21*rand(1,n);    %y

 tt2=[];   i=[];
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 disp('准备得到第一部分数据集点');
             for ii = 1:n
                     if  ( (tt(ii) >7)&(tt(ii) < 8) ) 
                         tt2=[tt2 tt(ii)];
                         i=[i ii];
                     end;
            end;
            X1=[]; X2=[];X3=[];
            col1=[];
            for jj=1:length(tt2)
                  XX1 = [tt2(jj).*cos(tt2(jj))]';   XX2 = [ height(i(jj))]';      XX3 = [ tt2(jj).*sin(tt2(jj))]';     
                  X1=[X1 XX1];  X2=[X2 XX2]; X3=[X3 XX3]; 
                 col12 = tt2(jj);
                 col1=[col1 col12];
            end;
                aX1=[X1' X2' X3']';  acol1=col1';
               
                 figure;   
                 hin=scatter3(aX1(1,:),aX1(2,:),aX1(3,:),50,acol1,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold on;          
 disp('已经得到第一部分数据集点aX1 ,acol1');            
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
 tt2=[];   i=[];          
  for ii = 1:n
        if  ( (tt(ii) > 8.5)&(tt(ii) < 11) ) 
            if(height(ii) > 14) 
                 tt2=[tt2 tt(ii)];
                 i=[i ii];
            end;   
         end;
end;
   X1=[]; X2=[];X3=[];
            col1=[];
            for jj=1:length(tt2)
                  XX1 = [tt2(jj).*cos(tt2(jj))]';   XX2 = [ height(i(jj))]';      XX3 = [ tt2(jj).*sin(tt2(jj))]';     
                  X1=[X1 XX1];  X2=[X2 XX2]; X3=[X3 XX3]; 
                 col12 = tt2(jj);
                 col1=[col1 col12];
            end;
                aX2=[X1' X2' X3']';  acol2=col1';
                 hin=scatter3(aX2(1,:),aX2(2,:),aX2(3,:),50,acol2,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold on;          
 disp('已经得到第2部分集点aX2 acol2');         
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
 tt2=[];   i=[];          
  for ii = 1:n
        if  ( (tt(ii) > 8.5)&(tt(ii) < 11) ) 
            if(height(ii) < 9) 
                 tt2=[tt2 tt(ii)];
                 i=[i ii];
            end;   
         end;
end;
  X1=[]; X2=[];X3=[];
            col1=[];
            for jj=1:length(tt2)
                  XX1 = [tt2(jj).*cos(tt2(jj))]';   XX2 = [ height(i(jj))]';      XX3 = [ tt2(jj).*sin(tt2(jj))]';     
                  X1=[X1 XX1];  X2=[X2 XX2]; X3=[X3 XX3]; 
                 col12 = tt2(jj);
                 col1=[col1 col12];
            end;
                aX3=[X1' X2' X3']';  acol3=col1';
                 hin=scatter3(aX3(1,:),aX3(2,:),aX3(3,:),50,acol3,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold on;          
 disp('已经得到第3部分集点aX3 acol3');         
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
 tt2=[];   i=[];          
  for ii = 1:n
        if  ( (tt(ii) > 11.5)&(tt(ii) < 13.5) ) 
            if(height(ii) > 14) 
                 tt2=[tt2 tt(ii)];
                 i=[i ii];
            end;   
         end;
end;
  X1=[]; X2=[];X3=[];
            col1=[];
            for jj=1:length(tt2)
                  XX1 = [tt2(jj).*cos(tt2(jj))]';   XX2 = [ height(i(jj))]';      XX3 = [ tt2(jj).*sin(tt2(jj))]';     
                  X1=[X1 XX1];  X2=[X2 XX2]; X3=[X3 XX3]; 
                 col12 = tt2(jj);
                 col1=[col1 col12];
            end;
                X4=[X1' X2' X3']';  acol4=col1';
                 hin=scatter3(X4(1,:),X4(2,:),X4(3,:),50,acol4,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold on;          
 disp('已经得到第4部分集点X4 acol4');         
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
 tt2=[];   i=[];          
  for ii = 1:n
        if  ( (tt(ii) > 11.5)&(tt(ii) < 13.5) ) 
            if(height(ii) < 9) 
                 tt2=[tt2 tt(ii)];
                 i=[i ii];
            end;   
         end;
end;
 X1=[]; X2=[];X3=[];
            col1=[];
            for jj=1:length(tt2)
                  XX1 = [tt2(jj).*cos(tt2(jj))]';   XX2 = [ height(i(jj))]';      XX3 = [ tt2(jj).*sin(tt2(jj))]';     
                  X1=[X1 XX1];  X2=[X2 XX2]; X3=[X3 XX3]; 
                 col12 = tt2(jj);
                 col1=[col1 col12];
            end;
                X5=[X1' X2' X3']';  acol5=col1';
                 hin=scatter3(X5(1,:),X5(2,:),X5(3,:),50,acol5,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold off;          
 disp('已经得到第4部分集点X5 acol5');        
 %%%%%%%%%%%%%%%%%%%%%%以下是补充集合%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 tt2=[];   i=[];
 disp('准备得到第一部分补充集点');
             for ii = 1:n
                     if  ( (tt(ii) > 8)&(tt(ii) < 8.5) ) 
                         tt2=[tt2 tt(ii)];
                         i=[i ii];
                     end;
            end;
            Y1=[]; Y2=[];Y3=[];
            col1=[];
            for jj=1:length(tt2)
                  YY1 = [tt2(jj).*cos(tt2(jj))]';   YY2 = [ height(i(jj))]';      YY3 = [ tt2(jj).*sin(tt2(jj))]';     
                  Y1=[Y1 YY1];  Y2=[Y2 YY2];  Y3=[Y3 YY3];
                 col11 = tt2(jj);
                 col1=[col1 col11];
            end;
                bcY1=[Y1' Y2' Y3']';  bcol1=col1';
               
                 figure;   
                 hin=scatter3(bcY1(1,:),bcY1(2,:),bcY1(3,:),50,bcol1,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold on;          
 disp('已经得到第一部分补充集点bcY1 ,bcol1');            
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%           
   tt2=[];   i=[];          
  for ii = 1:n
        if  ((tt(ii) >11)&(tt(ii) < 11.5) ) 
             tt2=[tt2 tt(ii)];
             i=[i ii];
         end;
end;
 Y1=[]; Y2=[];Y3=[];
            col1=[];
            for jj=1:length(tt2)
                  YY1 = [tt2(jj).*cos(tt2(jj))]';   YY2 = [height(i(jj))]';      YY3 = [ tt2(jj).*sin(tt2(jj))]';     
                  Y1=[Y1 YY1];  Y2=[Y2 YY2];  Y3=[Y3 YY3];
                 col11 = tt2(jj);
                 col1=[col1 col11];
            end;
                bcY2=[Y1' Y2' Y3']';  bcol2=col1';
               
               
                 hin=scatter3(bcY2(1,:),bcY2(2,:),bcY2(3,:),50,bcol2,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold on;          
 disp('已经得到第2部分补充集点bcY2 bcol2');            
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
 tt2=[];   i=[];          
  for ii = 1:n
        if  ((tt(ii) >13.5)&(tt(ii) < 15.5) ) 
             tt2=[tt2 tt(ii)];
             i=[i ii];
         end;
end;
 Y1=[]; Y2=[];Y3=[];
            col1=[];
            for jj=1:length(tt2)
                  YY1 = [tt2(jj).*cos(tt2(jj))]';   YY2 = [height(i(jj))]';      YY3 = [ tt2(jj).*sin(tt2(jj))]';     
                  Y1=[Y1 YY1];  Y2=[Y2 YY2];  Y3=[Y3 YY3];
                 col11 = tt2(jj);
                 col1=[col1 col11];
            end;
                bcY3=[Y1' Y2' Y3']';  bcol3=col1';
  
                 hin=scatter3(bcY3(1,:),bcY3(2,:),bcY3(3,:),50,bcol3,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold on;          
 disp('已经得到第3部分补充集点bcY3 bcol3');            
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
 tt2=[];   i=[];          
  for ii = 1:n
        if  ( (tt(ii) > 8.5)&(tt(ii) < 11) ) 
            if((height(ii) > 9) & (height(ii) <14))
                 tt2=[tt2 tt(ii)];
                 i=[i ii];
            end;   
         end;
end;
 Y1=[]; Y2=[];Y3=[];
            col1=[];
            for jj=1:length(tt2)
                  YY1 = [tt2(jj).*cos(tt2(jj))]';   YY2 = [height(i(jj))]';      YY3 = [ tt2(jj).*sin(tt2(jj))]';     
                  Y1=[Y1 YY1];  Y2=[Y2 YY2];  Y3=[Y3 YY3];
                 col11 = tt2(jj);
                 col1=[col1 col11];
            end;
                Y4=[Y1' Y2' Y3']';  bcol4=col1';
                 hin=scatter3(Y4(1,:),Y4(2,:),Y4(3,:),50,bcol4,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold on;          
 disp('已经得到第4部分补充集点Y4 bcol4');         
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
 tt2=[];   i=[];          
  for ii = 1:n
        if  ( (tt(ii) > 11.5)&(tt(ii) < 13.5) ) 
            if((height(ii) > 9) & (height(ii) <14))
                 tt2=[tt2 tt(ii)];
                 i=[i ii];
            end;   
         end;
end;
 Y1=[]; Y2=[];Y3=[];
            col1=[];
            for jj=1:length(tt2)
                  YY1 = [tt2(jj).*cos(tt2(jj))]';   YY2 = [height(i(jj))]';      YY3 = [ tt2(jj).*sin(tt2(jj))]';     
                  Y1=[Y1 YY1];  Y2=[Y2 YY2];  Y3=[Y3 YY3];
                 col11 = tt2(jj);
                 col1=[col1 col11];
            end;
                Y5=[Y1' Y2' Y3']';  bcol5=col1';
                 hin=scatter3(Y5(1,:),Y5(2,:),Y5(3,:),50,bcol5,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold on;          
 disp('已经得到第5部分补充集点Y5 bcol5');       