function [updata,downdata]= lookupSelectedUpDown(updownmir,comboCoverage,comboSat, all_miRnames,primtumor,normal,regulation)
% Integrate relevant information for the specified up/down-regulated miRNA combo

upmir= updownmir{1}; downmir= updownmir{2};
upsat= comboSat{1}; downsat= comboSat{2};
Upregulated_miR= all_miRnames(upmir);
Downregulated_miR= all_miRnames(downmir);

Coverage= round(sum(upsat(upmir,:),2)./size(upsat,2)*100,1);
Inc_Coverage= round(comboCoverage{1}./size(upsat,2)*100,1);
Mean_Fold_change= arrayfun(@(mir) exp(mean(regulation(mir,upsat(mir,:)),2)), upmir);
Mean_Tumor_Reads_per_million= arrayfun(@(mir) mean(primtumor{mir,upsat(mir,:)},2), upmir);
Mean_Normal_Reads_per_million= mean(normal{upmir,:},2);
updata= table(Upregulated_miR,Coverage,Inc_Coverage,Mean_Fold_change,Mean_Tumor_Reads_per_million,Mean_Normal_Reads_per_million);

Coverage= round(sum(downsat(downmir,:),2)./size(upsat,2)*100,3,'significant');
Inc_Coverage= round(comboCoverage{2}./size(upsat,2)*100,3,'significant');
Mean_Fold_change= arrayfun(@(mir) 1./exp(mean(regulation(mir,downsat(mir,:)),2)), downmir);
Mean_Tumor_Reads_per_million= arrayfun(@(mir) mean(primtumor{mir,downsat(mir,:)},2), downmir);
Mean_Normal_Reads_per_million= mean(normal{downmir,:},2);
downdata= table(Downregulated_miR,Coverage,Inc_Coverage,Mean_Fold_change,Mean_Tumor_Reads_per_million,Mean_Normal_Reads_per_million);
