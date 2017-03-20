function [bestCombos,bestComboCoverage,bestComboSat]= ...
  solve_updown_separate(primtumor,typicalNormal,regulation)

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
[bestUp,bestUpCoverage]= smallestCoveringSubset(upSat, params.totalcoverage);
[bestDown,bestDownCoverage]= smallestCoveringSubset(downSat, params.totalcoverage);

bestCombos= {bestUp,bestDown};
bestComboCoverage= {bestUpCoverage, bestDownCoverage};
bestComboSat= {upSat,downSat};
