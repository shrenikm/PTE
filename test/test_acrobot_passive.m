clear;
clc;

% Testing the passive simulaltion of the cartpole with a given initial
% condition

% Adding the required paths
addpath(genpath('../tools/'));
addpath(genpath('../environments/'));
addpath(genpath('../dynamics/'));
addpath(genpath('../integration/'));
addpath(genpath('../params/'));

% Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure2D('Acrobot', 'GridOn', [0, 20], [0, 10]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

% Getting the ode solution and simulating
x0  = [pi/6; 0; 0; 0];
[t, y] = ode_integration(@dynamics_acrobot, [1:0.01:5], x0 , 0);
simulate_ode(t, y, @draw_acrobot, ax);

