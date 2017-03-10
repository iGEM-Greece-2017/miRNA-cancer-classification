function [primtumor_joined, norm_joined]= concatenateGDCdatafiles()
% Load all data and concatenate them into large tables
% If previously loaded from txt files, then a .mat file should have been saved.
% If that .mat file exists, load that, and not the original data

%% All the parameters are here. Look no further!
params= struct(...
  'primtumor_savefilepath','data/concatenate_miRNA/primary_tumor',...   % Where to save the primary tumor data
  'primtumor_datapath','data/gdc-miRNA-primary_tumor',...               % Folder where the data are
  'norm_savefilepath','data/concatenate_miRNA/normal_tissue',...
  'norm_datapath','data/gdc-miRNA-solid_tissue_normal',...
  'savefilepath','data/concatenate_miRNA/tmp_loadedtxt',...         % Where to save intermediate results
  'datafilename','mirnas.quantification.txt'...        % The common datafile name (same in every data folder)
  );
%% Load from files
if ~isempty(dir([params.savefilepath,'primtumor.mat'])) && ...
   ~isempty(dir([params.savefilepath,'norm.mat']))
  primtumor_data= load([params.savefilepath,'primtumor.mat']);
  norm_data=      load([params.savefilepath,'norm.mat']);
  primtumor_data= primtumor_data.data;
  norm_data= norm_data.data;
else              % Load all .txt files
  primtumor_data= loadAlldata(params.primtumor_datapath, params.datafilename, ...
    [params.savefilepath,'primtumor.mat']);
  norm_data=      loadAlldata(params.norm_datapath,      params.datafilename, ...
    [params.savefilepath,'norm.mat']);
end

% Now, the cell arrays should hold 1 table with 3 columns for each file
%% Join all data
primtumor_joined= joinData(primtumor_data, params.primtumor_savefilepath);
norm_joined=      joinData(norm_data,      params.norm_savefilepath);
