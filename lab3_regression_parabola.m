% to find a parabolic curve
clear all;
clc;
close all;
x = [1.5 3 4.5 6 8 10.5];
y = [9 28 50 90 140 250];
n = length(x);
for i=1:length(x)
    plot(x(i),y(i),'o');
    hold on
end
sx = sum(x);
sx2 = sum(x.^2);
sx3 = sum(x.^3);
sx4 = sum(x.^4);
sy = sum(y);
sxy = sum(x.*y);
sx2y = sum(x.^2.*y);
A = [n sx sx2; sx sx2 sx3; sx2 sx3 sx4];
B = [sy; sxy; sx2y];
X = inv(A)*B;  % solving the required linear equation
a = X(1);  % calculating the values of required variables
b = X(2);
c = X(3);
for i=1:100
    x1(i)=i;
    y1(i)=a+b*i+c*i*i;
end
result = [x1;y1]; % showing the required result
plot(x1,y1);
fprintf(' The equation of the curve is :  y = %f + %fx + %fx^2\n',a,b,c);