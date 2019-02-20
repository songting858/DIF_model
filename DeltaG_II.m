%first order difference scheme to compute
%excitatory conductance
function DG_I = DeltaG_II(Voltage,gi1,gi2)

global GL;
global Vot_Inhibitory;
global dt;
global lag;
%rescale the voltage to DIF model scale level

V=(Voltage+70)/15;

Vot_Inhibitory=-2/3;


dvdt=[diff(V)/dt;0];

DeltaG=(dvdt+GL*V+gi1.*(V+2/3)+gi2.*(V+2/3))./(Vot_Inhibitory-V);

tempG_I=tsmovavg(DeltaG','s',round(lag/dt))';
DG_I(round(lag/dt):length(DeltaG))=tempG_I(round(lag/dt):length(DeltaG));