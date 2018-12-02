% Function to compute the A matrix after dynamics linearization
function [A] = A_cartpole(x_star, u_star)

    addpath(genpath('../params/'));
    cartpole_params = initialize_cartpole_params();
    common_params = initialize_common_params();
    
    mc = cartpole_params.mass_cart;
    mp = cartpole_params.mass_pole;
    l = cartpole_params.length;
    g = common_params.g;
    
    q = x_star(1:2);
    qdot = x_star(3:4);

    H = [mc + mp, mp*l*cos(q(2)); mp*l*cos(q(2)), mp*l*l];
    dG = [0, 0; 
          0, -mp*g*l];
     
    A = [0, 0, 1, 0;
         0, 0, 0, 1;
         -inv(H)*dG, zeros(2, 2)];   

end