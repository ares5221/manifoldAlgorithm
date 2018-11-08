function T = getTvalue(aa,dd,d)
if (d==2)
    list=ones(360,4)*Inf;
    ss = 1:360;
    ss = ss/360*6.28;
    for i = 1:360
        T1 = [cos(ss(i)) -sin(ss(i));sin(ss(i)) cos(ss(i))];
        for j = 1:4
            if j==1 T2 = [1 0; 0 1];end;
            if j==2 T2 = [1 0; 0 -1];end;
            if j==3 T2 = [-1 0; 0 1];end;
            if j==4 T2 = [-1 0; 0 -1];end;
            mm=trace(aa'*aa+dd'*dd)-2*trace(aa'*T1*T2*dd);
            list(i,j) = mm;
        end;
    end;

    [a,b] = sort(list);  [a,c]= sort(a(1,:));
    if c(1)==1 T2 = [1 0; 0 1];end;
    if c(1)==2 T2 = [1 0; 0 -1];end;
    if c(1)==3 T2 = [-1 0; 0 1];end;
    if c(1)==4 T2 = [-1 0; 0 -1];end; 
    T1 = [cos(ss(b(1,c(1)))) -sin(ss(b(1,c(1)))); sin(ss(b(1,c(1)))) cos(ss(b(1,c(1))))]; 
    T = T1*T2;
else
    if(d==1)
        list = [trace(aa'*aa+dd'*dd)-2*trace(aa'*dd) trace(aa'*aa+dd'*dd)-2*trace(-aa'*dd)];
        [a,b] = min(list);
        if(b==1) T = 1; else T=-1; end;
    else
        T=eye(d);
    end;
end;
