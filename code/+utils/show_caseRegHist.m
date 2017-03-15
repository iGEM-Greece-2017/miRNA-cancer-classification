function show_caseRegHist(reg,predicate,nsel, titlestr)

ncase= size(reg,2);
randsel= randsample(ncase, nsel);

figure; hold on;
for i= 1:nsel
  cancercase= reg( predicate(:,randsel(i)), randsel(i) );
  size(cancercase)
  histogram(cancercase);
end
hold off;
grid minor; title(titlestr); xlabel('ln regulation'); ylabel('count');


% Up:   58,329,113,124,240
% Down: 182,60,255
