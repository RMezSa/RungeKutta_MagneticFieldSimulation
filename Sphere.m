%Simulacion de la esfera
tic;

syms t
rC = 3486000;

x = cos(50*t) * cos(t) * rC;
y = sin(50*t) * cos(t) * rC;
z = sin(t) * rC;

t_vals = linspace(-pi/2, pi/2, 500);

x_v = double(subs(x, t, t_vals));
y_v = double(subs(y, t, t_vals));
z_v = double(subs(z, t, t_vals));

%Posiciones de la esfera en un vector
PosSphere = [x_v; y_v; z_v]';

%Graficar esfera
plot3(x_v, y_v, z_v);
hold on;

%Plot de la tierra
radio = 6371000;
[a,b,c] = sphere;
a = a*radio;
b = b*radio;
c = c*radio;
surf(a,b,c, 'FaceAlpha', .1, 'FaceColor','b');
axis equal;

%Posiciones de las particulas
e = radio + 3000000;
%324 particulas
n = 18;
xc1 = linspace(-e,e,n);
VP = VisualPoints(xc1,e,n, 1);
%plot3(VP(:,1),VP(:,2),VP(:,3),'o');

%Hacer biot savart
B1 = BiotSavart(x,y,z, t_vals, VP);

%ST = [6378000 0 0];
%Comprobar campo magnetico en la superficie
%B1 =BiotSavart(x,y,z, t_vals, ST);

%Escalar los valores para que se vean
Escala = 1e13;
Bquiver = B1*Escala;

%Plotear campo magnetico
PF = PlotCampo(Bquiver, VP);

%RK4
%posiciones iniciales
cx = -15000000;
rango = 9000000;
coordenadasP = VisualPoints(cx,rango,n, 2);
plot3(coordenadasP(:,1),coordenadasP(:,2),coordenadasP(:,3),'.');
[np, mp] = size(coordenadasP);

%Velocidad inicial
velocidad = zeros(np,3);
velocidad(:,1) = 2.3e8;

%Aceleracion inicial
[fv, cv] = size(velocidad);
aceleracion = zeros(fv,3);

%Parametros
hold on;
tf = .065;
timestep = .003;

q = 1.602e-19;
AvogadroModif = (6.022e2)/2;
m = 9.109e-31*AvogadroModif;

for i = 0:timestep:tf
 %Calculandolo afuera, ya que la precision ganada al calcularlo para cada k
 %es minima y el costo computacional demasiado
CM = BiotSavart(x,y,z, t_vals, coordenadasP);

[coordenadasP, velocidad, aceleracion] = RungeKutta(coordenadasP, velocidad, aceleracion, timestep, CM, q, m);
scatter3(coordenadasP(:,1), coordenadasP(:,2), coordenadasP(:,3), 'b.', 'MarkerFaceAlpha', 0.1);
drawnow;
end

tiempo = toc;
disp(tiempo);