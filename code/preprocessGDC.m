function [primtumor, normal]= preprocessGDC(primtumor,normal)
% Import the GDC data if needed and preprocess them

%% Parameters
params= struct(...
  'maxcount_cutoff',5 ...   % Remove miRNAs that appear nowhere more times than this
  );
%% Import data if needed
% If the data weren't given as input, import them
if nargin==0
  % Import GDC data
  fprintf('[preprocessGDC]: Importing GDC data\n');
  [primtumor, normal]= importGDCdata();
end
%% Preprocess
% Remove miRNAs with too small absolute counts
maxRNA= max(primtumor{:,1:end/2},[],2);
primtumor= primtumor(maxRNA > params.maxcount_cutoff, :);
maxRNA= max(normal{:,1:end/2},[],2);
normal= normal(maxRNA > params.maxcount_cutoff, :);

