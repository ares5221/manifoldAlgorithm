function a = unique(a,jA);
   isSetLab = logical(zeros(length(jA),1));
   isSetLab(a) = 1;
   a = jA(isSetLab);