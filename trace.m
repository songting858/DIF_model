%plot synaptic potentials and currents 

clear;
clc;
close all;

global lag;
lag=0.1;
global dt;

global GL;

%load the data from NEURON software
vol=importdata('traceEI.dat');

%timestep used in NEURON
dt=0.1;
size=100/dt+1;
t=0:dt:100;

GL=0.11;

EPSP=vol(1,:)';
IPSP=vol(2,:)';
SSP=vol(3,:)';

figure(1);
plot(t,EPSP,'b');
hold on;
plot(t,IPSP,'r');
hold on;
plot(t,SSP,'g');
xlabel('Time (ms)');
ylabel('Voltage (mV)');

GI=computeGI(IPSP);
GE=computeGE(EPSP);

dvdt=[diff(SSP)/dt;0];
SSC=dvdt+GL*(SSP+70);
EPSC=-GE.*(SSP-0);
IPSC=-GI.*(SSP+80);

figure(2);
plot(t,EPSC,'b');
hold on;
plot(t,IPSC,'r');
xlabel('Time (ms)');
ylabel('Current (uA/cm^{2})');

figure(3);
plot(t,EPSC+IPSC,'m');
hold on;
plot(t,SSC,'g');
hold on;
plot(t,SSC-(EPSC+IPSC),'c');
xlabel('Time (ms)');
ylabel('Current (uA/cm^{2})');