%this is the evaluation function used in DEalpha.m
function error = evaluatealphaEI(alpha_EI,gE,gI,VS)     

    ssp=solveSSPEI(alpha_EI,gE,gI);  
    error=sum((ssp'-VS).^2);  

end