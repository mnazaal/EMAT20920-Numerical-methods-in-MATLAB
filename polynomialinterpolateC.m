function polynomialinterpolateC(f, a, b, N)
%POLYNOMIALINTERPOLATEC Summary of this function goes here
%   Detailed explanation goes here

%correct possible bracketing swap
if a > b
    [b, a] = deal(a, b);
end

xdata = zeros(1,N);

for i = 1:N
    xdata(1,i) = 0.5.*(a + b) + 0.5.*(b-a).*cos(((2 .* i - 1) .* pi) ./ (2 .* i));
end

ydata = f(xdata);
M = vander(xdata);
a = M\ydata';

x = linspace(min(xdata), max(xdata), N);
y = polyval(a, x);

plot(xdata,ydata,'ro', x,y)
end

