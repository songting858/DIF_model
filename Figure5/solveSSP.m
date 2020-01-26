function V=solveSSP(GE,GI,a,b,c)

global NE;
global NI;
global size;
global dt;

global G_L;
global V_L;
global vrest;

V=vrest*ones(size,1);

Vot_Excitatory=0;
Vot_Inhibitory=-80;

for i=2:size
        
   up_temp= V(i-1)+(G_L*V_L)*dt;
   down_temp=(G_L)*dt;
       
   for k = 1: NE
       up_temp=up_temp+GE(k,i-1)*Vot_Excitatory*dt;
       down_temp=down_temp+GE(k,i-1)*dt;
   end
   
   for k = 1:NI
       up_temp=up_temp+GI(k,i-1)*Vot_Inhibitory*dt;
       down_temp=down_temp+GI(k,i-1)*dt;
   end
   
   w=1;
   for s = 1:NE
       for t = s+1:NE
           up_temp=up_temp+a(w)*GE(s,i-1)*GE(t,i-1)*Vot_Excitatory*dt;
           down_temp=down_temp+a(w)*GE(s,i-1)*GE(t,i-1)*dt;
           w=w+1;
       end
   end
   
   w=1;
   for s=1:NI
       for t = s+1:NI
           up_temp=up_temp+b(w)*GI(s,i-1)*GI(t,i-1)*Vot_Inhibitory*dt;
           down_temp=down_temp+b(w)*GI(s,i-1)*GI(t,i-1)*dt;
           w=w+1;
       end
   end
   
   w=1;
   for s=1:NE
       for t=1:NI
           up_temp=up_temp+c(w)*GE(s,i-1)*GI(t,i-1)*Vot_Excitatory*dt;
           down_temp=down_temp+c(w)*GE(s,i-1)*GI(t,i-1)*dt;
           w=w+1;
       end
   end
   
   V(i)=up_temp/(1+down_temp);
    
end