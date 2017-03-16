function [primtumor,normal, updownreg]= preprocessGDC(primtumor,normal)
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
primtumor= primtumor(:,contains(primtumor.Properties.VariableNames, 'relcount')); % FIX selector (use variable name)
normal= normal(:,contains(normal.Properties.VariableNames, 'relcount'));
% Remove miR with 0 expression both in the normal and the cancer cases
miR_zeroMask= findZeroMiR(primtumor,normal);
primtumor= primtumor(~miR_zeroMask,:);
normal= normal(~miR_zeroMask,:);
% Regulation
typicalNormal= defTypical(normal);
updownreg= makeUpDownRegulated(primtumor, typicalNormal); % Transform to {up,down}regulated


