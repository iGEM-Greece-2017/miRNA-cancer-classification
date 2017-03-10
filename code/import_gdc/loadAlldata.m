function data= loadAlldata(datapath, datafilename, savefilepath)
% Load all data from files in "datapath" dir, save to "savefilepath" .mat and return them

names= dir(datapath);
names= arrayfun(@(x) x.name, names(3:end), 'UniformOutput',false);  % Keep dir names
nfiles= length(names);
data= cell(nfiles,1);
% For each file, load data
for i= 1:nfiles
  data{i}= readtable([datapath,'/',names{i},'/',datafilename]);
  data{i}= data{i}(:,1:3);    % Remove "cross_mapped" column
end
save(savefilepath, 'data');
end
