% Function to compute the objective function for the pws model.
function [f] = compute_pws_objective(z, x, u, nx, N)
    
    assert(numel(z) == (nx*nx*N + nx*N), 'Incorrect z dimension.');
    assert(numel(x) == numel(u), 'x and u size mismatch.');
    assert(size(x{1}, 2) == N, 'Incorrect mumber of knot points in x.');
    
    M = numel(x);
    
    f = 0;
    
    for i=1:M
        for j=1:N
            
            % Computing mu and lambda
            lambda = compute_pws_lambda(j, z, nx);
            mu = compute_pws_mu(j, z, nx);
            
            x_hat = lambda*x{i}(:, 1) + mu;
            
            alpha = x_hat - x{i}(:, j);
            
            f = f + alpha.'*alpha;
            
        end
        
    end

end



