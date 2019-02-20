% Test the goodness of fitting for the parameters surface area and leak
% conductance by comparing the predicted voltage trace using point neuron 
%models and the real voltage trace 

close all;
clear;
clc;

data=load('pas_parameter.dat');
dt=0.1; 
gl=0.11; %estimated in pas_parameter_measure.m  -- unit ms/cm2
S=1.3135e-4;  %estimated in pas_parameter_measure.m -- unit cm2

data=data+70;

tstop=1000;

c='rgbmc';
t=0:dt:tstop;

v_pre(1)=0; %predicted voltage

for j=1:5
    I=0.015*j*10^-3;  %current amplitude set up in pas_parameter_measure.hoc --- unit muA
    v=data(j,1:end-1);
    plot(t,v,c(j));
    
    %current clamp presence period
    for i =1:500/dt
        v_pre(i+1)=v_pre(i)-(gl*v_pre(i)-I/S)*dt;
    end
    
    %current clamp absence period
    for i = 500/dt+1:1000/dt
        v_pre(i+1)=v_pre(i)-gl*v_pre(i)*dt;
    end
    hold on;
    plot(t(1:100:end),v_pre(1:100:end),['o',c(j)]);
end

xlabel('Time (ms)','Fontsize',16);
ylabel('Voltage (mV)','Fontsize',16);
set(gca,'Fontsize',16);

    


    
    
    
    
    
    