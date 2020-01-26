%this is the evaluation function used in DEalpha.m
function error = evaluatealphaII(alpha_II,g1,g2,VS)     

    ssp=solveSSPII(alpha_II,g1,g2);  
    error=sum((ssp'-VS).^2);  

end