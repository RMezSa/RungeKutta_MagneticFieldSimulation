function [coordenadasPi, velocidadi, aceleracioni] = RungeKutta(posicion, velocidad, aceleracion, timestep, CM, q, m)


k1x = timestep * velocidad;
k1v = timestep * aceleracion;

k2x = timestep * (velocidad + k1v / 2);
k2v = timestep * (aceleracion + (1/m)*q*(cross(velocidad + k1v/2, CM)));

k3x = timestep * (velocidad + k2v / 2);
k3v = timestep * (aceleracion + (1/m)*q*(cross(velocidad + k2v/2, CM)));

k4x = timestep * (velocidad + k3v);
k4v = timestep * (aceleracion + (1/m)*q*(cross(velocidad + k3v, CM)));

Kx = (k1x + 2*k2x + 2*k3x + k4x)/6;
Kv = (k1v + 2*k2v + 2*k3v + k4v)/6;

coordenadasPi = posicion + Kx;
velocidadi = velocidad + Kv;
aceleracioni = (1/m)*q*(cross(velocidadi, CM));
return ;
end