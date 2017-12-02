function [t, y] = midpointODE(f, t0, tn, y0, h)
%MIDPOINTODE Finding solutions to ODEs of the form dy/dx = f(x,y)
% using the Midpoint method
% Also known as Modified Euler's method
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

% create domain values
t = t0:h:tn;

% number of times we iterate
N = numel(t);

% initializing vector of solutions
y = zeros(size(t));

% setting initial value in solution vector
y(1) = y0;

% start iterating
for i = 1:N - 1
    y(i + 1) = y(i) + h*f(t(i) + (h/2), y(i) + (h/2)*f(t(i), y(i)));
end

plot(t,y)
grid on; legend('~ y(t)');
xlabel('t'); ylabel('y(t)');

return
end
