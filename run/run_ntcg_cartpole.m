% Script to run the ntcg model on the cartpole

clear;
clc;

% Adding the required paths
addpath(genpath('../data/'));
addpath(genpath('../dynamics/'));
addpath(genpath('../environments/'));
addpath(genpath('../integration/'));
addpath(genpath('../models/'));
addpath(genpath('../params/'));
addpath(genpath('../trajectory_optimization/'));
addpath(genpath('../tools/'));

filepath = '';
filename = 'cartpole_data_1.mat';
load(strcat(filepath, filename));

nx = size(x{1}, 1);
nu = size(u{1}, 1);

% Generating the graph
[tg , ug] = generate_ntcg(x, u);

% Defining the query node
x_query = x{1}(:, 1);
p = 2;

[min_distance, min_distance_ind] = query_state(x_query, x, p);
[x_traverse, u_traverse] = traverse_one_way(min_distance_ind, tg, ug, x);

x_traverse = x{2};
u_traverse = u{2};

N_traverse = size(x_traverse, 2);

% Simulation 

% % Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure2D('Cartpole', 'GridOn', [0, 20], [0, 10]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

% simulate_trajectory_position(...
%     x_traverse, linspace(0, (N_traverse - 1)*Dt, N_traverse), @draw_cartpole, ax);

xf = [5; pi; 0; 0];
x_star = xf;
u_star = 0;
Q = eye(nx);
R = eye(nu);

[K, S] = lqr(A_cartpole(x_star, u_star), B_cartpole(x_star, u_star), ...
    Q, R);

threshold = 1;
opts = odeset('MaxStep', 0.1, 'RelTol', 1e-4,'AbsTol', 1e-4);

[t_control_sol, x_control_sol] = ode45(@(t,x) control_dynamics_cartpole(...
    t, x, u_traverse, Dt, K, S, x_star, u_star, threshold),...
    [0 Dt*(N_traverse)*1.5], x_traverse(:, 1), opts);

% The output of ode45 gives the individual x values in a row.
% We transpose as our plot assumes it to be placed column wise.
x_control_sol = x_control_sol.';

simulate_trajectory_position(...
    x_control_sol, t_control_sol, @draw_cartpole, ax);



