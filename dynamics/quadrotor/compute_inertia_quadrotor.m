% Function to compute inertia of the quadrotor
function [I] = compute_inertia_quadrotor()

    % Obtaining quadrotor parameters
    quadrotor_params = initialize_quadrotor_params();
    l = quadrotor_params.length_frame/2;
    r = quadrotor_params.radius_motor;
    mass_cg = quadrotor_params.mass_cg;
    mass_motor = quadrotor_params.mass_motor;
    
    % We model the inertia of the motors as spheres
    inertia_motor = 2*mass_motor*(r^2)/5;
    
    Ix = inertia_motor + 2*mass_cg*l^2;
    Iy = inertia_motor + 2*mass_cg*l^2;
    Iz = inertia_motor + 4*mass_cg*l^2;
    
    I = [Ix, 0, 0;
         0, Iy, 0; 
         0, 0, Iz];

end