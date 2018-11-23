% Computing all the non linear constraints
function [c, ceq, dc, dceq] = compute_nonlcon(z, nx, nu, N, Dt, dynamics)
   
    [ceq, dceq] = compute_h_and_grad(z, nx, nu, N, Dt, dynamics);
    
    c = zeros(0, 1);
    dc = zeros(0,numel(z));
    
    dc = sparse(dc)';
    dceq = sparse(dceq)';
    
end
    

