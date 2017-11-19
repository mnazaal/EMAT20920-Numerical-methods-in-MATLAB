function [sol, it, n] = ridder(f, x0, x2, t, itmax)
%RIDDLER Summary of this function goes here
%   Detailed explanation goes here
it = 1;
n = [];

%display formatting
displayfmt = '%3d  %20.10f  %20.10f  %20.10f  %20.10f  \n' ;
disp('__________________________________________________________________________________________')
disp(' n             xn                 f(xn)                abs error                 rel error ')  
disp('__________________________________________________________________________________________')
fprintf(displayfmt , it, x0, f(x0), nan, nan)

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
            disp('Division by 0 incoming')
            break
        end
        
        dx = (x1 - x0) * f1 / s;
        
        if (f0 - f2) < 0
            dx = -dx;
        end
        
        x3 = x1 + dx;
        f3 = f(x3);
        if f3 == 0; sol = x3; return; end
        it = it + 1;
        n(end + 1) = abs(x2 - x3);
        
        
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

%assigning solution if we achieved tolerance
if abs(x2 - x3) < t
    sol = x3;
end

%returning fail is we did not achieve tolerance
if abs(x2 - x3) > t
    disp('Failed to converge within the number of maximum iterations')
    return
end

end
