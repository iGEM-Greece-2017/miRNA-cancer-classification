%% Find best miRNAs that cover the cancer cases sufficiently well
[primtumor,normal,typnorm,reg]= preprocessGDC();
pvalues= zeros(size(primtumor,1),1);

params= struct(...
    'totalcoverage',0.99,...    % Find enough miR to cover 99% of cancer cases
    'significanceLim',0.05,...
    'coverageLim',0.1,...      % Accept miR with coverage >10%
    'foldchange',10,...         % How many times greater/smaller in cancer than normal
    'up_countLim',[10,68],...   % Read count lims. x: x<normlim, x>tumorlim
    'down_countLim',[68,8]...   % Read count lims. x: x>normlim, x<tumorlim
    );
[bestCombos,bestCov,bestComboSat,updownSat]= solve_miR(primtumor,typnorm,reg,pvalues, params);
miRdata= utils.lookupSelectedCombos(bestCombos,bestCov,bestComboSat,updownSat, ...
  pvalues,primtumor.Properties.RowNames,primtumor,normal,reg);
miRdata
% For combo miR, get individual info for up/down
[combo_updata,combo_downdata]= utils.lookupSelectedUpDown({bestCombos(:,1),bestCombos(:,2)},...
  {miRdata{:,'Inc_Coverage'},miRdata{:,'Inc_Coverage'}}, updownSat, pvalues, ...
  primtumor.Properties.RowNames,primtumor,normal,reg);

%% Get individual info forall up/down miR which satisfy the constraints (at least in 1 case)
upcov= sum(updownSat{1},2); downcov= sum(updownSat{2},2);
upmir= find(upcov>0); downmir= find(downcov>0); 
upcov= upcov(upcov>0); downcov= downcov(downcov>0);
[upcov,upi]= sort(upcov,'descend'); [downcov,dni]= sort(downcov,'descend');
upmir= upmir(upi); downmir= downmir(dni);

[updata,downdata]= utils.lookupSelectedUpDown({upmir,downmir}, {upcov,downcov}, ...
  updownSat, pvalues, primtumor.Properties.RowNames,primtumor,normal,reg);
updata
downdata
