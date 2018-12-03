% Function to extract sigma from z for the pws model

function [sigma] = compute_pws_sigma(ind, z, nu, nx )

    sigma_vector = z((ind-1)*nx + ind : ind*nx + (ind-1));
    sigma = reshape(sigma_vector, nu, nx);

end