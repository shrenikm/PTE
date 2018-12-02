% Function for the dynamics of the dubin model

function [xddot] = dynamics_dubin(x, u)

    % Loading initial parameters related to cartpole and color ------------
    dubin_params = initialize_dubin_params();
    common_params = initialize_common_params();
    
    % Unrolling constants -------------------------------------------------
    q = x(1:3);
    qdot = x(4:6);
    v = dubin_params.velocity;
    g = common_params.g;
    
    qddot = [-v*sin(q(3))*qdot(3); 
             v*cos(q(3))*qdot(3);
             0];
    qddot = [0; 0; 0];
    qdot = [v*cos(q(3)); 
            v*sin(q(3)); 
            u];
    
    xddot = [qdot; qddot];
    
end
    
   
    
