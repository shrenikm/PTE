%Function to compute the non linear constraints
function [c, ceq] = compute_h(z, n, p, N, Dt, dynamics)
    
    ceq = zeros(n*(N-1), 1);
    c = zeros(n*(N-1), 1);
    for i=1:N-1
        
        [s, sdot] = compute_spline_value(i, Dt/2, z, n, p, N, Dt, dynamics);
        u_curr = find_ui(i, z, n, p);
        u_next = find_ui(i+1, z, n, p);
        ceq(n*(i-1)+1: n*i) = sdot - dynamics(s, 0.5*(u_curr + u_next));
        
    end

    

end