function best_updown= solve_miR(primtumor,typicalNormal,regulation, params)
% Finds a small set of highly up- and down- regulated miRNAs that covers most of the cancer
% cases. The selected miRNAs must satisfy a number of constraints (fold change, counts etc)
% Args:
% - params [struct] with members: (see default parameters below as an example)
%   - coverage: the required coverage (eg 0.9 to cover most cases or 1 to cover all cases)
%   - foldchange: the required fold change
%   - up_countLim [2]: vector with the [normal, cancer] read_counts_per_million threshold
%   - down_countLim [2]: same as up_countLim for the downregulated miR
% - best_updown [table]: 

if nargin < 4           % Default parameters
  params= struct(...
    'coverage',0.95,...
    'foldchange',10,...
    'up_countLim',[10,68],...   % x: x<normlim, x>tumlim
    'down_countLim',[68,8]...   % x: x>normlim, x<tumlim
    );
end

primtumor_mat= primtumor{:,:};
[nmir,ncase]= size(regulation);
[upSat,downSat]= satisfyConstraints(primtumor_mat,typicalNormal,regulation,params);
[miRcomboSat,comboConstituents]= mergeUpDownSat(upSat,downSat, params.coverage);

%% TODO
