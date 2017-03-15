function typical= defTypical(normal)

%low= min(normal{:,:},[],2);
%high= max(normal{:,:},[],2);
low= quantile(normal{:,:},0.20,2);
high= quantile(normal{:,:},0.80,2);
typical= [low,high];
