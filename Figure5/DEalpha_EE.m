function alpha_EE =DEalpha_EE(VE1,VE2,VS) 

global dt;
global tstop;

%inidta could be set as 0 (a new start) 
%or x (a continuous run if the last run is not convergent) 
inidata=0;    
%iteration number
gen_max=100;

t=0:dt:tstop;

GE1=computeGE(VE1);
GE2=computeGE(VE2);

%core part of DE method
CR=0.8;
F=0.8;
%species number
NP=10;  
%parameter number (here only alpha)
D=1;   
%describe how close the two voltage profiles 
cost=zeros(1,NP);
    
%the matrix record different speicies' parameters
x=zeros(NP,D);

%initialization parameter
if inidata==0
    x(:,1)=3:-3:-24;
else
    x=inidata;
end

%initialization cost
for i = 1:NP   
     cost(i)=evaluatealphaEE(x(i,:),GE1,GE2,VS);
end

%x2 as a temp x
x2=x;

count=1;
while (count < gen_max)
    for i =1:NP
        a=floor(rand(1)*NP)+1;
        while (a==i)
        a=floor(rand(1)*NP)+1;
        end
        b=floor(rand(1)*NP)+1;
        while (b==a||b==i)
        b=floor(rand(1)*NP)+1;
        end
        c=floor(rand(1)*NP)+1;
        while (c==a||c==b||c==i)
        c=floor(rand(1)*NP)+1;
        end

        if rand(1)<CR
            trial=x(c)+F*(x(a)-x(b));                
        else
            trial=x(i);
        end

        score=evaluatealphaEE(trial,GE1,GE2,VS);

        if score <= cost(i)
            x2(i,:)=trial;
            cost(i)=score;
        else
            x2(i,:)=x(i,:);
        end
    end 
    x=x2;

    %print out the generation of x as well as the cost of x
    count=count+1;
    disp(count);
    disp(cost);
end

%find the index of the species x with minimum cost
index=find(cost==min(cost));
index=index(1);
%read out its corresponding alpha
alpha_EE=x(index);
disp(alpha_EE);


ssp=solveSSPEE(alpha_EE,GE1,GE2);
%figure plot
figure;
plot(t,ssp,'r','linewidth',2);

%error between DIF and NEURON
%errorDIF(kk)=max(abs(ssp'-VS))/max(VS);

a=0;
ssp=solveSSPEE(a,GE1,GE2);
%error between IF and NEURON
%errorIF(kk)=max(abs(ssp'-VS))/max(VS);

hold on;
plot(t,ssp,'g','linewidth',2);
hold on;
plot(t,VS,'b','linewidth',2);
hold on;
plot(t,VE1,'--k','linewidth',2);
hold on
plot(t,VE2,'--k','linewidth',2);

legend('DIF','IF','NEURON','EPSP1','EPSP2','Location','Best');

xlabel('Time (ms)','fontsize',20);
ylabel('Membrane potential (mV)','fontsize',20);
set(gca,'FontSize',15);