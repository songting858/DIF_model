%compute SSP given GE & GI at each time point £¨multiple parameters£©
function V=solveSSPEE(alpha_EE,g1,g2)

%compute SSP given a pair of GE or a pair of GI
%used in DEalphaEEII

global dt;
global G_L;
global V_L;
global V_E;
global size;
global vrest;

V=vrest*ones(size,1);


for i=2:size

        V(i)=(V(i-1)+(G_L*V_L+(g1(i)+g2(i)+alpha_EE*g1(i)*g2(i))*V_E)*dt)...
            /(1+(G_L+g1(i)+g2(i)+alpha_EE*g1(i)*g2(i))*dt);

end