clear;
clc;

% Adding the required paths
addpath(genpath('../tools/'));
addpath(genpath('../environments/'));
addpath(genpath('../dynamics/'));
addpath(genpath('../integration/'));
addpath(genpath('../trajectory_optimization/'));
addpath(genpath('../params/'));

% % Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure2D('Acrobot', 'GridOn', [0, 20], [0, 10]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

x0 = [1; 0; 0; 0];
xf = [pi; 0; 0; 0];
Dt = 0.1;

N = 60;

n = numel(x0);
p = 1; %Size of inputs
assert(N-size(x0,1)-p>0);
z_sol = direct_collocation_main(x0, xf, p, N, Dt, @dynamics_acrobot);

fprintf('Initial state:\n');
disp(z_sol(1:n));
fprintf('Final state:\n');
disp(z_sol(end-n-p+1:end-p));

disp(z_sol);
z_sol = reshape(z_sol, n+p, []);
z_sol = z_sol(1:end-1, :);
disp(z_sol);

simulate_trajectory_position(...
    z_sol, linspace(0, (N-1)*Dt, N), @draw_acrobot, ax);

% % Getting the ode solution and simulating
% [t, y] = ode_integration(@dynamics_cartpole, [1:0.01:5], [10; 1.5; 0; 0], 0);
% simulate_ode(t, y, @draw_cartpole, ax);