function a = setdiff(a,b,allNumber);
   isSetLab = logical(ones(allNumber,1));
   isSetLab(b) = 0;
   a = a(isSetLab(a));
   

   

   
