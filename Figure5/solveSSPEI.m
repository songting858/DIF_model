%compute SSP given GE & GI at each time point £¨multiple parameters£©
function V=solveSSPEI(alpha_EI,gE,gI)

global dt;
global G_L;
global V_L;
global V_E;
global V_I;
global size;
global vrest;


V=vrest*ones(size,1);


for i = 2:size

    V(i)=(V(i-1)+(G_L*V_L+gE(i)*(1+alpha_EI*gI(i))*V_E+gI(i)*V_I)*dt)...
            /(1+(G_L+gE(i)*(1+alpha_EI*gI(i))+gI(i))*dt);
  
end