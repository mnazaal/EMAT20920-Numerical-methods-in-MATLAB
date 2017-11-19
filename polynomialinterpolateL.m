function polynomialinterpolateL(f, a, b, N)
%POLYNOMIALINTERPOLATEL Summary of this function goes here
%   Detailed explanation goes here

%correct possible bracketing swap
if a > b
    [b, a] = deal(a, b);
end

xdata = linspace(a,b,N);
ydata = f(xdata);
M = vander(xdata);
a = M\ydata';

x = linspace(min(xdata), max(xdata), N);
y = polyval(a, x);

plot(xdata,ydata,'ro', x,y)
end
