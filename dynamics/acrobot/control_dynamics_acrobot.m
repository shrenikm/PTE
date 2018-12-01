% Dynamics function to execute after the optimization problem is solved.
% The final simulation is obtained after running ode using this. 
% It uses the 'u' trajectory solution

function dx = control_dynamics_acrobot(t, x, u, Dt, K, S, x_star, u_star, threshold)

    common_params = initialize_common_params();
    g = common_params.g;

    if (x-x_star)'*S*(x-x_star) < threshold
        u_x = u_star - K*(x-x_star);
    else
        interval = ceil(t/Dt);
        if interval == 0
            interval = 1;
        end
        if interval >= numel(u)
            interval = numel(u) - 1;
        end
        lambda = mod(t, Dt)/Dt;
        u_x = u(interval)*(1-lambda) + u(interval+1)*lambda;
    end
    
    dx = dynamics_acrobot(x, u_x);
end