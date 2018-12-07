% Script to run the ntcg model on the cartpole (Full optimization)

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
filename = 'cartpole_data_1.mat';
load(strcat(filepath, filename));

nx = size(x{1}, 1);
nu = size(u{1}, 1);

% Generating the graph
[tg , ug] = generate_ntcg(x, u);

% Defining the query node
x_query = x{1}(:, 1) + [1; 0.1; 0; 0];
% x_query = [8; 0.5; 0; 0];
p = 2;

xf = [10; pi; 0; 0];
x_star = xf;
u_star = 0;
Q = eye(nx);
R = eye(nu);
beta = 1;

[K, S] = lqr(A_cartpole(x_star, u_star), B_cartpole(x_star, u_star), ...
    Q, R);

[min_distance, min_distance_ind, x_start, trajectory_index] = ...
    query_state(x_query, x, p, S, beta);
[x_traverse, u_traverse] = traverse_one_way(min_distance_ind, tg, ug, x);


% Solving the optimization problem with the transition
Nt = 2;
N = size(x_traverse, 2);
N_sol = Nt + N - 1; % -1 to not include x_start twice -- in transition and traversal

% T = 8;
% Dt = T/(Nt + N);

% Interpolation for the initial states between query and start
x_transition = zeros(nx, Nt - 1);
u_transition = zeros(nu, Nt - 1);

difference = (x_start - x_query)/(Nt-1);
for i=1:Nt - 1
    x_i_inds = (1:nx) + (nx + nu) * (i - 1);
    x_transition(:, i) = x_query + difference*(i-1); 
end

z_sol = direct_collocation_main(...
    x_query, xf, nu, N_sol, Dt, @dynamics_cartpole, -30, 30,...
    1:nx, xf, [x_transition, x_traverse], [u_transition, u_traverse]);

z_sol = reshape(z_sol, nx+nu, []);
x_sol = z_sol(1:end-1, :);
u_sol = z_sol(end, :);


% Simulation 

% % Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure2D('Cartpole', 'GridOn', [0, 20], [0, 10]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

% simulate_trajectory_position(...
%     x_sol, linspace(0, (N_sol - 1)*Dt, N_sol), @draw_cartpole, ax);


threshold = 10;
opts = odeset('MaxStep', 0.1, 'RelTol', 1e-4,'AbsTol', 1e-4);

[t_control_sol, x_control_sol] = ode45(@(t,x) control_dynamics_cartpole(...
    t, x, u_sol, Dt, K, S, x_star, u_star, threshold),...
    [0 Dt*(N_sol)*1.5], x_query, opts);

% The output of ode45 gives the individual x values in a row.
% We transpose as our plot assumes it to be placed column wise.
x_control_sol = x_control_sol.';

simulate_trajectory_position(...
    x_control_sol, t_control_sol, @draw_cartpole, ax);



