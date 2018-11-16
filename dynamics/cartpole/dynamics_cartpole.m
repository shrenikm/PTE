% Function for the dynamics of the cartpole model

function [xddot] = dynamics_cartpole(x, u)

    % Adding paths and loading files  -------------------------------------
    %addpath(genpath('../data/'));
    load('config_cartpole.mat', 'config_cartpole');
    load('config_common.mat', 'config_common');
    
    % Unrolling constants -------------------------------------------------
    q = x(1:2);
    qdot = x(3:4);
    mc = config_cartpole.mass_cart;
    mp = config_cartpole.mass_pole;
    l = config_cartpole.length;
    g = config_common.g;
    
    H = [mc + mp, mp*l*cos(x(2)); mp*l*cos(x(2)) mp*l*l];
    C = [0, -mp*l*x(4)*sin(x(2)); 0, 0];
    G = [0; mp*g*l*sin(x(2))];
    B = [1; 0];
    
    qddot = H\(B*u - G - C*qdot);
    xddot = [qdot; qddot];
    
end
    
   
    
