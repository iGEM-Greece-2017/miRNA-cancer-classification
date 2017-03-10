function showdistribution(data, reject_percentile)

discreteness= length(data)/length(unique(data));
data= data(data <= prctile(data,reject_percentile));
%{
if discreteness > 1000
  fprintf('[showdistribution]: bar graph (discreteness=%f)\n', discreteness);
  x= tabulate(data); bar(x(:,1),x(:,2));
else
  fprintf('[showdistribution]: histogram\n');
%}
  %histogram(data,'binmethod','integers');
  histogram(data,'normalization','pdf');
end
