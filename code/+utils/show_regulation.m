function show_regulation(reg,accprc, titlestr)

utils.showdistribution(reg,accprc);
grid minor; title(titlestr); xlabel('ln regulation'); ylabel('pdf');
