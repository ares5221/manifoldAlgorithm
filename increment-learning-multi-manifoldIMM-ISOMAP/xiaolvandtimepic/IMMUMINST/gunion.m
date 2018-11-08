function c = gunion(a,b,allSet);
   isSetLab = logical(zeros(length(allSet),1));
   isSetLab(a) = 1;
   isSetLab(b) = 1;
   c = allSet(isSetLab);