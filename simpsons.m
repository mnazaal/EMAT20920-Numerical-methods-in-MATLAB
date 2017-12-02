function [value, abserror, relerror] = simpsons(f, a, b, n)
%SIMPSONS calculates definite integrals based on Simpsons rule with 
% composite Newton-Cotes rules
%
%   inputs :
%   f - the function you wish to integrate over from a to b
%   a, b - the values over which you integrate over, where a < b
%   n - n for the datapoints, must be even
%
%   outputs :
%   value - value of the integral using Gaussian quadrature
%   abserror - absolute error in comparison to the actual integral
%   relerror - relative error in comparison to the actual integral

h = (b - a) / n;
oddi = [1 : 2 : n - 1];
eveni = [2 : 2 : n - 1];

% function which gets the i'th term of the summation
terms = @ (i) f(a + i .* h);

% calculating the value by mapping the function to odd values and 
% even values separately, then adding everything together
value = (h/3) * ( f(a) + 4 * sum(terms(oddi)) + 2 * sum(terms(eveni)) + f(b));

%error calculation
actual = integral(f, a, b);
abserror = abs(value - actual);
relerror = abserror/abs(actual);

return
end
