% Function to compute the A matrix after dynamics linearization
function [B] = B_cartpole(x_star, u_star)

    addpath(genpath('../params/'));
    cartpole_params = initialize_cartpole_params();
    common_params = initialize_common_params();
    
    mc = cartpole_params.mass_cart;
    mp = cartpole_params.mass_pole;
    l = cartpole_params.length;
    g = common_params.g;
    
    % Unrolling x_star and u_star
    q = x_star(1);
    theta = x_star(2);
    qdot = x_star(3);
    thetadot = x_star(4);
    u = u_star;
    
    K = mc + mp*(sin(theta)^2);
    
    b31 = 1/K;
    b41 = -cos(theta)/(l*K);
    
    B = [0;
         0;
         b31;
         b41];
    
end