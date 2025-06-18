syms t S I R

g = .009; %gamma
b = .007; %beta

S0 = 400; %Initial susceptible people
I0 = 5; %Initial infected people
R0 = 0; %Initial recovered people

fS(I,S) = -b*I*S;
fI(I,S) = -g*I+b*I*S;
fR(I,S) = g*I;

n = 100;
%Time is 500
h = 500/(n-1);
t = linspace(0,500, n);

Ss = 0*t;
Is = 0*t;
Rs = 0*t;

Rs(1) = R0;
Is(1) = I0;
Ss(1) = S0;

for i = 1:n-1
    %We need k1, k2 and k3 for every variable

    k1R = double(fR(Is(i), Ss(i)));
    k1I = double(fI(Is(i), Ss(i)));
    k1S = double(fS(Is(i), Ss(i)));


    k2R = double(fR(Is(i) + (h/2)*k1I, Ss(i) + (h/2)*k1S));
    k2I = double(fI(Is(i) + (h/2)*k1I, Ss(i) + (h/2)*k1S));
    k2S = double(fS(Is(i) + (h/2)*k1I, Ss(i) + (h/2)*k1S));

    k3R = double(fR(Is(i) + h*k2I, Ss(i) + h*k2S));
    k3I = double(fI(Is(i) + h*k2I, Ss(i) + h*k2S));
    k3S = double(fS(Is(i) + h*k2I, Ss(i) + h*k2S));
    
    k1R = (k1R + 4*k2R + k3R)/6;
    k1I = (k1I + 4*k2I + k3I)/6;
    k1S = (k1S + 4*k2S + k3S)/6;
    
    Rs(i+1) = Rs(i) + h*k1R;
    Is(i+1) = Is(i) + h*k1I;
    Ss(i+1) = Ss(i) + h*k1S;
    

end
hold on;
plot(t,Rs);
plot(t, Is);
plot(t, Ss);



