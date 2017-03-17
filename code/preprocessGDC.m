function [primtumor,normal,typicalNormal, regulation]= preprocessGDC(primtumor,normal)
% Import the GDC data if needed and preprocess them. Input is *optional*

%% Import data if needed
% If the data weren't given as input, import them
if nargin==0
  % Import GDC data
  fprintf('[preprocessGDC]: Importing GDC data\n');
  [primtumor, normal]= importGDCdata();
end
%% Preprocess
% Keep relative counts
try
  primtumor= primtumor(:,contains(primtumor.Properties.VariableNames, 'relcount')); % FIX selector (use variable name)
  normal= normal(:,contains(normal.Properties.VariableNames, 'relcount'));
catch
  firstname= primtumor.Properties.VariableNames{1};
  if ~contains(firstname,'relcount')
    primtumor= primtumor(:,end/2+1:end);
    normal= normal(:,end/2+1:end);
  end
end
% Remove miR with 0 expression both in the normal and the cancer cases
miR_zeroMask= findZeroMiR(primtumor,normal);
primtumor= primtumor(~miR_zeroMask,:);
normal= normal(~miR_zeroMask,:);
% Regulation
typicalNormal= defTypical(normal);
regulation= makeUpDownRegulated(primtumor, typicalNormal); % Transform to {up,down}regulated
