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
% Keep relative counts
primtumor= primtumor(:,end/2+1:end);
normal= normal(:,end/2+1:end);

typicalNormal= defTypical(normal);
[upreg,downreg]= makeUpDownRegulated(primtumor, typicalNormal); % Transform to {up,down}regulated

