function miRdata= lookupSelectedCombos(miRcombos,comboCoverage, all_miRnames,regulation)

%{
miRnames= arrayfun(@(x) all_miRnames(x), miR);
miRcov= arrayfun(@(x) sum(primtumor_mat(x,:),2), miR);
miRfoldchange= arrayfun(@(x) exp(regulation(x,:)), miR, 'UniformOutput',false);
%}

Upregulated_miR= all_miRnames(miRcombos(:,1));
Downregulated_miR= all_miRnames(miRcombos(:,2));
Coverage= comboCoverage;
Fold_change_Up= exp(regulation(miRcombos(:,1)));
Fold_change_Down= exp(regulation(miRcombos(:,2)));

miRdata= table(Upregulated_miR,Downregulated_miR,Coverage,Fold_change_Up,Fold_change_Down);
