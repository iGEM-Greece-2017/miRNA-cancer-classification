function [primtumor,normal]= importGDCdata()

[primtumor_joined,norm_joined]= concatenateGDCdatafiles;
% miRNA_ID -> row names (only numeric data remain in the tables)
primtumor= primtumor_joined(:,2:end);
primtumor.Properties.RowNames= primtumor_joined{:,1};
normal= norm_joined(:,2:end);
normal.Properties.RowNames= norm_joined{:,1};
% Separate raw counts and counts per million (relative counts)
primtumor= [primtumor(:, logical(mod(1:end,2))), primtumor(:, ~logical(mod(1:end,2)))];
normal= [normal(:, logical(mod(1:end,2))), normal(:, ~logical(mod(1:end,2)))];
