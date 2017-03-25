function [D,DE,E] = compute_nn_graph(X,options)

DFull = L2_distance(X,X,1);  
[D1,nn_list] = sort(DFull);
D1 = D1';
nn_list = nn_list';
    
n = size(D1,1);
% mode by selectione
neighborList = options.nn_nbr;
number = length(options.nn_nbr); 
D = cell(number,1);
DE = cell(number,1);
E = cell(number,1);

for i = 1:number
    tempD = zeros(n)+Inf;
    if(options.nntype)
        neighbor = neighborList{i};
        for j = 1:n
            currN = neighbor{j};
            currN = [j currN];
            tempD(j,currN) = DFull(j,currN);
            tempD(j,j) = 0;
        end;
    else
        for j=1:n
            tempD(j,nn_list(j,1:neighborList(i)+1)) = D1(j,1:neighborList(i)+1);
            tempD(j,j) = 0;
        end;
    end;
    DE{i} = tempD';
        
    A = ~isinf(tempD);%邻接矩阵，即两点之间有边连接即为1,否则为0
    % ensure D is symmetric
    tempD = min(tempD,tempD');
        
    D{i} = tempD;
    E{i} = A;
end



