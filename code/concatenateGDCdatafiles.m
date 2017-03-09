%% Load all data
% If previously loaded from txt files, then a .mat file should have been saved.
% If that .mat file exists, load that, and not the original data

% All the parameters are here. Look no further!
params= struct(...
  'joinedDataSavefilepath','data/concatenate_miRNA/joinedData.mat',...   % Where to save the joined data
  'datapath','data/mirna-data',...                     % Folder where the data are
  'savefilepath','data/concatenate_miRNA/savedDatafileTables.mat',...    % Where to save intermediate results
  'datafilename','mirnas.quantification.txt'...        % The common datafile name 
  ...                                                  %   (same in every data folder)
  );

if ~isempty(dir(params.savefilepath))
  load(params.savefilepath);
else              % Load all .txt files
  names= dir(params.datapath);
  names= arrayfun(@(x) x.name, names(3:end), 'UniformOutput',false);  % Keep dir names
  nfiles= length(names);
  data= cell(nfiles,1);
  % For each file, load data
  for i= 1:nfiles
    data{i}= readtable([params.datapath,'/',names{i},'/',params.datafilename]);
    data{i}= data{i}(:,1:3);    % Remove "cross_mapped" column
  end
  save(params.savefilepath, 'data');
end

% Now, a "data" cell array should hold 1 table with 3 columns for each file
%% Join all data
ntables= length(data);
joinedData= data{1};    % initialize with 1st table
joinedData.Properties.VariableNames= {...     % Standardize column names
  'ID',...
  'count_1',...
  'relcount_1'
};
  
% For all the other tables, merge "joinedData" with the next table
for i= 2:ntables
  next= data{i};
  next.Properties.VariableNames= {...   % Standardize column names
    'ID',...
    ['count_',num2str(i)],...
    ['relcount_',num2str(i)]...
  };
  joinedData= join(joinedData,next, 'Keys','ID');
end

save(params.joinedDataSavefilepath, 'joinedData');

% Export as xls as well?
