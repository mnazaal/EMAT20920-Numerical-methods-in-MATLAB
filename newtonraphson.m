function [sol, it, arrsol] = newtonraphson(f,df, x0, a, b, t, itmax)
%NEWTONRAPHSON Calculate roots of a function using the
% Newton-Raphson algorithm
%
%   inputs :
%   f - the function you which to find the root of
%   df - the derivative of the function
%   x0 - initial guessing point
%   a, b - bracketing intervals
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

% correcting bracketing
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
x1 = x0 - (f(x0) / df(x0));
it = 1;
arrsol(1) = x1;
fprintf(displayfmt , it, x1, f(x1), abs(x0 - x1), abs(x0 - x1)/x0)

% starting the algorithm
while abs(x0 - x1) > t && it <= itmax
    
    % handling division by zero
    if df(x0) == 0
        disp('Division by 0 at the derivative')
    return
    end
    
    % warning users of possible divergence
    if x1 < a || x1 > b
        disp('WARNING : This iteration is out of the interval range')
    end
    
    x0 = x1;
    x1 = x0 - (f(x0) / df(x0)); 
    it = it + 1;
    arrsol(end + 1) = x1;
    fprintf(displayfmt , it, x1, f(x1), abs(x0 - x1), abs(x0 - x1) / abs(x0)) 
end

% assigning solution if we achieved tolerance
if abs(x0 - x1) < t
    sol = x1;
end

% returning fail is we did not achieve tolerance
if abs(x0 - x1) > t
    disp('Failed to converge within the number of maximum iterations')
    return
end

disp('The root is')
disp(sol)
disp('Number of iterations taken')
disp(it)
return
end
