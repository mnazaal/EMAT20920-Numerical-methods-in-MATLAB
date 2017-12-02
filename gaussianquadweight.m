function [x, w] = gaussianquadweight(n)
%GAUSSIANQUADWEIGHT Calculates the roots of the nth Legendre polynomial and
% the weight for the Gaussian quadrature
%
%   NOTE : dependant on legendrecoeff.m
%
%   inputs :
%   n - the order of the Legendre polynomial
%
%   outputs :
%   r = roots of the nth order Legendre polynomial
%   w = respective weights

poly = legendrecoeff(n);
x = roots(poly)';

% assigning weights
wi = @(i) ( 2 .* (1 - x(i).^2) ) ./ ( ((n + 1).^2).*(legendreP(n+1,x(i)).^2) );
w = wi(1:n);

displayfmt = '%3d  %20.10f  %20.10f \n' ;
disp('_____________________________________________________')
disp(' k                 x_k                    wk         ')  
disp('_____________________________________________________')

for i = 1:n
    fprintf(displayfmt, i, x(i), w(i))
end

return
end
