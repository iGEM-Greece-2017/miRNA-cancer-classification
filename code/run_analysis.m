%% Find best miRNAs that cover the cancer cases sufficiently well
[primtumor,normal,typnorm,reg]= preprocessGDC();

params= struct(...
    'totalcoverage',0.99,...    % Find enough miR to cover 99% of cancer cases
    'coverageLim',0.1,...      % Accept miR with coverage >10%
    'foldchange',10,...         % How many times greater/smaller in cancer than normal
    'up_countLim',[10,68],...   % Read count lims. x: x<normlim, x>tumorlim
    'down_countLim',[68,8]...   % Read count lims. x: x>normlim, x<tumorlim
    );
[bestCombos,bestCov,bestComboSat]= solve_miR(primtumor,typnorm,reg, params);
miRdata= utils.lookupSelectedCombos(bestCombos,bestCov,primtumor.Properties.RowNames,reg);
miRdata
