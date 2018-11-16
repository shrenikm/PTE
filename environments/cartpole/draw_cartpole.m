% Function to draw the cartpole on an input axis, given the state.

function [] = draw_cartpole(ax, x)

    % Loading cartpole params and loading files ---------------------------    
    cartpole_params = initialize_cartpole_params();
    color_params = initialize_color_params();
    
    % Get required data ---------------------------------------------------
    % Obtain the figure limits
    x_limits = xlim(ax);
    y_limits = ylim(ax);
    x_min = x_limits(1);
    x_max = x_limits(2);
    y_min = y_limits(1);
    y_max = y_limits(2);
    width = x_max - x_min;
    height = y_max - y_min;
    
    % Unrolling state
    q = x(1:2);
    v = x(3:4);
    
    
    % Program constants ---------------------------------------------------
    % Plot parameters (Visual placement)
    ground_height = 5;
    ground_color = 'black';
    ground_thickness = 2;
    cart_width = 1;
    cart_height = 0.7;
    cart_color = color_params.chrome;
    cart_thickness = 1.5;
    pole_color = color_params.brown;
    pole_thickness = 2;
    mass_radius = 0.2;
    mass_color = color_params.brown;
    
    % Pole location
    pole_tip_x = q(1) + cartpole_params.length*sin(q(2));
    pole_tip_y = ground_height + cart_height/2 - ...
        cartpole_params.length*cos(q(2));
    
    % Drawing -------------------------------------------------------------
    % Drawing the cart
    rectangle(ax, 'Position', [q(1) - cart_width/2, ground_height, ...
        cart_width, cart_height], 'EdgeColor', cart_color, ...
        'LineWidth', cart_thickness);
    
        % Drawing the ground
    line(ax, [x_min, x_max], [ground_height, ground_height], ...
        'Color', ground_color, 'LineWidth', ground_thickness);
   
    % Drawing the pole
    line(ax, [q(1), pole_tip_x], ...
        [ground_height + cart_height/2, pole_tip_y], ...
        'Color', pole_color, 'LineWidth', pole_thickness);
    
    % Drawing the mass
    rectangle(ax, 'Position', [pole_tip_x - mass_radius, ...
        pole_tip_y - mass_radius, 2*mass_radius, 2*mass_radius], ...
        'EdgeColor', mass_color, 'FaceColor', mass_color, ...
        'Curvature', [1, 1]);

    
    
    
    
    
    