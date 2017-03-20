function showdistribution(data, keep_percentile)

discreteness= length(data)/length(unique(data));
data= data(data <= prctile(data,100-(100-keep_percentile)/2) & data >= prctile(data,(100-keep_percentile)/2));
%{
if discreteness > 1000
  fprintf('[showdistribution]: bar graph (discreteness=%f)\n', discreteness);
  x= tabulate(data); bar(x(:,1),x(:,2));
else
  fprintf('[showdistribution]: histogram\n');
%}
  %histogram(data,'binmethod','integers');
  histogram(data,'normalization','probability');
end
