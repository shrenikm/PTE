% Function to draw the cartpole on an input axis, given the state.

function [] = draw_acrobot(ax, x)

    % Adding paths and loading files  -------------------------------------
    addpath(genpath('../config/'));
    load('config_acrobot.mat', 'config_acrobot');
    load('config_color.mat', 'config_color');
    
    % Get required data ---------------------------------------------------
    % Obtain the figure limits
    x_limits = xlim(ax);
    y_limits = ylim(ax);
    x_min = x_limits(1);
    x_max = x_limits(2);
    y_min = y_limits(1);
    y_max = y_limits(2);

    %% Assigning the box center to be in the center of the plot for c/w and anti-c/w rotations

    x_start = 0.5*(x_max - x_min);
    y_start = 0.5*(y_max - y_min);
    
    % Unrolling state
    q = x(1:2);
    v = x(3:4);
    
    
    %% Program constants ---------------------------------------------------
    % Plot parameters (Visual placement)
    l_rect = 1; 
    b_rect = 0.5;
    rect_color = config_color.chrome;
    rect_thickness = 1.0;
    
    
%     Pole-1 parameters including color, thickness, radius, length, and angle of
%     pole
    pole_one_color = config_color.brown;
    pole_one_thickness = 2;
    mass_one_radius = 0.2;
    mass_one_color = config_color.brown;
    length_one = config_acrobot.length(1);
    theta_one = q(1);
    
%   Pole-2 paramaters including color, thickness, radius, length, and angle of
%     pole
    pole_two_color = config_color.brown;
    pole_two_thickness = 2;    
    mass_two_radius = 0.2;
    mass_two_color = config_color.brown;
    length_two = config_acrobot.length(2);
    theta_two = q(2);
    
    % Pole-1 location
    pole_one_tip_x = x_start + length_one*sin(theta_one);
    pole_one_tip_y = y_start - length_one*cos(theta_one); 

     % Pole-2 location
    pole_two_tip_x = pole_one_tip_x + length_two*sin(theta_one + theta_two);
    pole_two_tip_y = pole_one_tip_y - length_two*cos(theta_one + theta_two);
    
    
    %% Drawing -------------------------------------------------------------
%       Draw a rectangle indicating fixed hinge
    rectangle(ax, 'Position',[x_start-0.5*l_rect, y_start-0.5*b_rect, l_rect, b_rect],...
        'EdgeColor', rect_color,'LineWidth', rect_thickness);

    % Drawing pole-1
    line(ax, [x_start, pole_one_tip_x], ...
        [y_start, pole_one_tip_y], ...
        'Color', pole_one_color, 'LineWidth', pole_one_thickness);
    
    % Drawing  mass-1
    rectangle(ax, 'Position', [0.5*(x_start+ pole_one_tip_x) - mass_one_radius, ...
        0.5*(y_start + pole_one_tip_y) - mass_one_radius, 2*mass_one_radius, ...
        2*mass_one_radius], 'EdgeColor', mass_one_color, 'FaceColor', ...
        mass_one_color,'Curvature', [1, 1]);
    
    % Drawing pole-2
    line(ax, [pole_one_tip_x, pole_two_tip_x], ...
        [pole_one_tip_y, pole_two_tip_y], ...
        'Color', pole_two_color, 'LineWidth', pole_two_thickness);
    
    % Drawing  mass-2
    rectangle(ax, 'Position', [0.5*(pole_one_tip_x+ pole_two_tip_x) - mass_two_radius, ...
        0.5*(pole_one_tip_y + pole_two_tip_y) - mass_two_radius, ...
        2*mass_two_radius, 2*mass_two_radius], 'EdgeColor', mass_two_color,...
        'FaceColor', mass_two_color, 'Curvature', [1, 1]);
    
    
    
    
    
    