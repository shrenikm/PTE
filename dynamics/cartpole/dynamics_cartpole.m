% Function for the dynamics of the cartpole model

function [xddot] = dynamics_cartpole(x, u)

    % Loading initial parameters related to cartpole and color ------------
    cartpole_params = initialize_cartpole_params();
    common_params = initialize_common_params();
    
    % Unrolling constants -------------------------------------------------
    q = x(1:2);
    qdot = x(3:4);
    mc = cartpole_params.mass_cart;
    mp = cartpole_params.mass_pole;
    l = cartpole_params.length;
    g = common_params.g;
    
    H = [mc + mp, mp*l*cos(q(2)); mp*l*cos(q(2)), mp*l*l];
    C = [0, -mp*l*qdot(2)*sin(q(2)); 0, 0];
    G = [0; mp*g*l*sin(q(2))];
    B = [1; 0];
    
    qddot = H\(B*u - G - C*qdot);
    xddot = [qdot; qddot];
    
end
    
   
    
