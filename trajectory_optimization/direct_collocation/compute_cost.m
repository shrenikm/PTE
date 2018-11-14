function [g, dg] = compute_cost(z, n, p, N, Dt)

% Initialize cost
g = 0;
dG = zeros(N*(n + p),1);

for i=1:N-1
    u_current = find_ui(i, z, n, p);
    u_next = find_ui(i+1, z, n, p);
    g = g + 0.5*Dt*(u_current^2 + u_next^2);
    
    u_i_inds = (1:p) + n * i + p * (i - 1);
    u_ip1_inds = (1:p) + n * (i+1) + p * i;
    
    u_i = z(u_i_inds);
    u_ip1 = z(u_ip1_inds);
    
    %Updating cost gradient
    dG(u_i_inds) = dG(u_i_inds) + u_i*Dt;
    dG(u_ip1_inds) = dG(u_ip1_inds) + u_i*Dt;
    
end
end