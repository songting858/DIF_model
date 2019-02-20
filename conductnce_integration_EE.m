%check the dendritic integration rule at the peak time of EPSP
%using NEURON software data 
%JUST FOR EE CONDUCTANCE INTEGRATION RULE

clear;
clc;

global lag;
lag=0.1;
global dt;

global GL;

%load the data from NEURON software
dat0=importdata('EEpair.dat');

dat=dat0.data;
%timestep used in NEURON
dt=0.1;
num=30;
size=100/dt+1;

volt=dat(1:size,1:num*3);

GL=0.11;

EPSP1=volt(:,1:3:end);
EPSP2=volt(:,2:3:end);
SSP=volt(:,3:3:end);

for i=1:num
    if max(SSP(:,i)>-63)  % exclude spike case
        continue;
    end
%     a(i)=max(EPSP1(:,i))
%     b(i)=max(EPSP2(:,i))
    GE1=computeGE(EPSP1(:,i));
    GE2=computeGE(EPSP2(:,i));
    posi=find(GE1==max(GE1),1);
    tempDGE=DeltaG_EE(SSP(:,i),GE1,GE2);
    DGE(i)=-tempDGE(posi);
    GE1GE2(i)=GE1(posi)*GE2(posi);  
end

%figure plot
d1=plot(GE1GE2,DGE,'ko','Markersize',8);
hold on;
modelfun=@(k,x)k*x;

alpha=nlinfit([0,GE1GE2],[0,DGE],modelfun,10);
x=linspace(0,max(GE1GE2)*1.1,100);
z=alpha*x;

plot(x,z,'k','linewidth',0.5);
ylim([0,Inf]);
xlabel('g_{E1}g_{E2} (mS^2 cm^{-4})','fontsize',8);
ylabel('-\Delta g (mS cm^{-2}) ','fontsize',8);
set(gca,'FontSize',6);
box off;
