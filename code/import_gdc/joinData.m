function joinedData= joinData(data,joinedDataSavefilepath)
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

save([joinedDataSavefilepath,'.mat'], 'joinedData');
% Export as csv as well
writetable(joinedData, [joinedDataSavefilepath,'.csv'], 'Delimiter','\t', 'QuoteStrings',true);
