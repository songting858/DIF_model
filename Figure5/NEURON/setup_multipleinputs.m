% generate the input locations for the multiple inputs integration 

t_end=200;
factor=1;

NE=15*factor;
NI=15*factor;

E_location=[7,11,19,24,31,35,39,42,48,55,65,71,73,76,78];
E_loc=[];

for i = 1:factor
    E_loc=[E_loc,E_location];
end

%I_location= [40,44,50,66,72,74];
I_location = E_location-1;
I_location(end)=58;

I_loc=[];

for i = 1:factor
    I_loc=[I_loc,I_location];
end

if length(E_loc)~=NE
   disp('excitatory input location number is incorrect!');
    return;
end

if length(I_loc)~=NI
   disp('inhibitory input location number is incorrect!');
    return;
end

Loc_list=[E_loc';I_loc'];

%T_list=rand(NE+NI,1)*t_end;

%T_list=ones(NE+NI,1)*50;
T_list=[linspace(0,200,NE),linspace(0,200,NI)];
list=[Loc_list;T_list'];
save source.dat list -ascii

    