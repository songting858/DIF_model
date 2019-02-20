%process data generated from IF_pas_parameter_measure.hoc
%to estimate the effective surface area and leak condutance
%given the neuron a constant current injection at soma for the first 500ms

close all;
clear;
clc;

data=load('pas_parameter.dat');
dt=0.1;
gl_default=0.11;  %determined by eyeball normal :) unit ms/cm2

data=data+70; %shift the resting potential from -70mV to 0mV

tstop=1000;

c='rgbmc';
t=0:dt:tstop;

for j=1:5
    
    I=0.015*j*10^-3;  %unit transfered from nA to muA
    v=data(j,1:end-1);
    
    subplot(2,1,1);
    hold on;
    plot(t,v,c(j));

    v_inf=v(tstop/dt/2);
    dif_v=diff(v(tstop/dt/2:tstop/dt))/dt;
    dif_v=tsmovavg(dif_v,'s',round(0.5/dt));

    v_decay=v(tstop/dt/2:tstop/dt-1);
    half_t=(0:length(v_decay)-1)*dt+500;
    log_v=log(v_decay);
        
    subplot(2,1,2);
    hold on;
    plot(half_t,log_v,c(j));
    
    S(j)=I/v_inf/gl_default;  %effective surface area; unit cm2

end

disp(mean(S));

subplot(2,1,1);
legend('2pA','4pA','6pA','8pA','10pA');
xlabel('Time (ms)','Fontsize',16);
ylabel('Voltage (mV)','Fontsize',16);
set(gca,'Fontsize',16);


subplot(2,1,2);
hold on;
x=linspace(500,600,10000);
plot(x,-gl_default*x+52,'--k');
xlim([500,530]);
legend('2pA','4pA','6pA','8pA','10pA');
set(gca,'Fontsize',16);
xlabel('time (ms)','Fontsize',16);
ylabel('Log Voltage','Fontsize',16);