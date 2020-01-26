%first order difference scheme to compute
%inhibitory conductance
function G_I = computeGI(Voltage)

global G_L;
global Vot_Inhibitory;
global dt;
global lag;

%rescale the voltage to DIF model scale level
V=(Voltage+70)/15;

Vot_Inhibitory=-2/3;


dvdt=[diff(V)/dt,0];

G_I=(dvdt+G_L*V)./(Vot_Inhibitory-V);

% tempG_I=tsmovavg(G_I','s',round(lag/dt))';
% G_I((lag/dt):length(G_I))=tempG_I((lag/dt):length(G_I));