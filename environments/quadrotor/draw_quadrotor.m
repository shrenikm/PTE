% Function to draw the quadrotor, given the state.

% x is the state vector (6x1)
function [] = draw_quadrotor(ax, x)

    % Loading cartpole params and loading files ---------------------------    
    quadrotor_params = initialize_quadrotor_params();
    color_params = initialize_color_params();
    
    % Unrolling state
    q = x(1:6);
    
    % Extracting position and orientation
    qp = q(1:3);
    qo = q(4:6);
    
    v = x(7:12);
    
    l = quadrotor_params.length;
    
    % Rotation matrix
    R = eul2rotm(qo.', 'XYZ');
    
    % Position of the frame ends
    frame_x_front = qp + R*([l/2; 0; 0]);
    frame_x_back = qp + R*([-l/2; 0; 0]);
    frame_y_front = qp + R*([0; l/2; 0]);
    frame_y_back = qp + R*([0; -l/2; 0]);
    

    % Drawing -------------------------------------------------------------
    hold on;
    
    % Drawing the frame
    line(ax, [frame_x_back(1), frame_x_front(1)], ...
        [frame_x_back(2), frame_x_front(2)], ...
        [frame_x_back(3), frame_x_front(3)], ...
        'Color', color_params.brown, ...
        'LineWidth', 3);
    
    line(ax, [frame_y_back(1), frame_y_front(1)], ...
        [frame_y_back(2), frame_y_front(2)], ...
        [frame_y_back(3), frame_y_front(3)], ...
        'Color', color_params.brown, ...
        'LineWidth', 3);
    
    % Drawing the rotors as spheres
    radius = 0.5;
    resolution = 10;
    [x_rotor1, y_rotor1, z_rotor1] = sphere(resolution);
    [x_rotor2, y_rotor2, z_rotor2] = sphere(resolution);
    [x_rotor3, y_rotor3, z_rotor3] = sphere(resolution);
    [x_rotor4, y_rotor4, z_rotor4] = sphere(resolution);
    
    surf(ax, radius*x_rotor1 + frame_x_front(1), ...
             radius*y_rotor1 + frame_x_front(2), ...
             radius*z_rotor1 + frame_x_front(3), ...
             'FaceColor', color_params.turquoise, ...
             'EdgeColor', color_params.turquoise);
         
    surf(ax, radius*x_rotor2 + frame_y_front(1), ...
             radius*y_rotor2 + frame_y_front(2), ...
             radius*z_rotor2 + frame_y_front(3), ...
             'FaceColor', color_params.turquoise, ...
             'EdgeColor', color_params.turquoise);
         
    surf(ax, radius*x_rotor3 + frame_x_back(1), ...
             radius*y_rotor3 + frame_x_back(2), ...
             radius*z_rotor3 + frame_x_back(3), ...
             'FaceColor', color_params.turquoise, ...
             'EdgeColor', color_params.turquoise);
         
    surf(ax, radius*x_rotor4 + frame_y_back(1), ...
             radius*y_rotor4 + frame_y_back(2), ...
             radius*z_rotor4 + frame_y_back(3), ...
             'FaceColor', color_params.turquoise, ...
             'EdgeColor', color_params.turquoise);
         


end