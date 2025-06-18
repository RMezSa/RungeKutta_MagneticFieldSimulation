function BS = BiotSavart(lx,ly,lz, t_vals,  VP)

[f1, ~, ~]  = size(VP);

%Vector para guardar campo
Campo = zeros(f1,3);

%Derivadas en cada componente de la funcion
    syms t;
    dfx = diff(lx, t);
    dfy= diff(ly, t);
    dfz= diff(lz, t);

    %obtener size de el linspace de t
    [~, s]  = size(t_vals);

    %Vector para guardar el contenido de la integral
    C_Integral = zeros(s, 3);

    %Vectorizacion de los valores de la derivada evaluada en t de la linea 
    cx_vec = double(subs(diff(lx, t), t, t_vals));
    cy_vec = double(subs(diff(ly, t), t, t_vals));
    cz_vec = double(subs(diff(lz, t), t, t_vals));
    
    %Vectorizacion de linea y los evluada en los valores de t
    lx_vec = double(subs(lx, t, t_vals));
    ly_vec = double(subs(ly, t, t_vals));
    lz_vec = double(subs(lz, t, t_vals));

rr = [];

for i = 1:f1
    for j = 1:s

        %Sacando vector r de biot savart
        rx = VP(i,1) - lx_vec(j);
        ry = VP(i,2) - ly_vec(j);
        rz = VP(i,3) - lz_vec(j);

        

        %Norma de r
        norma = norm([rx, ry, rz]);

        

        %vector con la derivada segun j, dl/dt en biot savart
        vc = [cx_vec(j), cy_vec(j), cz_vec(j)];

        
        %vector con r
        rc = [rx ry rz];
 
        %producto cruz 
        C = cross(vc, rc);

        fprintf("%d %d %d -x- %d %d %d \n ", vc(1), vc(2),vc(3), rc(1), rc(2), rc(3));
        Cx = C(:,3);
        rr = [rr; rz];

        %Contenido de la integral
        ContenidoIntegral = C/norma^3;

        %Guardado en un vector
        C_Integral(j, :) = ContenidoIntegral;

        %Sumar los campos magneticos que se sufren por cada uno de los
        %puntos de la funcion
        Campo(i,1) = Campo(i,1) + C_Integral(j, 1);
        Campo(i,2) = Campo(i,2) + C_Integral(j, 2);
        Campo(i,3) = Campo(i,3) + C_Integral(j, 3);
        
    end
end
    %Coeficiente de permeabilidad del vacio dividido sobre 4*pi
    M0 = 1e-7;
    %Current
    I = 5515;
    Campo = Campo * M0 * I;
    %disp("Imprime campo magnetico");
    %disp(norm([Campo(1,1), Campo(1,2), Campo(1,3) ]));
    BS = Campo;
end