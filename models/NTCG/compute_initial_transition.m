% Function to compute the initial transition from the query state to the
% closest state in the graph

function [] = compute_initial_transition(x_query, x_start, nu, N, Dt)

    z_sol = direct_collocation_main(...
        x_query, x_start, nu, N, Dt, dynamics, u_lower, u_upper);

end