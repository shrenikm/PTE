% Function for the dynamics of the quadrotor model

function [xddot] = dynamics_quadrotor(x, u)

    % Loading initial parameters related to cartpole and color ------------
    quadrotor_params = initialize_quadrotor_params();
    common_params = initialize_common_params();
    
    % Unrolling constants -------------------------------------------------
    q = x(1:6);
    
    % Position and orientation
    qp = q(1:3);
    qo = q(4:6);
    
    % Linear and angular velocities
    v = x(7:12);
    vp = v(1:3);
    vo = v(4:6);
    
    % Torque inputs
    u1 = u(1);
    u2 = u(2);
    u3 = u(3);
    u4 = u(4);
    
    mass_cg = quadrotor_params.mass_cg;
    l = quadrotor_params.length_frame/2;
    gamma = quadrotor_params.gamma;
    g = common_params.g;
    
    % Rotation matrix
    R = eul2rotm(qo.', 'XYZ');
    
    % Inertia tensor
    I = compute_inertia_quadrotor();
    
    % Total thrust and moment
    thrust = sum(u);
    moment = [0, l, 0, -l; 
              -l, 0, l, 0; 
              gamma, -gamma, gamma, -gamma]*u;
    
    
    % Linear acceleration
    qpddot = [0; 0; -g] + (R/mass_cg)*[0; 0; thrust];
    
    % Angular acceleration
    qoddot = I\(moment - cross(vo, I*vo));
    
    qddot = [qpddot; qoddot];
    
    
    xddot = [v; qddot];
    
end
    
   
    
