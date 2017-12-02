function [polyl, polyc] = polynomialinterpolate(f, a, b, N)
%POLYNOMIALINTERPOLATE Calculates and plots polynomial interpolation of a function within an interval with linearly spaced points and Chebyshev points
%
%   inputs :
%   f - the function you want to use polynomial interpolation on
%   a, b - the interval over which you are interpolating
%   N - the number of points we divide the interval into
%   outputs :
%   polyl = function handle for polynomial vector containing the interpolating polynomial calculated using linearly spaced points
%   polyc = function handle for polynomial vector containing the interpolating polynomial calculated using Chebyshev points

% correct possible bracketing swap
if a > b
    [b, a] = deal(a, b);
end

% for linearly spaced points 
xdatalinear = linspace(a,b,N);
ydatalinear = f(xdatalinear);
Ml = vander(xdatalinear);
polyl = Ml\ydatalinear';
yl = polyval(polyl, xdatalinear);

% for Chebyshev points
chebyshevpoint = @(i) 0.5.*(a + b) + 0.5.*(b - a).*cos(pi.*((2.*i - 1) ./ (2 .* N)));
xdatachebyshev = chebyshevpoint(1:N);
ydatachebyshev = f(xdatachebyshev);
Mc = vander(xdatachebyshev);
polyc = Mc\ydatachebyshev';
yc = polyval(polyc, xdatachebyshev);

% to plot the real function
xreal = linspace(a, b, 5*N);
yreal = f(xreal);

% ------ plot function order of arguments ------
% first is the Lagrange interpolating polynomial from linearly spaced 
% points with the (x,y) points as o's and the graph in blue
% then the Lagrange interpolating polynomial from Chebyshev points 
% with the (x,y) points as x's and the graph in magenta and
% then the real function in red dashed lines
plot(xdatalinear, yl, 'b' , xdatalinear, ydatalinear, 'o', xdatachebyshev, yc, 'm-.', xdatachebyshev, ydatachebyshev, 'mx', xreal, yreal, 'r--', 'LineWidth', 1.5);
grid on;
legend('Linearly spaced points', '', 'Chebyshev points','', 'Actual function')

return
end
