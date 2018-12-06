% Function to output the quadrotor parameters
function [quadrotor_params] = initialize_quadrotor_params()

   quadrotor_params = struct;
   quadrotor_params.length_frame = 4;
   quadrotor_params.radius_motor = 0.5;
   quadrotor_params.mass_cg = 1;
   quadrotor_params.mass_motor = 0.01;
   quadrotor_params.gamma = 1; % Ratio between the moment and force constant (motor)

end