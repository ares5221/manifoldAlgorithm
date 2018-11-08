function c = gintersect(a,b,allNumber);
   isSetLab = logical(zeros(allNumber,1));
   isSetLab(b) = 1;
   c = a(isSetLab(a));
   