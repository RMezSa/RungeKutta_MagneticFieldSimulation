syms t psi f
f(t, psi) = 5*sin(t) - 13*psi;

%CI
t0 = 0;
psi0 = 15;

n = 200;
tf = 20;
t = linspace(t0, tf, n);
%timestep = h
h = t(2) - t(1);

psis = zeros(length(t));
psis(1) = psi0;

for i = 1:199
    k1 = f(t(i), psis(i));
    k2 = f(t(i) + h/2, psis(i) + (h/2)*k1 );
    k3 = f(t(i) + h, psis(i) + h*k2);

    k = (k1 + 4*k2 + k3)/6;

    psis(i+1) = psis(i) + h*k;
end

plot(t, psis);