function [comboSat, comboConstituents]= mergeUpDownSat(upSat,downSat, coverageLim)
% Eliminates failed miR and merges the satisfaction masks, to produce a constraint satisfaction matrix
% with all the possible up/down-regulated miR pairs that satisfy the coverage constraint as rows.
%
% comboConstituents [rows(comboSat)]x[2]: contains each miR up/down-regulated combo's constituents.
%   Column 1 -> upregulated, column 2 -> downregulated

[nmir,ncase]= size(upSat);
% Successful miR (not all 0) mask
sucUp= logical(1:nmir); sucDown= logical(1:nmir);
sucUp( all(upSat==0,2) )= 0; sucDown( all(downSat==0,2) )= 0;
% Eliminate failed miR
upSat_suc= upSat(sucUp)'; downSat_suc= downSat(sucDown)';
% Total combos
totalcombos= sum(sucUp)*sum(sucDown);

% Make combo satisfaction mask
comboSat= repmat(upSat_suc,sum(sucDown),1) & ...      % Many copies of upSat_suc
  reshape(repmat(downSat_suc',sum(sucUp),1), 1,[])';  % Many copies of each row of downSat_suc

% Make combo constituents list (same replication method as in satisfaction mask, only for
% the successful miR from the numbers 1 to nmir
idxUp= 1:nmir; idxUp= idxUp(sucUp)';
idxDown= 1:nmir; idxDown= idxDown(sucDown)';
comboConstituents= [repmat(idxUp,sum(sucDown),1), ...
  reshape(repmat(idxDown',sum(sucUp),1), 1,[])'];
% Combo case coverage mask
sucCombo= logical(1:totalcombos);
sucCombo( sum(comboSat,2)./ncase < coverageLim )= 0;
% Eliminate failed miR combos
comboSat= comboSat(sucCombo,:);
comboConstituents= comboConstituents(sucCombo,:);
