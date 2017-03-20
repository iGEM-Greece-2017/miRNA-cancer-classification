function [mirclusters, caseclusters]= clusterGDC(primtumor,normal)

%% miR clusters
%canberradist= @(x,Y) sum( abs(x-Y)./(abs(x)+abs(Y)), 2);
maxclusters= [2:10,15]; mirdist= 'correlation';
mirdata= [primtumor{:,:},normal{:,:}];
mirclusters= mirClustAlgo(mirdata, maxclusters, mirdist);

% Good clusters: 3-4?

%{
r= [];
for i=1:size(mirclusters,2)
  figure(1); subplot(121);
  [s,h]= silhouette(mirdata,mirclusters(:,i), mirdist);
  r= [r;[sum(s<0)/size(mirclusters,1), sum(-s(s<0))/sum(s(s>0))]]; if r(end,2)>1, r(end,2)=1; end;
  subplot(122); tbl=tabulate(mirclusters(:,i)); pareto(tbl(:,2));
  pause;
end
figure(2); plot(maxclusters,r);
legend('#<0', 'area<0'); title('miR clusters: silhouette performance metrics'); grid minor;
%}

%% case clusters
maxclusters= 3; casedist= 'correlation';
case_l= linkage(primtumor{:,:}', 'complete', casedist);%@(x,Y) canberradist(x,Y));
caseclusters= cluster(case_l,'maxclust',maxclusters);

r= [];
for i=1:size(caseclusters,2)
  figure(i);
  [s,h]= silhouette(primtumor{:,:}',caseclusters(:,i), casedist);
  r= [r;[sum(s<0)/size(caseclusters,1), sum(-s(s<0))/sum(s(s>0))]]; if r(end,2)>1, r(end,2)=1; end;
  pause;
end
figure(10); plot(maxclusters,r);
legend('#<0', 'area<0'); title('Case clusters: silhouette performance metrics'); grid minor;
