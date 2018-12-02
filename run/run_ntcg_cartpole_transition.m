% Script to run the ntcg model on the cartpole (Just the initial
% transition)

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
% x_query = x{1}(:, 1) + [1; 0.1; 0; 0];
x_query = [10; 0.5; 0; 0];
p = 2;

[min_distance, min_distance_ind, x_start] = query_state(x_query, x, p);
[x_traverse, u_traverse] = traverse_one_way(min_distance_ind, tg, ug, x);


% Solving the optimization problem with the transition
Nt = 15;
N = size(x_traverse, 2);
N_sol = Nt + N;

% T = 8;
% Dt = T/(Nt + N);

xf = [10; pi; 0; 0];

% Interpolation for the initial states between query and start
x_transition = zeros(nx, Nt);
u_transition = zeros(nu, Nt);

difference = (x_start - x_query)/(Nt);
for i=1:Nt
    x_i_inds = (1:nx) + (nx + nu) * (i - 1);
    x_transition(:, i) = x_query + difference*(i-1); 
end

z_transition = direct_collocation_with_initial(...
    x_query, x_start, nu, Nt, Dt, @dynamics_cartpole, -30, 30,...
    x_transition, u_transition);


z_transition = reshape(z_transition, nx+nu, []);
x_transition = z_transition(1:end-1, :);
u_transition = z_transition(end, :);

x_sol = [x_transition, x_traverse];
u_sol = [u_transition, u_traverse];


% Simulation 

% % Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure2D('Cartpole', 'GridOn', [0, 20], [0, 10]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

% simulate_trajectory_position(...
%     x_sol, linspace(0, (N_sol - 1)*Dt, N_sol), @draw_cartpole, ax);


u_star = 0;
Q = eye(nx);
R = eye(nu);

[K_traverse, S_traverse] = lqr(A_cartpole(xf, u_star), B_cartpole(xf, u_star), ...
    Q, R);

threshold = 10;
opts = odeset('MaxStep', 0.1, 'RelTol', 1e-4,'AbsTol', 1e-4);

[t_control_sol, x_control_sol] = ode45(@(t,x) control_dynamics_cartpole(...
    t, x, u_sol, Dt, K_traverse, S_traverse, x_star, u_star, threshold),...
    [0 Dt*(N_sol)*1.5], x_query, opts);

% The output of ode45 gives the individual x values in a row.
% We transpose as our plot assumes it to be placed column wise.
x_control_sol = x_control_sol.';

simulate_trajectory_position(...
    x_control_sol, t_control_sol, @draw_cartpole, ax);



