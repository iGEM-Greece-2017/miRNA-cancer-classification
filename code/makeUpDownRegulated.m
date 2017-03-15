function updownreg= makeUpDownRegulated(primtumor, typicalNormal)
% typicalNormal [1881]x[2]: column 1: min, column 2: max

%% Parameters
divisionSmoothing= 1e-3;

%% Algo
cases= size(primtumor,2);
typicalNormal= typicalNormal + divisionSmoothing;
primtumor= primtumor{:,:} + divisionSmoothing;
% Divide with min and max normal
minreg= log(primtumor ./ repmat(typicalNormal(:,1),1,cases));
maxreg= log(primtumor ./ repmat(typicalNormal(:,2),1,cases));

% If both minreg & maxreg have the same sign (both upregulated or downregulated), then keep
% the most conservative choice.
% If not, then too keep the most conservative choice.
%
% Select the value which is closest to zero (thus, the "most conservative choice")
% Should be minreg for upregulated and maxreg for downregulated
% Also, eliminates infinites, if not both values are infinite
selmin= abs(minreg) < abs(maxreg);
selmax= ~selmin;
% Substitute in updownreg
updownreg= primtumor;
updownreg(selmin)= minreg(selmin);
updownreg(selmax)= maxreg(selmax);

