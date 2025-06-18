rng('default');
warning('off','all')
x=1:0.1:20;
y=x.*sin(x)+5*rand(1,length(x))-5*rand(1,length(x));

A=polinom(x,y,10);
hold off
plot(x,y,'r*')
hold on
plot(x,polyval(A,x),'b-')