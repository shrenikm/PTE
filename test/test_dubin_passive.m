clear;
clc;

% Testing the passive simulaltion of the dubin with a given initial
% condition

% Adding the required paths
addpath(genpath('../tools/'));
addpath(genpath('../environments/'));
addpath(genpath('../dynamics/'));
addpath(genpath('../integration/'));
addpath(genpath('../params/'));


% Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure2D('Cartpole', 'GridOn', [0, 20], [0, 20]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

% Getting the ode solution and simulating
[t, y] = ode_integration(@dynamics_dubin, 1:0.01:5, [2; 2; 0; 0; 0; 0], 1);
simulate_ode(t, y, @draw_dubin, ax);

