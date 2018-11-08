 
%%%为了得到融合子流形的实验数据，设想是一次次放大Y4，直到Y4将Y1，Y2连起来，融合为一个子流形
clc
clear;
n=80000;
 tt = (3*pi/2)*(1+2*rand(1,n));  %x
 height = 21*rand(1,n);    %y
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                YY1=[Y1' Y2' Y3']';  bbcol1=col1';
                figure;
                 hin=scatter3(YY1(1,:),YY1(2,:),YY1(3,:),50,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold on;          
 disp('已经得到第4部分补充集点YY1 bbcol1');         
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tt2=[];   i=[];   
%%%第一次得到核心的小区域点
  for ii = 1:n
        if  ( (tt(ii) > 9.7)&(tt(ii) < 10.2) ) 
            if((height(ii) > 10.5) & (height(ii) <11.7))
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
                Y6=[Y1' Y2' Y3']';  bcol6=col1';
           
                 hin=scatter3(Y6(1,:),Y6(2,:),Y6(3,:),50,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold on;          
 disp('已经得到第4部分补充集点Y4 bcol4');         
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tt2=[];   i=[];   
%%%第一次得到核心的小区域点
  for ii = 1:n
        if  ( (tt(ii) > 9)&(tt(ii) < 10.5) ) 
            if((height(ii) > 10) & (height(ii) <12.1))
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
                Y7=[Y1' Y2' Y3']';  bcol7=col1';
           
                 hin=scatter3(Y7(1,:),Y7(2,:),Y7(3,:),50,'filled');  
                 set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
                 hold on;          
 disp('已经得到第4部分补充集点Y4 bcol4');         