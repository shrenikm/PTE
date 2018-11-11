% Computing the spline coefficients for a given time and i

function [s0, s1, s2, s3] = compute_spline_coefficients(i, z, n, p, N, Dt, dynamics)

    assert(i < N, 'Spline index out of bounds.');
    x_curr = find_xi(i, z, n, p);
    x_next = find_xi(i+1, z, n, p);
    u_curr = find_ui(i, z, n, p);
    u_next = find_ui(i+1, z, n, p);
    
    f_curr = dynamics(x_curr, u_curr);
    f_next = dynamics(x_next, u_next);
    
    s0 = x_curr;
    s1 = f_curr;
    s2 = (3*x_next - 3*x_curr - 2*Dt*f_curr - Dt*f_next)/(Dt^2);
    s3 = (Dt*f_next + Dt*f_curr + 2*x_curr - 2*x_next)/(Dt^3);

end