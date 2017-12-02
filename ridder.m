function [sol, it, arrsol] = ridder(f, x0, x2, t, itmax)
%RIDDER Calculate roots of a function using ridder's method
%
%   inputs : 
%   f - the function you which to find the root of
%   x0, x2 - initial guessing points where f(x0)f(x2) < 0
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
fprintf(displayfmt , it, x0, f(x0), nan, nan)


% initial base cases for optimization
f0 = f(x0);
if f0 == 0; sol = x0; return; end
f2 = f(x2);
if f2 == 0; sol = x2; return; end
if f0 * f2 > 0
    disp('Please choose x0, x2 such that f(x0) and f(x2) have different signs')
    return
end


x1 = 0.5 * (x0 + x2);

if f0 * f2 < 0
    while (abs(x1 - x0) > t || abs(x1 - x2) > t) && it <= itmax
        x1 = 0.5 * (x0 + x2);
        f1 = f(x1);
        if f1 == 0; sol = x1; return; end
        s = sqrt(f1.^2 - f0 * f2);
        
        %safeguard against division by 0
        if s == 0
            disp('Your choice of x0 and x2 with this function led to division by 0')
            break
        end
        
        dx = (x1 - x0) * f1 / s;
        
        if (f0 - f2) < 0
            dx = -dx;
        end
        
        x3 = x1 + dx;
        arrsol(end + 1) = x3;
        
        f3 = f(x3);
        if f3 == 0; sol = x3; return; end
        
        it = it + 1;
        
        fprintf(displayfmt , it, x3, f(x3), abs(x2 - x3), abs(x2 - x3) / abs(x2))
        
        if sign(f1) == sign(f3)
            if sign(f0) ~= sign(f3)
                x2 = x3;
                f2 = f3;
            else
                x0 = x3;
                f0 = f3;
            end
        else
            x0 = x1;
            x2 = x3;
            f0 = f1;
            f2 = f3;
        end
    end
end

% assigning solution if we achieved tolerance
if abs(x2 - x3) < t
    sol = x3;
end

% returning fail if we did not achieve tolerance
if abs(x2 - x3) > t
    disp('Failed to converge within the number of maximum iterations')
    return
end

disp('The root is')
disp(sol)
disp('Number of iterations taken')
disp(it)

return
end
