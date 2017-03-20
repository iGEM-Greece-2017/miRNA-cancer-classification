function miRdata= lookupSelectedCombos(miRcombos,comboCoverage, all_miRnames,regulation)
% Integrate relevant information for the specified up/down-regulated miRNA combo

Upregulated_miR= all_miRnames(miRcombos(:,1));
Downregulated_miR= all_miRnames(miRcombos(:,2));
Coverage= comboCoverage;
Mean_Fold_change_Up= exp(mean(regulation(miRcombos(:,1),:),2));
Mean_Fold_change_Down= 1./exp(mean(regulation(miRcombos(:,2),:),2));

miRdata= table(Upregulated_miR,Downregulated_miR,Coverage,Mean_Fold_change_Up,Mean_Fold_change_Down);
