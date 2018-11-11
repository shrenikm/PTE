function [g] = compute_cost(z, n, p, N, Dt)

% Initialize cost
g = 0;

for i=1:N-1
    u_current = find_ui(i, z, n, p);
    u_next = find_ui(i+1, z, n, p);
    g = g + 0.5*Dt*(u_current + u_next);
end
end