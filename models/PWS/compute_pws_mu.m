% Function to extract mu from z for the pws model
function [mu] = compute_pws_mu(ind, z, nx)

    mu = z(nx*nx*ind+nx*(ind-1)+1:nx*nx*ind+nx*(ind-1)+nx);

end