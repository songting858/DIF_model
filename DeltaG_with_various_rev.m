%first order difference scheme to compute
%excitatory conductance
function DG_E = DeltaG_with_various_rev(Voltage,ge,gi,rev)

global GL;
global Vot_Excitatory;
global dt;
global lag;
%rescale the voltage to DIF model scale level

V=(Voltage+70)/15;

Vot_Excitatory=14/3;


dvdt=[diff(V)/dt;0];

DeltaG=(dvdt+GL*V+gi.*(V+2/3)+ge.*(V-14/3))./(rev-V);

tempG_E=tsmovavg(DeltaG','s',round(lag/dt))';
DG_E(round(lag/dt):length(DeltaG))=tempG_E(round(lag/dt):length(DeltaG));