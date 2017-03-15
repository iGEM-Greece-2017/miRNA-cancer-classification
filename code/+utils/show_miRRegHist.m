function show_miRRegHist(reg,predicate,nsel, titlestr)

nmiR= size(reg,1);
randsel= randsample(nmiR, nsel);

figure; hold on;
for i= 1:nsel
  mir= reg(randsel(i), predicate(randsel(i),:));
  histogram(mir);
end
hold off;
grid minor; title(titlestr); xlabel('ln regulation'); ylabel('count');
