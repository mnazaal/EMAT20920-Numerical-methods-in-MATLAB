function [polyl, polyc] = barycentric(f, a, b, N)
%BARYCENTRIC Implement the barycentric formula to find the Lagrange interpolating polynomials
% for both linearly spaced points and Chebyshev points
%   inputs :
%   f - the function to want to interpolate
%   a, b - the interval where you interpolate over
%   N - the number of points you interpolate over
%
%   outputs :  
%   polyl - the function handle of the Lagrange interpolating polynomial over linearly spaced points
%   polyc - the function handle of the Lagrange interpolating polynomial over Chebyshev points


%correct possible bracketing swap
if a > b
    [b, a] = deal(a, b);
end

%linearly spaced points
xdatalinear = linspace(a,b,N);

% chebyshev point assignment function
chebyshevpoint = @(i) 0.5.*(a + b) + 0.5.*(b - a).*cos(pi.*((2.*i - 1) ./ (2 .* N)));

% creating the chebyshev points
xdatachebyshev = chebyshevpoint(1:N);

% y values for linearly spaced points
ydatalinear = f(xdatalinear);

% y values for Chebyshev points
ydatachebyshev = f(xdatachebyshev);


% symbolic variable for Lagrange interpolating polynomial
syms x;


% w values for linearly spaced points
wlinear = @(i) ((-1)^(i - 1)) * (nchoosek((N - 1), (i - 1)));

% w values for chebyshev points
wchebyshev = @(i) ((-1)^(i - 1)) * sin(pi * ((2*i - 1) / (2*N)));


% alinear refers to numerator of Lagrange interpolating polynomial for linearly spaced points
alinear = 0;

% blinear refers to denominator of Lagrange interpolating polynomial for linearly spaced points
blinear = 0;

% achebyshev refers to numerator of Lagrange interpolating polynomial for Chebyshev points
achebyshev = 0;

% bchebyshev refers to denominator of Lagrange interpolating polynomial for Chebyshev points
bchebyshev = 0;


% construct Lagrange interpolating polynomial for linearly spaced points. Note that x is a symbolic variable hence alinear and blinear are symbolic functions
for i = 1:N
    alinear = alinear + ((wlinear(i) * ydatalinear(i)) / (x - xdatalinear(i)) );
    blinear = blinear + (wlinear(i) / (x - xdatalinear(i)));
end

plinear = alinear / blinear;


% construct Lagrange interpolating polynomials for Chebyshev points. Note that x is a symbolic variable hence achebyshev and bchebyshev are symbolic functions
for i = 1:N
    achebyshev = achebyshev + ((wchebyshev(i) * ydatachebyshev(i)) / (x - xdatachebyshev(i)) );
    bchebyshev = bchebyshev + (wchebyshev(i) / (x - xdatachebyshev(i)));
end

pchebyshev = achebyshev / bchebyshev;


% assign Lagrange interpolating polynomials to function output after making them MATLAB function handles with matlabFunction
polyl = matlabFunction(plinear);
polyc = matlabFunction(pchebyshev);

% x values for plotting purpose
xplot = linspace(a,b, 7*N);

%remove values from xdatalinear and/or xdatachebyshev as they result in division by zero
xplot(ismember(xplot, xdatalinear)) = [];
xplot(ismember(xplot, xdatachebyshev)) = [];

% y values of the real function
yreal = f(xplot);

% ------ plot function order of arguments ------
% first is the Lagrange interpolating polynomial from linearly spaced 
% points with the (x,y) points as o's and the graph in blue
% then the Lagrange interpolating polynomial from Chebyshev points 
% with the (x,y) points as x's and the graph in magenta and
% then the real function in red dashed lines
plot(xplot, polyl(xplot), 'b' , xdatalinear, ydatalinear, 'o', xplot, polyc(xplot), 'm-.', xdatachebyshev, ydatachebyshev, 'mx', xplot, yreal, 'r--', 'LineWidth', 1.5)
grid on;
legend('Linearly spaced points', '', 'Chebyshev points','', 'Actual function')
return

end
