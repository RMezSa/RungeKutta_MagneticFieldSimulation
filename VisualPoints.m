function E = VisualPoints(x,e,n,cual)
    y = linspace(-e,e,n);
    z = linspace(-e,e,n);

    E  = [];

    for i = x
        for j = y
            for k = z
                if cual == 1
                magnitud = sqrt(i.^2+j.^2+k.^2);
                if magnitud > e 
                      E = [E; [i, j, k]];
                end
                else
                    E = [E; [i, j, k]];
            end
        end
    end
    
end