clear;
clc;

% Testing the draw_quadrotor function

% Adding the required paths
addpath(genpath('../tools/'));
addpath(genpath('../environments/'));

% Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure3D('Quadrotor', 'GridOn', [0, 20], [0, 20], [0, 20]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

phi = deg2rad(-30);
theta = deg2rad(20);
psi = deg2rad(11.5);

draw_quadrotor(ax, [5; 5; 5; phi; theta; psi; zeros(6, 1)]);