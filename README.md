# miRNA-cancer-classification
Gather and analyse miRNA data to design binary networks capable of recognising colorectal cancer versus healthy cells.

# Data acquisition
## Online Database
The data come from the GDC online database. The database API downloads each datafile in a separate folder with a hash
name. These need to be concatenated into a single datafile to make for easier use.

### Concatenation 
A Matlab script loads all the data from their .txt files as Matlab tables and joins them (in the SQL sense, where the
`miRNA_ID` is the join key) into a single table for further analysis.

To run this script, start Matlab in the project root directory and run `matlab_start.m`, then call the `concatenateGDCdatafiles.m` script.


