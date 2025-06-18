function PP = PosParticulas(n)
    x = linspace(-2,2,n);
    y = linspace(-2,2,n);
    z = linspace(-2,2,n);

    PP  = [];

    for i = x
        for j = y
            for k = z
               PP = [PP; [i, j, k]];
            end
        end
    end
    
end