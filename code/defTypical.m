function typical= defTypical(normal)

m= min(normal,[],2);
M= max(normal,[],2);
typical= [m,M];
