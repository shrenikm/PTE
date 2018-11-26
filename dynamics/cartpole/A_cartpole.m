% Function to compute the A matrix after dynamics linearization
function [A] = A_cartpole(x_star, u_star)

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
    
    a32 = (K*(mp*cos(theta)*l*thetadot^2 + mp*g*cos(2*theta)) - ...
        (u + mp*sin(theta)*(l*thetadot^2 + g*cos(theta)))*(mp*sin(2*theta)))/(K^2);
    a34 = mp*sin(theta)*2*l*thetadot/K;
    a42 = (l*K*(u*sin(theta) - mp*l*thetadot^2*cos(2*theta) - (mc+mp)*g*cos(theta)) + ...
        (u*cos(theta) + mp*l*thetadot^2*cos(theta)*sin(theta) + (mc + mp)*g*sin(theta))* ...
        (l*mp*sin(2*theta)))/(l^2*K^2);
    a44 = (-mp*sin(2*theta)*thetadot)/(K);
    
    A = [0, 0, 1, 0;
         0, 0, 0, 1;
         0, a32, 0, a34;
         0, a42, 0, a44];
    

end