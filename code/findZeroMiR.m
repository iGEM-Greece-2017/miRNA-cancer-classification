function miR_zeroMask= findZeroMiR(primtumor,normal)
% Find miR which are zero both in the normal and in the cancer case

threshold= 1e-3;
normZ= min(normal{:,:},[],2) < threshold;
tumZ= quantile(primtumor{:,:},0.01,2) < threshold; % Robust against few cases >0
miR_zeroMask= normZ & tumZ;
