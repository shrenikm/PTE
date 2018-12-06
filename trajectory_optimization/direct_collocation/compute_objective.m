function [f, df] = compute_objective(z, nx, nu, N, Dt)

    % Initialize cost
    f = 0;
    df = zeros(N*(nx + nu), 1);

    for i=1:N-1

        u_curr= find_ui(i, z, nx, nu);
        u_next = find_ui(i+1, z, nx, nu);
        f = f + 0.5*Dt*(u_curr.'*u_curr + u_next.'*u_next);

        u_curr_inds = (1:nu) + nx * i + nu * (i - 1);
        u_next_inds = (1:nu) + nx * (i+1) + nu * i;

        %Updating cost gradient
        df(u_curr_inds) = df(u_curr_inds) + u_curr*Dt;
        df(u_next_inds) = df(u_next_inds) + u_next*Dt;

    end
    
end