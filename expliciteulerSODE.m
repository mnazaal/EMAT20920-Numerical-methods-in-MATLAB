function [t, slist] = expliciteulerSODE(f, t0, tn, y0, h)
%EXPLICITEULERSODE Finding solutions to systems of ODEs
%
%   inputs :
%   f = the vector ODE from R^4 -> R^3 , where f(t,x) = [f_1(t,x);f_2(t,x);f_3(t,x)]
%   and x is a 3x1 column vector 
%   t0, tn = time boundary to approximate the solution for
%   y0 = 3x1 column vector representing the initial state of the system
%   h = step size 
%
%   outputs :
%   t = column vector with time increments where t(i) = t0 + i*h
%   slist = matrix where the i'th column is the value of the solution at time t(i)

% create domain values
t = t0:h:tn;

% number of times we iterate
N = numel(t);

% intialize matrix to store solution values
slist = zeros(3, N); 

% set initial condition
slist(:,1) = y0;

% start iterating
for i = 1:N - 1
    slist(:, i + 1) = slist(:, i) + h*f(t(i), slist(:, i));
end

plot(t, slist(1, :), 'r', t, slist(2, :), 'b', t, slist(3, :), 'k')
grid on; legend('~ x(t)','~ y(t)','~ z(t)');
xlabel('t'); ylabel('f');

return
end
