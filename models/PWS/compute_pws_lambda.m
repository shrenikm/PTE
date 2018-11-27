% Function to extract lambda from z for the pws model

function [lambda] = compute_pws_lambda(ind, z, nx)

    lambda_vector = z(nx*nx*(ind-1)+nx*(ind-1)+1:nx*nx*(ind-1)+nx*(ind-1)+nx*nx);
    lambda = reshape(lambda_vector, nx, nx);

end