function [g, dg] = compute_cost(z, n, p, N, Dt)

% Initialize cost
g = 0;
dg = zeros(N*(n + p), 1);

for i=1:N-1
    
    u_curr= find_ui(i, z, n, p);
    u_next = find_ui(i+1, z, n, p);
    g = g + 0.5*Dt*(u_curr^2 + u_next^2);
    
    u_curr_inds = (1:p) + n * i + p * (i - 1);
    u_next_inds = (1:p) + n * (i+1) + p * i;
    
    
    %Updating cost gradient
    dg(u_curr_inds) = dg(u_curr_inds) + u_curr*Dt;
    dg(u_next_inds) = dg(u_next_inds) + u_next*Dt;
    
end
end