% Script to run the ntcg model on the dubin (Initial and final transition)

clear;
clc;

% Adding the required paths
addpath(genpath('../../../data/'));
addpath(genpath('../../../dynamics/'));
addpath(genpath('../../../environments/'));
addpath(genpath('../../../integration/'));
addpath(genpath('../../../models/'));
addpath(genpath('../../../params/'));
addpath(genpath('../../../trajectory_optimization/'));
addpath(genpath('../../../tools/'));

filepath = '';
filename = 'dubin_data_1.mat';
load(strcat(filepath, filename));

nx = size(x{1}, 1);
nu = size(u{1}, 1);

% Generating the graph
[tg, ug] = generate_ntcg(x, u);

% Defining the query node
x_start_query = [6; 6; pi/2; 0; 0; 0];
x_goal_query = [10; 10; 0; 0; 0; 0;];
p = 2;

S = 0;

[min_distance_goal, min_distance_goal_ind, x_goal, trajectory_index] = ...
    query_state(x_goal_query, x, p);
[min_distance_start, min_distance_start_ind, x_start] = ...
    query_state_in_trajectory(...
    x_start_query, x, p, trajectory_index);

[x_traverse, u_traverse] = traverse_subgraph(...
    min_distance_start_ind, min_distance_goal_ind, tg, ug, x);


% Solving the optimization problem with the transition
Nt_start = 7;
Nt_goal = 7;
N = size(x_traverse, 2);
N_sol = Nt_start + N + Nt_goal;

% T = 8;
% Dt = T/(Nt + N);

xf = x_goal_query;

fprintf('Regular optimization\n');
z_regular = direct_collocation_main(...
    x_start_query, x_goal_query, nu, N, Dt, @dynamics_dubin, -30, 30, 1:nx/2);

fprintf('NTCG optimization\n');
z_start_transition = direct_collocation_main(...
    x_start_query, x_start, nu, Nt_start, Dt, @dynamics_dubin, -30, 30, 1:nx/2);

z_goal_transition = direct_collocation_main(...
   x_goal, x_goal_query, nu, Nt_start, Dt, @dynamics_dubin, -30, 30, 1:nx/2);

z_start_transition = reshape(z_start_transition, nx+nu, []);
z_goal_transition = reshape(z_goal_transition, nx+nu, []);
x_start_transition = z_start_transition(1:end-1, :);
u_start_transition = z_start_transition(end, :);
x_goal_transition = z_goal_transition(1:end-1, :);
u_goal_transition = z_goal_transition(end, :);

x_sol = [x_start_transition, x_traverse, x_goal_transition];
u_sol = [u_start_transition, u_traverse, u_goal_transition];


% Simulation 

% % Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure2D('Dubin', 'GridOn', [0, 20], [0, 20]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

simulate_trajectory_position(...
    x_sol, linspace(0, (N_sol - 1)*Dt, N_sol), @draw_dubin, ax);



