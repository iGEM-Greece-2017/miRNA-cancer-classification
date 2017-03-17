function [bestCombos,bestComboCoverage]= solve_miR(primtumor,typicalNormal,regulation, params)
% Finds a small set of highly up- and down- regulated miRNAs that covers most of the cancer
% cases. The selected miRNAs must satisfy a number of constraints (fold change, counts etc)
% Args:
% - params [struct] with members: (see default parameters below as an example)
%   - totalcoverage: the required total coverage of the miR subset
%       (eg 0.9 to cover most cases or 1 to cover all cases)
%   - coverageLim: the required coverage per miR (miR with less coverage won't be considered)
%   - foldchange: the required fold change
%   - up_countLim [2]: vector with the [normal, cancer] read_counts_per_million threshold
%   - down_countLim [2]: same as up_countLim for the downregulated miR
% - bestCombos [combos]x[2]: col1-> upregulated, col2-> downregulated

if nargin < 4           % Default parameters
  params= struct(...
    'totalcoverage',0.99,...
    'coverageLim',0.1,...       % Accept miR with coverage >10%
    'foldchange',10,...
    'up_countLim',[10,68],...   % x: x<normlim, x>tumlim
    'down_countLim',[68,8]...   % x: x>normlim, x<tumlim
    );
end

primtumor_mat= primtumor{:,:};
[upSat,downSat]= satisfyConstraints(primtumor_mat,typicalNormal,regulation,params);
[miRcomboSat,comboDictionary]= mergeUpDownSat(upSat,downSat, params.coverageLim);
[bestCombos,bestComboCoverage]= smallestCoveringSubset(miRcomboSat, params.totalcoverage);
bestCombos= comboDictionary(bestCombos,:);
