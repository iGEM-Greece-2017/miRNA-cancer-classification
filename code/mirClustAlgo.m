function [mirclusters]= mirClustAlgo(mirdata, maxclusters, mirdist)

mir_d= pdist(mirdata, mirdist);
mir_l= linkage(mir_d, 'ward');
mirclusters= cluster(mir_l,'maxclust',maxclusters);
