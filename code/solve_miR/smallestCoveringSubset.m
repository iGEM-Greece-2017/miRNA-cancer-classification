function [selCombos, selComboCoverage]= smallestCoveringSubset(miRcomboSat, totalcoverage)
% Algorithm that selects the (approximately) smallest miR combo subset that covers enough cases.
% Finding the smallest combo exactly is probably NP-complete. This is a greedy algorithm:
% it picks the combo with the highest coverage and removes the satisfied cases, then repeats;

ncase= size(miRcomboSat,2);
achievedCoverage= 0;
selCombos= []; selComboCoverage= [];
while(achievedCoverage < totalcoverage && ~isempty(miRcomboSat))
  comboCoverage= sum(miRcomboSat,2);        % coverage for each miR combo
  [bestCov,bestCombo]= max(comboCoverage);  % greedily select the combo with the highest coverage
  miRcomboSat= miRcomboSat(:, ~miRcomboSat(bestCombo,:)); % remove satisfied cases
  achievedCoverage= achievedCoverage + bestCov./ncase;    % update the coverage achieved so far
  selCombos= [selCombos; bestCombo];            % append new best combo
  selComboCoverage= [selComboCoverage; bestCov];
  if bestCov==0, break; end;
end
