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
x_star = xf;
u_star = 0;

N = 60;
T = 12;
Dt = T/N;
u_lower = -30;
u_upper = 30;

nx = numel(x0);
nu = 1; %Size of inputs
assert(N-size(x0,1)-nu>0);

Q = eye(nx);
R = eye(nu);
 
z_sol = direct_collocation_main(...
	x0, xf, nu, N, Dt, @dynamics_acrobot, u_lower, u_upper, 1:nx, xf);

fprintf('Initial state:\n');
disp(z_sol(1:nx));
fprintf('Final state:\n');
disp(z_sol(end-nx-nu+1:end-nu));

z_sol = reshape(z_sol, nx+nu, []);
z_sol = z_sol(1:end-1, :);
u_sol = z_sol(end, :);

simulate_trajectory_position(...
   z_sol, linspace(0, (N-1)*Dt, N), @draw_acrobot, ax);
