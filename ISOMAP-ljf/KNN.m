function rate = KNN(Train_data,Train_label,Test_data,Test_label,k,Distance_mark);
% K-Nearest-Neighbor classifier(K-NN classifier)
%Input:
%     Train_data,Test_data are training data set and test data
%     set,respectively.(Each row is a data point)
%     Train_label,Test_label are column vectors.They are labels of training
%     data set and test data set,respectively.
%     k is the number of nearest neighbors
%     Distance_mark           :   ['Euclidean', 'L2'| 'L1' | 'Cos'] 
%     'Cos' represents Cosine distance.
%Output:
%     rate:Accuracy of K-NN classifier
%This code is written by Gui Jie in the evening 2009/03/11.
%If you have find some bugs in the codes, feel free to contract me


if nargin < 5
    error('Not enought arguments!');
elseif nargin < 6
    Distance_mark='L2';
end

[n dim]    = size(Test_data);% number of test data set
train_num  = size(Train_data, 1); % number of training data set

% Normalize each feature to have zero mean and unit variance.
% If you need the following four rows,you can uncomment them.
% M        = mean(Train_data); % mean & std of the training data set
% S        = std(Train_data);
% Train_data = (Train_data - ones(train_num, 1) * M)./(ones(train_num, 1) * S); % normalize training data set
% Test_data            = (Test_data-ones(n,1)*M)./(ones(n,1)*S); % normalize data

U        = unique(Train_label); % class labels
nclasses = length(U);%number of classes

%Result  = zeros(n, 1);
Result  = [];
Count   = zeros(nclasses, 1);

dist1 = L2_distance(Train_data',Test_data',0);
clear Test_data Train_data;
[Dummy Inds] = sort(dist1);
for i= 1:n
    % compute the class labels of the k nearest samples
    Count(:) = 0;
    for j = 1:k
        ind = find(Train_label(Inds(j,i)) == U); %find the label of the j'th nearest neighbors
        Count(ind) = Count(ind) + 1;
    end% Count:the number of each class of k nearest neighbors     
    % determine the class of the data sample
    [dummy ind] = max(Count);
    Result = [Result; U(ind)];
end
correctnumbers=length(find(Result==Test_label));
rate=correctnumbers/n;

