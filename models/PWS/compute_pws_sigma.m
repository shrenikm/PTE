% Function to extract sigma from z for the pws model

function [sigma] = compute_pws_sigma(ind, z, nu, nx )
    
    sigma_vector = z((ind-1)*(nu*nx + nu) + 1 : (ind-1)*(nu*nx + nu) + nx*nu);
    sigma = reshape(sigma_vector, nu, nx);

end