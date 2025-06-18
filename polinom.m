function p = polinom(x,y,np)

if length(x) ~= length(y)
    p = NaN;
    return;
end
if np < 1
    p = NaN;
    return;
end

if np > length(x)
    p = NaN;
    return;
end

n = length(x);

m = zeros(np+1, np+1); 
R = zeros(np+1, 1);  


m(1,1) = n;


for i = 1:np+1
    for j = 1:np+1
        
        if (i ==  1 && j ==  1)
            
        else
            m(i,j) = sum(x.^(i+j-2)); 

           % fprintf('%d %d %d\n', i, j, (i+j-2));
        end
    end

        s = i-2;
            R(i) = sum(x.^s.*y);
            %fprintf('%d %d\n', i, (i-1));

end
coef = m\R;

disp(flipud(coef));
p = flipud(coef);

end