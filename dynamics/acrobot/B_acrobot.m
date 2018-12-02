% Function to compute the B matrix after dynamics linearization
function [B] = B_acrobot(x_star, u_star)
        addpath(genpath('../params/'));
        acrobot_params = initialize_acrobot_params();
        common_params = initialize_common_params();
        
        % Pole one parameters
        m1 = acrobot_params.mass(1);
        l1 = acrobot_params.length(1);
        I1 = compute_inertia(m1, l1);
        lc1 = 0.5*l1;
        
        % Pole two parameters
        m2 = acrobot_params.mass(2);
        l2 = acrobot_params.length(2);
        I2 = compute_inertia(m2, l2);
        lc2 = 0.5*l2;
        
        g = common_params.g;
        
        % Unrolling x_star and u_star
        theta1 = x_star(1);
        theta2 = x_star(2);
        
        H = [I1 + I2 + m2*l1*l1 + 2*m2*l1*lc2*cos(theta2), I2+ m2*l1*lc2*cos(theta2);
             I2+ m2*l1*lc2*cos(theta2), I2];

        H_inv = inv(H); 
        b = [0; 1];
        B = [0;
            0;
            H_inv*b];

        
    end
    

