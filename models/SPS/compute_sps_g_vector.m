% Function to compute the g vector using the current time value
function [g] = compute_sps_g_vector(x0, t,P)
    
    nx = numel(x0);
    g = zeros(nx*(P+1), 1);
    for p=1:P+1
        
        g(nx*(p-1)+1:nx*p) = x0*t^(P-1);
        
    end

end