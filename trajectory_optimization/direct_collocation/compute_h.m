%Function to compute the non linear constraints
function [c, ceq] = compute_h(z, p, n, N, Dt, dynamics)
    
    h = zeros(N-1);
    for i=1:N
        
        [s, sdot] = compute_spline_value(i, Dt/2, z, n, p, N, Dt, dynamics);
        
    end

    

end