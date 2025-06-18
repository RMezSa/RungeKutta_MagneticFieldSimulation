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
    
    %Vectorizacion de linea evluada en los valores de t
    lx_vec = double(subs(lx, t, t_vals));
    ly_vec = double(subs(ly, t, t_vals));
    lz_vec = double(subs(lz, t, t_vals));


    % Matriz repetida con varios l_vecs
    % Agarra un vector y lo repite hacia abajo varias veces
    lx_mat = repmat(lx_vec,[f1,1]);
    ly_mat = repmat(ly_vec,[f1,1]);
    lz_mat = repmat(lz_vec,[f1,1]);

    % Matriz repetida con los cvecs, igual que l_mat
    cx_mat = repmat(cx_vec,[f1,1]);
    cy_mat = repmat(cy_vec,[f1,1]);
    cz_mat = repmat(cz_vec,[f1,1]);

% Componentes de los Visual Points
    VPx = VP(:,1);
    VPy = VP(:,2);
    VPz = VP(:,3);

% Calculando las diferencias entre cada visual point y cada punto de l
%Simula un doble for
    rx = bsxfun(@minus, VPx, lx_vec);
    ry = bsxfun(@minus, VPy, ly_vec);
    rz = bsxfun(@minus, VPz, lz_vec);

    %norma de los r
    norma = sqrt(rx.^2 + ry.^2+rz.^2);
    norma3 = norma.^3;

    %producto cruz 
    Cx = (cy_mat .* rz) - (cz_mat .* ry);
    Cy = -1*(cx_mat .* rz - cz_mat .* rx);
    Cz = cx_mat .* ry - cy_mat .* rx; 

    %Contenido de la integral
    ContenidoIntegralx = Cx./norma3;
    ContenidoIntegraly = Cy./norma3;
    ContenidoIntegralz = Cz./norma3;

    
    Campo(:,1) = sum(ContenidoIntegralx,2);
    Campo(:,2) = sum(ContenidoIntegraly,2);
    Campo(:,3) = sum(ContenidoIntegralz,2);
    
    %Coeficiente de permeabilidad del vacio dividido sobre 4*pi
    M0 = 1e-7;
    %Current
    I = 5515;
    Campo = Campo * M0 * I;
    BS = Campo;
end