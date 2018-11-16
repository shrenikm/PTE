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
% [fig, ax] = initializeFigure2D('Cartpole', 'GridOn', [0, 20], [0, 10]);
% set(gcf, 'Position', [400, 100, 1200, 800]);
% daspect(ax, [1, 1, 1]);

x0 = [5; 0; 0; 0];
xf = [5; pi; 0; 0];
Dt = 0.1;

N = 60;

p = 1; %Size of inputs
assert(N-size(x0,1)-p>0);
direct_collocation_main(x0, xf, p, N, Dt, @dynamics_cartpole);

% % Getting the ode solution and simulating
% [t, y] = ode_integration(@dynamics_cartpole, [1:0.01:5], [10; 1.5; 0; 0], 0);
% simulate_ode(t, y, @draw_cartpole, ax);