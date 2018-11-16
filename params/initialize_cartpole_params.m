% Function to output the cartpole parameters
function [cartpole_params] = initialize_cartpole_params()

   cartpole_params = struct;
   cartpole_params.length = 2;
   cartpole_params.mass_cart = 1;
   cartpole_params.mass_pole = 1;

end