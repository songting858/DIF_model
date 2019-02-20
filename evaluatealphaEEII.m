%this is the evaluation function used in DEalpha.m
function y = evaluatealphaEEII(g1,g2,alpha,SSP,EEcase)      

pred_ssp=solveSSPEEII(g1,g2,alpha,EEcase);  %EPSP profile produced by our DIF model
pred_ssp=pred_ssp'*15-70;

%compare our EPSP with the experimental measured EPSP to evaluate alpha
%y=max(abs(epsp-fv));
y=sum((pred_ssp-SSP).^2);  
end