%first order difference scheme to compute
%excitatory conductance
function G_E = computeGE(Voltage)

global GL;
global Vot_Excitatory;
global dt;
global lag;
%rescale the voltage to DIF model scale level

V=(Voltage+70)/15;

Vot_Excitatory=14/3;

dvdt=[diff(V)/dt;0];

G_E=(dvdt+GL*V)./(Vot_Excitatory-V);

%do regularization
tempG_E=tsmovavg(G_E','s',round(lag/dt))';
G_E(round(lag/dt):length(G_E))=tempG_E(round(lag/dt):length(G_E));