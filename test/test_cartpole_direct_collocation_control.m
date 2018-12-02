clear;
clc;

% Testing the passive simulaltion of the cartpole with a given initial
% condition

% Adding the required paths
addpath(genpath('../tools/'));
addpath(genpath('../environments/'));
addpath(genpath('../dynamics/'));
addpath(genpath('../integration/'));
addpath(genpath('../trajectory_optimization/'));
addpath(genpath('../params/'));

% % Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure2D('Cartpole', 'GridOn', [0, 20], [0, 10]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

x0 = [5; 0; 0; 1];
xf = [5; pi; 0; 0];
x_star = xf;
u_star = 0;

N = 60;
T = 6;
Dt = T/N;
u_lower = -30;
u_upper = 30;

nx = numel(x0);
nu = 1; %Size of inputs
assert(N-size(x0,1)-nu>0);

Q = eye(nx);
R = eye(nu);

z_sol = direct_collocation_main(...
    x0, xf, nu, N, Dt, @dynamics_cartpole, u_lower, u_upper);

fprintf('Initial state from solution:\n');
disp(z_sol(1:nx));
fprintf('Final state from solution:\n');
disp(z_sol(end-nx-nu+1:end-nu));

z_sol = reshape(z_sol, nx+nu, []);
x_sol = z_sol(1:end-1, :);
u_sol = z_sol(end, :);

[K, S] = lqr(A_cartpole(x_star, u_star), B_cartpole(x_star, u_star), ...
    Q, R);
threshold = 3;
opts = odeset('MaxStep', 0.1,'RelTol',1e-4,'AbsTol',1e-4);

[t_control_sol, x_control_sol] = ode45(@(t,x) control_dynamics_cartpole(...
    t, x, u_sol, Dt, K, S, x_star, u_star, threshold), [0 Dt*(N)*1.5], x0, opts);

% The output of ode45 gives the individual x values in a row.
% We transpose as our plot assumes it to be placed column wise.
x_control_sol = x_control_sol.';

simulate_trajectory_position(...
    x_control_sol, t_control_sol, @draw_cartpole, ax);













