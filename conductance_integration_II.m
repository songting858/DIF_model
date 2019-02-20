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
dat0=importdata('IIpair.dat');

dat=dat0.data;
%timestep used in NEURON
dt=0.1;
num=30;
size=100/dt+1;

volt=dat(1:size,1:num*3);

GL=0.11;

IPSP1=volt(:,1:3:end);
IPSP2=volt(:,2:3:end);
SSP=volt(:,3:3:end);

for i=1:num
    if max(SSP(:,i)>-63)  % exclude spike case
        continue;
    end
    
    a(i)=min(IPSP1(:,i))
    b(i)=min(IPSP2(:,i))
    
    GI1=computeGI(IPSP1(:,i));
    GI2=computeGI(IPSP2(:,i));
    posi=find(GI1==max(GI1),1);

    tempDGI=DeltaG_II(SSP(:,i),GI1,GI2);
    DGI(i)=-tempDGI(posi);
    GI1GI2(i)=GI1(posi)*GI2(posi);  
end

%figure plot
d1=plot(GI1GI2,DGI,'ko','Markersize',8);
hold on;
modelfun=@(k,x)k*x;

alpha=nlinfit([0,GI1GI2],[0,DGI],modelfun,10);
x=linspace(0,max(GI1GI2)*1.1,100);
z=alpha*x;
plot(x,z,'k','linewidth',0.5);
ylim([0,Inf]);
xlabel('g_{I1}g_{I2} (mS^2 cm^{-4})','fontsize',8);
ylabel('-\Delta g (mS cm^{-2}) ','fontsize',8);
set(gca,'FontSize',6);
box off;
