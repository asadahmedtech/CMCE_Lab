clear all;
clc;
close all;
x = [1 2 3 4 5 6 7];
y = [0.5 2.5 2 4 3.5 6 5.5];
n = length(x);
if length(y)~=n, error ('x and y must be of same length'); end

x = x(:); %converting to column vector
y = y(:);
sx = sum(x);
sy = sum(y);
sx2 = sum (x.*x);
sy2 = sum(y.*y);
sxy = sum(x.*y);
a(1) = (n*sxy -sx*sy)/(n*sx2 - sx^2);
a(2) = sy/n-a(1)*sx/n;
r2 = ((n*sxy - sx*sy)/sqrt(n*sx2 - sx^2)/sqrt(n*sy2 - sy^2))^2;
xp = linspace(min(x), max(x),2);
yp = a(1)*xp + a(2);
plot (x,y,'o',xp,yp)
legend ('Data points' , 'Estimate curve')
grid on
fprintf ('Equation is y = %f x + %f\n' , a(1), a(2));