%Integration using ode45. This is common to all models

function [t, y] = ode_integration(dynamics, tspsan, y0, u)

    [t, y] = ode45(@(t, y) dynamics(y, u), tspsan, y0);
    
end

    