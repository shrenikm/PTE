%Function to compute h and its derivative
function [h, dh] = compute_h_and_grad(z, nx, nu, N, Dt, dynamics)
    
    h = zeros(nx*(N-1), 1);
    dh = zeros(nx*(N-1), N*(nx + nu));
    
    for i=1:N-1
        
        x_curr = find_xi(i, z, nx, nu);
        x_next = find_xi(i+1, z, nx, nu);
        u_curr = find_ui(i, z, nx, nu);
        u_next = find_ui(i+1, z, nx, nu);
        
        [hi, dhi] = compute_hi_and_grad(...
            x_curr, x_next, u_curr, u_next, Dt, dynamics);
        
        h(nx*(i-1)+1: nx*i) = hi;
        dh((i-1)*nx+1:i*nx, (i-1)*(nx+nu)+1:(i+1)*(nx+nu)) = dhi;
        
    end

end