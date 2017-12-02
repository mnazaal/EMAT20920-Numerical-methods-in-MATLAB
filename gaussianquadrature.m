function [value, abserror, relerror] = gaussianquadrature(f, a, b, n)
%GUASSIANQUADRATURE calculates definite integrals based on the Gaussian quadrature algorithm
%
%   NOTE : Dependant on gaussianquadweight.m and legendrecoeff.m
%
%   inputs :
%   f - the function you wish to integrate over from a to b
%   a, b - the values over which you integrate over, where a < b
%   n - n for nth point quadrature
%
%   outputs :
%   value - value of the integral using Gaussian quadrature
%   abserror - absolute error in comparison to the actual integral
%   relerror - relative error in comparison to the actual integral

% indexing to get each term of the sum
i = 1:n;

% using the function from before to get the roots x(i) and weights w(i)
[x, w] = gaussianquadweight(n);

% function which gets the i'th term of the summation, after linear transformation from [a, b] to [-1, 1]
intg = @(i) 0.5.*(b-a).*w(i).*f((0.5.*x(i).*(b-a)) + 0.5.*(b+a));

%getting value of the sum for each i then summing them up
value = sum(intg(i));

%error calculation
actual = integral(f, a, b);
abserror = abs(value - actual);
relerror = abserror/abs(actual);

return
end
