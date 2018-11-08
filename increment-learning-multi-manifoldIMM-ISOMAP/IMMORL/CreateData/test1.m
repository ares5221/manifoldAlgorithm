clc
clear;
n=2000;
%{
   x = rand(n,1);
    y = rand(n,1);
%   s = 1.5; % # tours
        L = 21; % width
        v = 3*pi/2 * (1 + 2*x');
        X(2,:) = L * y';
        X(1,:) = cos( v ) .* v;
        X(3,:) = sin( v ) .* v;
      col = X(3,:);    
figure;   
hin=scatter3(X(1,:),X(2,:),X(3,:),50,col,'filled');  
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
hold off;
%}
            tt = (3*pi/2)*(1+2*rand(1,2*n));  %x
            height = 21*rand(1,2*n);    %y
            kl = repmat(0,1,2*n);   %初始化一个1X2n的0矩阵
            for ii = 1:2*n
                
                 if ( ((tt(ii) > 8)&(tt(ii) < 8.5)) ||((tt(ii) >11)&(tt(ii) < 11.5)) ||((tt(ii) >13.5)&(tt(ii) < 14.2))   )
%                      if ((height(ii) > 9) & (height(ii) <14))
                        kl(ii) = 1;
%                      end;
               end;
               
                if ( (tt(ii) > 8.5)&(tt(ii) < 11) )
                   if ((height(ii) > 9) & (height(ii) <14))
                        kl(ii) = 1;
                    end;  
                end;
                
                 if ( (tt(ii) >11.5)&(tt(ii) < 13.5)  )
                   if ((height(ii) > 6) & (height(ii) <16))
                        kl(ii) = 1;
                    end;  
                end;
             
               
            end;
            kkz = find(kl==0);
            tt1 = tt(kkz(1:n));
            height1 = height(kkz(1:n));
            X = [tt1.*cos(tt1); height1; tt1.*sin(tt1)]';     
            col = tt1';
            X = X';
            
   figure;   
hin=scatter3(X(1,:),X(2,:),X(3,:),50,col,'filled');  
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
hold off;
         
            
            
             for ii = 1:n
                
                 if ( ((tt(ii) > 8)&(tt(ii) < 8.5)) ||((tt(ii) >11)&(tt(ii) < 11.5)) &((tt(ii) >13.5)&(tt(ii) < 15.5))&(tt(ii) < 8)   )   
%                      if ((height(ii) > 9) & (height(ii) <14))
                        kl(ii) = 1;
%                      end;
               end;
               
                 if (((tt(ii) > 8)&(tt(ii) < 8.5)) ||((tt(ii) >11)&(tt(ii) < 11.5)) &((tt(ii) >13.5)&(tt(ii) < 15.5))&(tt(ii) < 8) & (tt(ii) >10)  )
                    if ((height(ii) < 9) & (height(ii) >14))
                        kl(ii) = 1;
                      end;  
                 end;
                 
%                  if ( tt(ii) >11.5 )
%                    if ((height(ii) < 6) & (height(ii) >16))
%                         kl(ii) = 1;
%                     end;  
%                 end;
             
               
            end;
            kkz1 = find(kl==1);
            tt2 = tt(kkz1(1:1200));
            height2 = height(kkz1(1:1200));
            Y = [tt2.*cos(tt2); height2; tt2.*sin(tt2)]';     
            col1 = tt2';
            Y = Y';

figure;   
hin=scatter3(Y(1,:),Y(2,:),Y(3,:),50,col1,'filled');  
set(hin,'MarkerEdgeColor',[0.5 0.5 0.5]);
hold off;


%      elseif ( ((tt(ii) > 7)&(tt(ii) < 9)) ||((tt(ii) >11)&(tt(ii) < 13.5))   )
%                     if ((height(ii) > 9) & (height(ii) <14))
%                         kl(ii) = 1;
%                     end;
 