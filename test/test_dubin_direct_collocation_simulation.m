clear;
clc;

% Testing the passive simulaltion of the dubin model with a given initial
% condition

% Adding the required paths
addpath(genpath('../tools/'));
addpath(genpath('../environments/'));
addpath(genpath('../dynamics/'));
addpath(genpath('../integration/'));
addpath(genpath('../trajectory_optimization/'));
addpath(genpath('../params/'));

% % Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure2D('Cartpole', 'GridOn', [0, 20], [0, 20]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

x0 = [5; 5; 0; 0; 0; 0];
x0 = [10; 10; pi/2; 0; 0; 0];
xf = [12; 12; 0; 0; 0; 0];
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
    x0, xf, nu, N, Dt, @dynamics_dubin, u_lower, u_upper, 1:nx/2, xf(1:nx/2, :));

fprintf('Initial state from solution:\n');
disp(z_sol(1:nx));
fprintf('Final state from solution:\n');
disp(z_sol(end-nx-nu+1:end-nu));

z_sol = reshape(z_sol, nx+nu, []);
x_sol = z_sol(1:end-1, :);
u_sol = z_sol(end, :);

simulate_trajectory_position(...
    x_sol, linspace(0, (N-1)*Dt, N), @draw_dubin, ax);














