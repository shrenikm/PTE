% Function to draw the cartpole on an input axis, given the state.

function [] = draw_dubin(ax, x)

    % Loading cartpole params and loading files ---------------------------    
    dubin_params = initialize_dubin_params();
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
    q = x(1:3);
    v = x(4:6);
     
    c = dubin_params.size;

    % Pole location
    x1 = q(1) + c*cos(q(3));
    y1 = q(2) + c*sin(q(3));
    
    x2 = q(1) - c*cos(q(3) - pi/3);
    y2 = q(2) - c*sin(q(3) - pi/3);
    
    x3 = 3*q(1) - x1 - x2;
    y3 = 3*q(2) - y1 - y2;

    % Drawing -------------------------------------------------------------
    hold on;
    
    % Drawing the car
    patch(ax, [x1, x2, x3], [y1, y2, y3], color_params.chrome);
    
    x4 = q(1) + q(1)*cos(q(3));
    y4 = q(2) + q(2)*sin(q(3));
    
    % Drawing the front of the car as a point
    in = plot(ax, x1, y1, 'k.', 'MarkerSize', 20);

    
    
    
    
    
    