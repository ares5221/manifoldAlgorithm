function d = L2_distance(a,b,df)
% L2_DISTANCE - computes Euclidean distance matrix
%
% E = L2_distance(A,B)
%
%    A - (DxM) matrix 
%    B - (DxN) matrix
%    df = 1, force diagonals to be zero; 0 (default), do not force
% 
% Returns:
%    E - (MxN) Euclidean distances between vectors in A and B
%
%
% Description : 
%    This fully vectorized (VERY FAST!) m-file computes the 
%    Euclidean distance between two vectors by:
%
%                 ||A-B|| = sqrt ( ||A||^2 + ||B||^2 - 2*A.B )
%
% Example : 
%    A = rand(400,100); B = rand(400,200);
%    d = distance(A,B);

if (nargin < 2)
   error('Not enough input arguments');
end

if (nargin < 3)
   df = 0;    % by default, do not force 0 on the diagonal
end

if (size(a,1) ~= size(b,1))
   error('A and B should be of same dimensionality');
end

if ~(isreal(a)*isreal(b))
   disp('Warning: running distance.m with imaginary numbers.  Results may be off.'); 
end

if (size(a,1) == 1)
  a = [a; zeros(1,size(a,2))]; 
  b = [b; zeros(1,size(b,2))]; 
end

aa=sum(a.*a); bb=sum(b.*b); ab=a'*b; 
d = sqrt(repmat(aa',[1 size(bb,2)]) + repmat(bb,[size(aa,2) 1]) - 2*ab);

% make sure result is all real
d = real(d); 

% force 0 on the diagonal? 
if (df==1)
  d = d.*(1-eye(size(d)));
end;