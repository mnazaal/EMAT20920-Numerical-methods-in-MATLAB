function [sol, it, arrsol] = secant(f, x0, x1, a, b, t, itmax)
%SECANT Calculate roots of a function using the secant method algorithm
%
%   inputs : 
%   f - the function you which to find the root of
%   x0, x1 - initial guessing points 
%   a, b - intervals where we assume the root is, to protect from divergence
%   t - tolerance value
%   itmax - maximum number of iterations to pursue
%
%   outputs :
%   sol - the root of the function
%   it - number of iterations taken to find the root at the given tolerance
%   arrsol - array of approximations, helpful to find error 

it = 0;
arrsol = [];
% Note : We cannot assign memory for arrsol beforehand since we do not know how many iterations we need

% display formatting
displayfmt = '%3d  %20.10f  %20.10f  %20.10f  %20.10f  \n' ;
disp('__________________________________________________________ ________________________________')
disp(' n             xn                 f(xn)                abs error                 rel error ')  
disp('__________________________________________________________ ________________________________')
fprintf(displayfmt , 0 , x0, f(x0), nan, nan) 

%correct possible bracketing swap
if a > b
    [b, a] = deal(a, b);
end

% handling incorrect bracketing
if a == b
    disp('An interval values for a, b is valid if |a - b| > 0')
    return
end

% handling incorrect values of t and itmax
if t < 0 || itmax < 0
    disp('Tolerance and number of maximum iterations must be positive')
    return
end

% safeguard to protect from divergence
if x0 < a || x0 > b
    disp('WARNING : Initial guess x0 is outside the interval [a, b]')
end

% calculating and printing the first values
% Note - this is our first iteration
x2 = (f(x1).*x0 - f(x0).*x1)./(f(x1) - f(x0));
it = 1;
arrsol(1) = x2;
fprintf(displayfmt , it, x2, f(x2), abs(x2 - x1), abs(x2 - x1) / abs(x1)) 


while abs(x0 - x1) > t && it <= itmax
    % protection against division by zero
    if f(x1) == f(x0)
        disp('Division by 0 at the denominator')
    return
    end
    
    % warning users of possible divergence
    if x2 < a || x2 > b
        disp('WARNING : This iteration is out of the interval range')
    end
    
    x0 = x1;
    x1 = x2;
    
    f0 = f(x0);
    if f0 == 0; sol = x0; return; end
    
    f1 = f(x1);
    if f1 == 0; sol = x1; return; end
    
    x2 = (f1.*x0 - f0.*x1)./(f1 - f0);
    it = it + 1;
    arrsol(end + 1) = x2;
    fprintf(displayfmt , it, x2, f(x2), abs(x2 - x1), abs(x2 - x1) / abs(x1)) 
end

% assigning solution if we achieved tolerance
if abs(x2 - x1) < t
    sol = x1;
end

% returning fail is we did not achieve tolerance
if abs(x2 - x1) > t
    disp('Failed to converge within the number of maximum iterations')
    return
end

disp('The root is')
disp(sol)
disp('Number of iterations taken')
disp(it)

return
end
