%this is the evaluation function used in DEalpha.m
function error = evaluatealphaEE(alpha_EE,g1,g2,VS)     

    ssp=solveSSPEE(alpha_EE,g1,g2);  
    error=sum((ssp'-VS).^2);  

end