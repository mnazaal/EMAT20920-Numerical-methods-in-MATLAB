function p = legendrecoeff(n)
%LEGENDRECOEFF Calculates the coefficients of the nth order Legendre polynomial
% input : 
% n - the order of the Legendre polynomial
%
% p - polynomial vector containing coefficients of the polynomial where the powers are in descending order
    
% base cases
if n == 0
    p = 1;
    return
end

if n == 1
    p = [1 0];
    return
end

p2 = zeros(1, n + 1);
p2(n + 1) = 1;
p1 = zeros(1, n + 1);
p1(n) = 1;

for i = 2:n
    p = zeros(1,n + 1);
    for j = n - i + 1:2:n
        p(j) = (2*i - 1) *p1(j + 1) + (1 - i)*p2(j);
    end
        
    p(n + 1) = p(n + 1) + (1 - i)*p2(n + 1);
    p = p / i;
        
    if i < n
        p2 = p1;
        p1 = p;
    end
end

return
end
