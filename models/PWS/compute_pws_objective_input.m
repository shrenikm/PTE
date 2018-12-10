% Function to compute the objective function for the pws model for input state.
function [f] = compute_pws_objective_input(z, x, u, nx, nu, N)
    
    assert(numel(z) == (nu*nx*N + nu*N), 'Incorrect z dimension.');
    assert(numel(x) == numel(u), 'x and u size mismatch.');
    assert(size(x{1}, 2) == N, 'Incorrect number of knot points in x.');
    
    M = numel(x);
    
    f = 0;
    
    for i=1:M
        for j=1:N
            
            % Computing nu and lambda
            sigma = compute_pws_sigma(j, z, nu, nx);
            eta = compute_pws_eta(j, z, nu, nx);
            
            u_hat = sigma*x{i}(:, 1) + eta;
            
            alpha = u_hat - u{i}(:, j);
            
            f = f + alpha.'*alpha;
            
        end
        
    end

end



