%Lotanna Ezenwa, Problem Set 2, #1
%PS2_1.m
%% Due Wednesday, April 6th, 2016
clear
me = LotaEzenwa();
code = me.id; 
PS_2_1

syms ir1 ir2 V1 V2 ic1 ic2

syms B D E F G R C
B = 5;
D = 6;
E = 6;
F = 7;
G = 2;
R = 1; %Ohm
C = 1; %Farads


V1_0 = .5; %Volts
V2_0 = -2; %Volts

syms V1 V2 p1 p2

a1 = 1/(R*C)*D*[-(E+B), E];
a2 = 1/(R*C)*F*[E, -(E+G)];
A = [a1;a2];
V = [V1;V2];

d = eig(A)';
e1 = d(1);
e2 = d(2);
tau_1 = 1/e1;
tau_2 = 1/e2;

M1 = e1*eye(2) - A;
M2 = e2*eye(2) - A;

ek1 = M1*[1;p1] ==  0;
ek2 = M2*[1;p2] ==  0;
phi1 = solve(ek1(1));
phi2 = solve(ek2(1));


EV = [1 1; phi1 phi2];
syms c1 c2

q = solve(EV*[c1;c2] == [V1_0;V2_0]);
C1 = q.c1;
C2 = q.c2;

clf 
hold on
grid on
tc = max([-tau_1 -tau_2]);
t = 0:tc/100:5*tc;
title_block = sprintf('%s - Problem Set 2, #1',me.name);

plot(t,C1*exp(e1*t) + C2*exp(e2*t));
plot(t,C1*phi1*exp(e1*t) + C2*phi2*exp(e2*t));
title(title_block);
xlabel('t, sec');
ylabel('Voltage, V');
legend('V1(t)','V2(t)');