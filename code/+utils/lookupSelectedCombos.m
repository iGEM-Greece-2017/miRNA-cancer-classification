function miRdata= lookupSelectedCombos(miRcombos,comboCoverage, all_miRnames,regulation)
% Integrate relevant information for the specified up/down-regulated miRNA combo

Upregulated_miR= all_miRnames(miRcombos(:,1));
Downregulated_miR= all_miRnames(miRcombos(:,2));
Coverage= comboCoverage;
Fold_change_Up= exp(regulation(miRcombos(:,1)));
Fold_change_Down= exp(regulation(miRcombos(:,2)));

miRdata= table(Upregulated_miR,Downregulated_miR,Coverage,Fold_change_Up,Fold_change_Down);
