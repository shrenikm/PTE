clear;
clc;

% Adding the required paths
addpath(genpath('../tools/'));
addpath(genpath('../environments/'));
addpath(genpath('../dynamics/'));
addpath(genpath('../integration/'));
addpath(genpath('../trajectory_optimization/'));
addpath(genpath('../params/'));

% Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure3D('Quadrotor', 'GridOn', [0, 30], [0, 30], [0, 30]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

% Initial and final conditions
phi_0 = deg2rad(-30);
theta_0 = deg2rad(20);
psi_0 = deg2rad(11.5);
phi_f = deg2rad(0);
theta_f = deg2rad(0);
psi_f = deg2rad(0);

x0 = [10; 10; 10; phi_0; theta_0; psi_0; zeros(6, 1)];
xf = [2; 2; 3; phi_f; theta_f; psi_f; zeros(6, 1)];
x_star = xf;
u_star = 0;

N = 60;
T = 6;
Dt = T/N;
u_lower = -30;
u_upper = 30;

nx = numel(x0);
nu = 4; %Size of inputs
assert(N-size(x0,1)-nu>0);

Q = eye(nx);
R = eye(nu);

 
z_sol = direct_collocation_main(...
	x0, xf, nu, N, Dt, @dynamics_quadrotor, u_lower, u_upper);

fprintf('Initial state:\n');
disp(z_sol(1:nx));
fprintf('Final state:\n');
disp(z_sol(end-nx-nu+1:end-nu));

z_sol = reshape(z_sol, nx+nu, []);
z_sol = z_sol(1:end-1, :);
u_sol = z_sol(end, :);

simulate_trajectory_position(...
   z_sol, linspace(0, (N-1)*Dt, N), @draw_quadrotor, ax);

