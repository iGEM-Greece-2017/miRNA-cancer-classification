function [primtumor,normal]= importGDCdata()


dataimportParams= struct(...
  'primtumor_savefilepath','data/concatenate_miRNA/primary_tumor',...   % Where to save the primary tumor data
  'primtumor_datapath','data/gdc-stages/major_stages/4',...
  'norm_savefilepath','data/concatenate_miRNA/normal_tissue',...
  'norm_datapath','data/gdc-miRNA-solid_tissue_normal',...
  'savefilepath','data/concatenate_miRNA/tmp_loadedtxt',...         % Where to save intermediate results
  'datafilename','mirnas.quantification.txt',...        % The common datafile name (same in every data folder)
  'reimport',true ...
  );

[primtumor_joined,norm_joined]= concatenateGDCdatafiles(dataimportParams);
% miRNA_ID -> row names (only numeric data remain in the tables)
primtumor= primtumor_joined(:,2:end);
primtumor.Properties.RowNames= primtumor_joined{:,1};
normal= norm_joined(:,2:end);
normal.Properties.RowNames= norm_joined{:,1};
% Separate raw counts and counts per million (relative counts)
primtumor= [primtumor(:, logical(mod(1:end,2))), primtumor(:, ~logical(mod(1:end,2)))];
normal= [normal(:, logical(mod(1:end,2))), normal(:, ~logical(mod(1:end,2)))];
