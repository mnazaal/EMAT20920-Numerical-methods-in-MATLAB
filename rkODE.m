function [t, y] = rkODE(f, t0, tn, y0, h)
%RKODE Finding solutions to ODEs of the form dy/dx = f(x,y)
% using the classical Runge-Kutta method of order 4
%
%   inputs :
%   f = the differential equation f(x,y) where dy/dx = f(x,y)
%   t0, tn = the boundarys where you wish to approximate the solution for
%   y0 = initial value at y(x0) where y is the solution of the ODE
%   h = step size 
%
%   outputs :
%   t = domain values
%   y = approximations to the solution of the ODE at given initial condition

% assign domain values with respect to given boundary and step size
t = t0:h:tn;

% number of iterations needed
N = numel(t);

% initialize vector for solutions
y = zeros(1, N);

% initial value assignment
y(1) = y0;

% start of iteration
for i=1:N - 1
    m1 = f(t(i), y(i));
    m2 = f(t(i) + 0.5 * h, y(i) + 0.5 * h * m1);
    m3 = f(t(i) + 0.5 * h, y(i) + 0.5 * h * m2);
    m4 = f(t(i) + h, y(i) + m3 * h);
    y(i + 1) = y(i) + (h/6)*(m1 + 2*m2 + 2*m3 + m4);
end

plot(t, y)
grid on; legend('~ y(t)');
xlabel('t'); ylabel('y(t)');

return
end
