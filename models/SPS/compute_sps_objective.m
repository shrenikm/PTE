% Function to compute the objective function for the sps model.
function [f] = compute_sps_objective(z, tp, x, u, nx, P, N)
    
    assert(numel(tp) == N, 'Incorrect tp dimension.');
    assert(numel(z) == (nx*nx*(P+1)), 'Incorrect z dimension.');
    assert(numel(x) == numel(u), 'x and u size mismatch.');
    assert(size(x{1}, 2) == N, 'Incorrect number of knot points in x.');
    
    M = numel(x);
    
    Lambda_h = reshape(z, nx, nx*(P+1));
    g = zeros(nx*(P+1), 1);
    f = 0;
    
    for i=1:M
        for j=1:N
            
            g = compute_sps_g_vector(x{i}(:, 1), tp(j), P);
            x_hat = Lambda_h*g;
            
            alpha = x_hat - x{i}(:, j);
            
            f = f + alpha.'*alpha;
            
        end
        
    end

end



