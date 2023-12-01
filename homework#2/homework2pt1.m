global K k0 k2 k n
K = 1;
k0 = 2;
k2 = 1;
k = 0.05; %signal S growth rate
n = 1;

%Initial condition
R = 2;
S = 0;
y0 = [R, S];

tspan = [0 40]; %simulation time

[t,y] = ode45(@homeostasis_dydt,tspan,y0);
R = y(:,1);
S = y(:,2);
figure
plot(t,R,t,S)
legend('R','S')
xlabel('time')
ylabel('concentration')
b=1;

maxvalues = [];
minvalues = [];
nvalues = [1:2:9];
for n = 1:2:9
[t,y] = ode45(@homeostasis_dydt,tspan,y0);
R = y(:,1);
S = y(:,2);
maxvalues = [maxvalues, max(R)];
minvalues = [minvalues, min(R)];
end

figure
plot (R,y0,R,y1,R,y2,R,y3,R,y4,R,y5);
axis ([0 4 0 1.2])
figure
plot(t, R)
figure
plot(nvalues, minvalues, nvalues, maxvalues)
legend ('min', 'max')
xlabel('n')
ylabel('values')
index = find(t == 10);
disp(index)

% Function defining differential equations
function dydt = homeostasis_dydt(t,y)

global K k k0 k2 n

R = y(1);
S = y(2);

dR = k0*(1-R^n/(K^n+R^n)) - k2*S*R ;
dS = k ;
dydt = [dR; dS];
end

%Hill function for repressor
function out = hillR (R, b, K, n)
    out = b./(1+(R.^n)./(K.^n));
end