function [upSat,downSat]= satisfyConstraints(primtumor_mat,typicalNormal,regulation,params)
% Make the constraint satisfaction masks, where each cell is 1 if all the constraints are
% satisfied for this miR and case

% 1: Fold change mask (must be first, because the other operations are different for up/down-regulated
upregMask= regulation > log(params.foldchange);
downregMask= regulation < -log(params.foldchange);

% 2: Tumor counts
up_tumCountMask= upregMask; down_tumCountMask= downregMask;
% Deselect where the upregulated cells have lower tumor counts than needed
up_tumCountMask( primtumor_mat(upregMask) < params.up_countLim(2) )= 0;
% Deselect where the downregulated cells have higher tumor counts than needed
down_tumCountMask( primtumor_mat(downregMask) > params.down_countLim(2) )= 0;

% 3: Normal counts
up_normCountMask= upregMask; down_normCountMask= downregMask;
% Deselect the upreg miR (rows) that have higher normal counts than needed (compare with normal-low)
up_normCountMask( typicalNormal(:,1) > params.up_countLim(1) ,:)= 0;
% Deselect the downreg miR (rows) that have lower normal counts than needed (compare with normal-high)
down_normCountMask( typicalNormal(:,2) < params.down_countLim(1) ,:)= 0;

% 4: Pre-mask
up_premask=   upregMask   & up_tumCountMask   & up_normCountMask;
down_premask= downregMask & down_tumCountMask & down_normCountMask;

% 5: Final mask, deselect the miR (rows) that have less coverage (percentage of cases that
%    they satisfy) than the minimum.
ncases= size(regulation,2);
upSat= up_premask; downSat= down_premask;
% "sum(up_premask,2)" is the number of satisfied cases per miR
upSat( sum(up_premask,2)./ncases < params.coverageLim ,:)= 0;
downSat( sum(down_premask,2)./ncases < params.coverageLim ,:)= 0;
