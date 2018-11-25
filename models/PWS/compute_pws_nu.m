% Function to extract nu from z for the pws model
function [nu] = compute_pws_nu(ind, z, nx)

    nu = z(nx*nx*ind+nx*(ind-1)+1:nx*nx*ind+nx*(ind-1)+nx);

end