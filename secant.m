function [sol, it] = secant(f, x0, x1, a, b, t, itmax)
%SECANT Summary of this function goes here
%   Detailed explanation goes here
it = 1;

%display formatting
displayfmt = '%3d  %20.10f  %20.10f  %20.10f  %20.10f  \n' ;
disp('__________________________________________________________________________________________')
disp(' n             xn                 f(xn)                abs error                 rel error ')  
disp('__________________________________________________________________________________________')
fprintf(displayfmt , 0 , x0, f(x0), nan, nan) 


%correct possible bracketing swap
if a > b
    [b, a] = deal(a, b);
end

%handling incorrect bracketing
if a == b
    disp('An interval [a, b] is valid if |a - b| > 0')S
    return
end

%handling incorrect values of t and itmax
if t < 0 || itmax < 0
    disp('Tolerance and number of maximum iterations must be positive')
    return
end

%safeguard to protect from divergence
if x0 < a || x0 > b
    disp('WARNING : Initial guess x0 is outside the interval at beginning')
end

%calculating and printing the first values
x2 = (f(x1).*x0 - f(x0).*x1)./(f(x1) - f(x0));

while abs(x0 - x1) > t && it <= itmax
    %protection against division by zero
    if f(x1) == f(x0)
        disp('Division by 0 at the denominator')
    return
    end
    
    %warning users of possible divergence
    if x2 < a || x2 > b
        disp('WARNING : This iteration is out of the interval range')
    end
    
    x0 = x1;
    x1 = x2;
    
    f0 = f(x0);
    if f0 == 0
        sol = x0;
        return
    end
    
    f1 = f(x1);
    if f1 == 0
        sol = x1;
        return
    end
    
    x2 = (f1.*x0 - f0.*x1)./(f1 - f0);
    it = it + 1;
    fprintf(displayfmt , it, x2, f(x2), abs(x2 - x1), abs(x2 - x1) / abs(x1)) 
end

%assigning solution if we achieved tolerance
if abs(x2 - x1) < t
    sol = x1;
end

%returning fail is we did not achieve tolerance
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
