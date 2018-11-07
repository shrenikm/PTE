clear;
clc;
% Testing the draw_acrobot function

% Adding the required paths
addpath(genpath('../tools/'));
addpath(genpath('../environments/'));

% Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure2D('Acrobot', 'GridOn', [0, 20], [0, 10]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

draw_acrobot(ax, [pi/6, pi/3, 0, 0]);