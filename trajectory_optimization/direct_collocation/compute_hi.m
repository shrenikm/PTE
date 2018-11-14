%Function to compute hi
function [hi] = compute_hi(x_curr, x_next, u_curr, u_next, Dt, dynamics)

    [s, sdot] = compute_spline_value(...
        x_curr, x_next, u_curr, u_next, Dt/2, Dt, dynamics);

    hi = sdot - dynamics(s, 0.5*(u_curr + u_next));
    
end