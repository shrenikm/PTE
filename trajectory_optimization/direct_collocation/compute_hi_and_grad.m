%Function to compute hi and its gradient
function [hi, dhi] = compute_hi_and_grad(x_curr, x_next, u_curr, u_next, Dt, dynamics)

    hi = compute_hi(x_curr, x_next, u_curr, u_next, Dt, dynamics);
    
    delta = 1e-8;
    dhi = zeros(numel(x_curr), 2*(numel(x_curr) + numel(u_curr)));
    
    for i=1:numel(x_curr)
        
        dx = zeros(numel(x_curr), 1);
        dx(i) = delta;
        dhi_curr = compute_hi(...
            x_curr + dx, x_next, u_curr, u_next, Dt, dynamics) - hi;   
        dhi_next = compute_hi(...
            x_curr, x_next + dx, u_curr, u_next, Dt, dynamics) - hi;
        dhi(:, i) = dhi_curr/delta;
        dhi(:, i + numel(x_curr) + numel(u_curr)) = dhi_next/delta;
        
    end
    
    for i=1:numel(u_curr)
        
        du = zeros(numel(u_curr), 1);
        du(i) = delta;
        dhi_curr = compute_hi(...
            x_curr, x_next, u_curr + du, u_next, Dt, dynamics) - hi;   
        dhi_next = compute_hi(...
            x_curr, x_next, u_curr, u_next + du, Dt, dynamics) - hi;
        dhi(:, i + numel(x_curr)) = dhi_curr/delta;
        dhi(:, i + 2*numel(x_curr) + numel(u_curr)) = dhi_next/delta;
        
        
    end
    
end