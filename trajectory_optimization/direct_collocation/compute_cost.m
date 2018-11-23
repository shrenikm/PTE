function [g, dg] = compute_cost(z, nx, nu, N, Dt)

    % Initialize cost
    g = 0;
    dg = zeros(N*(nx + nu), 1);

    for i=1:N-1

        u_curr= find_ui(i, z, nx, nu);
        u_next = find_ui(i+1, z, nx, nu);
        g = g + 0.5*Dt*(u_curr^2 + u_next^2);

        u_curr_inds = (1:nu) + nx * i + nu * (i - 1);
        u_next_inds = (1:nu) + nx * (i+1) + nu * i;

        %Updating cost gradient
        dg(u_curr_inds) = dg(u_curr_inds) + u_curr*Dt;
        dg(u_next_inds) = dg(u_next_inds) + u_next*Dt;

    end
    
end