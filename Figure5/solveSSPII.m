%compute SSP given GE & GI at each time point £¨multiple parameters£©
function V=solveSSPII(alpha_II,g1,g2)

%compute SSP given a pair of GE or a pair of GI
%used in DEalphaEEII

global dt;
global G_L;
global V_L;
global V_I;
global size;
global vrest;


V=vrest*ones(size,1);

for i=2:size
    
        V(i)=(V(i-1)+(G_L*V_L+(g1(i)+g2(i)+alpha_II*g1(i)*g2(i))*V_I)*dt)...
            /(1+(G_L+g1(i)+g2(i)+alpha_II*g1(i)*g2(i))*dt);

end