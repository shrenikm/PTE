clear;
clc;

% Testing the draw_dubin function

% Adding the required paths
addpath(genpath('../tools/'));
addpath(genpath('../environments/'));

% Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure2D('Dubin', 'GridOn', [0, 20], [0, 20]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

draw_dubin(ax, [5; 5; 0; 0; 0; 0]);