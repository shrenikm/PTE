%Function to compute h and its derivative
function [h, dh] = compute_h_and_grad(z, n, p, N, Dt, dynamics)
    
    h = zeros(n*(N-1), 1);
    dh = zeros((N-1)*n, N*(n + p));
    
    for i=1:N-1
        
        x_curr = find_xi(i, z, n, p);
        x_next = find_xi(i+1, z, n, p);
        u_curr = find_ui(i, z, n, p);
        u_next = find_ui(i+1, z, n, p);
        
        [hi, dhi] = compute_hi_and_grad(...
            x_curr, x_next, u_curr, u_next, Dt, dynamics);
        
        h(n*(i-1)+1: n*i) = hi;
        dh((i-1)*n+1:i*n, (i-1)*(n+p)+1:(i+1)*(n+p)) = dhi;
        
    end

end