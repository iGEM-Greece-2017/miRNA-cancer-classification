function typical= defTypical(normal)

%low= min(normal{:,:},[],2);
%high= max(normal{:,:},[],2);
low= quantile(normal{:,:},0.06,2);
high= quantile(normal{:,:},0.94,2);
typical= [low,high];
