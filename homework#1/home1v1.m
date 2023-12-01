% Ultrasensitivity example with one kinase-phosphatase switch

% Define constants
global kcat KM k
kcat = 100;
KM = 0.25;
k = 0.1;

% Simulation time 
tspan = [0 20];

% Initial conditions
PS1 = 0;
PS2 = 0;
E = 0;
y0 = [PS1, PS2, E];

% Run simulation
[t,y] = ode45(@US1_dydt,tspan,y0) ;

% Plot results
figure(1)
plot(t,y);
ylim([0,1.2]);
legend('Without Positive Feedback', 'With Positive Feedback', 'Kinase', 'location', 'east');

function dydt = US1_dydt(t,y)

global kcat KM k

PS1 = y(1);
PS2 = y(2);
E = y(3);

dPS1 = E*kcat*(1-PS1)/(KM+(1-PS1)) - kcat*PS1/(KM+PS1);
dPS2 = kcat*(E+PS2)*(1-PS2)/(KM+(1-PS2))-kcat*PS2/(KM+PS2);
dE = k ;

dydt = [dPS1; dPS2; dE];
end