function [t, y] = kutta38ODE(f, t0, tn, y0, h)
%KUTTA38ODE Finding solutions to ODEs of the form dy/dx = f(x,y)
% using Kutta's 3/8 rule
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
y = zeros(1,N);

% initial value assignment
y(1) = y0;

% start of iteration
for i=1:N - 1
    m1 = h*f(t(i), y(i));
    m2 = h*f(t(i) + (h / 3), y(i) + (m1 / 3));
    m3 = h*f((t(i) + ((2*h)/3)), y(i) - (m1 / 3) + m2);
    m4 = h*f(t(i) + h, y(i) + m1 - m2 + m3);
    y(i + 1) = y(i) + (1/8)*(m1 + 3*m2 + 3*m3 + m4);
end

plot(t, y)
grid on; legend('~ y(t)');
xlabel('t'); ylabel('y(t)');

return
end
