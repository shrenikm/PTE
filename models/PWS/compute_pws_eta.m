% Function to extract mu from z for the pws model
function [eta] = compute_pws_eta(ind, z, nu, nx)
    
%     eta = z(nu*nx*(ind-1)+nx*(ind-1)+ nx + 1:nu*nx*(ind-1)+nx*(ind-1)+ nu*nx + nx);
    eta = z(ind*nx + ind,:);

end