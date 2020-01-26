% simulate the effective DIF model when a neuron receives multiple inputs
close all;
clear;
clc;
tic;

global dt;
global lag;
global NE;
global NI;
global size;
global tstop;

global G_L;
global V_L;
global V_E;
global V_I;
global vrest;

%simlation time step in NEURON
dt=0.1;
%time lag of moving average
lag=0.1;

%reversal potential
V_E=0;
V_I=-80;

%passive parameters in the DIF model
vrest=-70;
G_L=0.11;  
V_L=vrest;

factor=1;
va=0;

%number of inputs
NE=15*factor;
NI=15*factor;

%simulation time
tstop=250;
time=0:dt:tstop;
size=length(time);

GE=zeros(NE,round(tstop/dt)+1);
GI=zeros(NI,round(tstop/dt)+1);

alpha_EE=zeros(NE*(NE-1)/2,1);
alpha_II=zeros(NI*(NI-1)/2,1);
alpha_EI=zeros(NE*NI,1);

%data loading from NEURON simulation result
V_TRACE=load('NEURON/target.dat');
V_TRACE=V_TRACE+vrest;

%calculate individual input condutance in the DIF model
for i = 1:NE
    GE(i,:)=computeGE(V_TRACE(i,:));
end

for j =1:NI
    GI(j,:)=computeGI(V_TRACE(NE+j,:));
end

%estimate the integration coefficients for each pair of synaptic inputs (using differential evolution method)
count=1;
for m=1:NE
    for n=m+1:NE
        alpha_EE(count)=DEalpha_EE(V_TRACE(m,:),V_TRACE(n,:),V_TRACE(NE+NI+count,:));
        close;
        count=count+1;
    end
end
    
count=1;
for m=1:NI
    for n=m+1:NI
        alpha_II(count)=DEalpha_II(V_TRACE(m+NE,:),V_TRACE(n+NE,:),V_TRACE(NE+NI+NE*(NE-1)/2+count,:));
        close;
        count=count+1;
    end
end

count=1;
for m=1:NE
    for n=1:NI
        alpha_EI(count)=DEalpha_EI(V_TRACE(m,:),V_TRACE(n+NE,:),V_TRACE(NE+NI+NE*(NE-1)/2+NI*(NI-1)/2+count,:));
     %pause;
        close;
        count=count+1;
    end
end

save alpha alpha_EE alpha_II alpha_EI

%simulate the DIF model when receiving multiple inputs
SSP_DIF=solveSSP(GE,GI,alpha_EE,alpha_II,alpha_EI);

h0=figure(3);
plot(time,V_TRACE(end,:),'-g');
hold on;
plot(time,SSP_DIF,'--b');
hold on;

%simulate the DIF model without bilinear integration when receiving multiple inputs
alpha_EE_zero=zeros(NE*(NE-1)/2,1);
alpha_II_zero=zeros(NI*(NI-1)/2,1);
alpha_EI_zero=zeros(NE*NI,1);

SSP_IF=solveSSP(GE,GI,alpha_EE_zero,alpha_II_zero,alpha_EI_zero);
plot(time,SSP_IF,'-r');
xlabel('Time(ms)');
ylabel('Voltage (mV)');
legend('NEURON','DIF','IF');

sample=20;
figure(2);
plot(V_TRACE(end,1:sample:end)-vrest,SSP_IF(1:sample:end)-vrest,'r.','Markersize',10);
hold on;
plot(V_TRACE(end,1:sample:end)-vrest,SSP_DIF(1:sample:end)-vrest,'b.','Markersize',10);
hold on;

min_v=min(V_TRACE(end,1:sample:end)-vrest);
max_v=max(V_TRACE(end,1:sample:end)-vrest);
x_y=linspace(min_v,max_v,1000);
plot(x_y,x_y,'k');
xlabel('Measured voltage (mV)');
ylabel('Predicted voltage (mV)');
legend('IF','DIF');

%noisy integration coefficients
%SSP_DIF=solveSSP(GE,GI,alpha_EE.*(1+rand(NE*(NE-1)/2,1)*va),alpha_II.*(1+rand(NI*(NI-1)/2,1)*va),alpha_EI.*(1+rand(NE*NI,1)*va));

figure(1);
subplot(2,2,1);
plot(time,V_TRACE(end,:),'b');
hold on;
plot(time,SSP_DIF,'r');
hold on;
plot(time,SSP_IF,'c');
xlabel('Time(ms)');
ylabel('Voltage (mV)');
legend('NEURON','DIF','IF');

sample=10;

subplot(2,2,2);
plot(time,V_TRACE(end,:)-SSP_DIF','r');
hold on;
plot(time,V_TRACE(end,:)-SSP_IF','c');
toc;
xlabel('Time(ms)');
ylabel('Error (mV)');
legend('DIF','IF');

subplot(2,2,3);
plot(time,V_TRACE(1:NE+NI,:)','k','Linewidth',2);
hold on;
plot(time,V_TRACE(NE+NI+1:end-1,:)','Color', [0.2 0.2 0.2])
xlabel('Time(ms)');
ylabel('Voltage trace (mV)');

subplot(2,2,4);
plot(time,GE,'r');
hold on;
plot(time,GI,'b');
xlabel('Time(ms)');
ylabel('Conductance (mS/cm^2)');
toc;
     
        
        
        