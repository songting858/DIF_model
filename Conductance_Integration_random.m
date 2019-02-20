%check the dendritic integration rule at the peak time of EPSP
%using NEURON software data 
%JUST FOR CONDUCTANCE INTEGRATION RULE

clear;
clc;

global lag;
lag=0.1;
global dt;

global GL;

%load the data from NEURON software
dat0=importdata('EIpair.dat');
%dat0=importdata('EIpair_delay.dat');

dat=dat0.data;
%timestep used in NEURON
dt=0.1;
num=30;
size=100/dt+1;

volt=dat(1:size,1:num*3);

GL=0.11;

IPSP=volt(:,1:3:end);
EPSP=volt(:,2:3:end);
SSP=volt(:,3:3:end);

for i=1:num
    if max(EPSP(:,i)>-63)  % exclude spike case
        continue;
    end
    a(i)=max(EPSP(:,i))
    b(i)=min(IPSP(:,i))
    
    GI=computeGI(IPSP(:,i));
    GE=computeGE(EPSP(:,i));
    posi=find(GE==max(GE),1);

    tempDGE=DeltaG(SSP(:,i),GE,GI);
    DGE(i)=-tempDGE(posi);
    GEGI(i)=GE(posi)*GI(posi);  
    
%     posi=find(EPSP(:,i)==max(EPSP(:,i)),1);
%     DV(i)=SSP(posi,i)-EPSP(posi,i)-IPSP(posi,i)-70;
%     VEVI(i)=(EPSP(posi,i)+70)*(IPSP(posi,i)+70);
end

% %figure plot
% figure;
% d1=plot(-VEVI,-DV,'ko','Markersize',8);
% hold on;
% modelfun=@(k,x)k*x;
% 
% alpha=nlinfit([0,-VEVI],[0,-DV],modelfun,10);
% x=linspace(0,max(-VEVI)*1.1,100);
% z=alpha*x;
% 
% plot(x,z,'k','linewidth',0.5);
% 
% xlabel('V_{E}V_{I} (mV^2)','fontsize',8);
% ylabel('\Delta V (mV) ','fontsize',8);
% set(gca,'FontSize',6);
% box off;


%figure plot
figure;
d1=plot(GEGI,DGE,'ko','Markersize',8);
hold on;
modelfun=@(k,x)k*x;

alpha=nlinfit([0,GEGI],[0,DGE],modelfun,10);
x=linspace(0,max(GEGI)*1.1,100);
z=alpha*x;

plot(x,z,'k','linewidth',0.5);

xlabel('g_{E}g_{I} (mS^2 cm^{-4})','fontsize',8);
ylabel('\Delta g (mS cm^{-2}) ','fontsize',8);
set(gca,'FontSize',6);
box off;
