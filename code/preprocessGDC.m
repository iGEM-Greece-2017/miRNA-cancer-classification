function [primtumor, normal]= preprocessGDC()

% Import GDC data
concatenateGDCdatafiles;
primtumor= primtumor_joined(:,2:end);
primtumor.Properties.RowNames= primtumor_joined{:,1};
normal= norm_joined(:,2:end);
normal.Properties.RowNames= norm_joined{:,1};
% Only keep raw counts
primtumor= primtumor(:, logical(mod(1:end,2)));
normal= normal(:, logical(mod(1:end,2)));
