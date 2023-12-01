global a b b1 b2 K n
a = 1;
b = 4;
b1 = 1;
b2 = 2;
K = 2;
n = 6;

tspan = [0,10];

R0 = 2.1;
S = 1.5;
y0 = [R0;S];

[t1,X1] = ode45(@autoregulation_pos, tspan,y0);
R0 = y(:,1);
S = y(:,2);

R = linspace(0,2);
production = b1+b2.*R.^n./((R.^n+K.^n));
removal = a.*R;

figure
plot(R,production,R,removal);
legend('production','removal')

function dxdt = autoregulation_pos(t,R)
    global a b1 b2 K n
    dxdt = b1+b2.R.^n/((R.^n+K.^n))-a.R;
end