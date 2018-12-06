clear;
clc;

% Testing the passive simulaltion of the quadrotor with a given initial
% condition

% Adding the required paths
addpath(genpath('../tools/'));
addpath(genpath('../environments/'));
addpath(genpath('../dynamics/'));
addpath(genpath('../integration/'));
addpath(genpath('../params/'));


% Get figure and set size and position. Also setting equal aspect ratio
[fig, ax] = initializeFigure3D('Quadrotor', 'GridOn', [0, 20], [0, 20], [0, 20]);
set(gcf, 'Position', [400, 100, 1200, 800]);
daspect(ax, [1, 1, 1]);

% Getting the ode solution and simulating
phi = deg2rad(-30);
theta = deg2rad(20);
psi = deg2rad(11.5);

x0 = [10; 10; 10; phi; theta; psi; zeros(6, 1)];
u0 = [5; 5; 0; 0];

[t, y] = ode_integration(@dynamics_quadrotor, 1:0.01:5, x0, u0);
simulate_ode(t, y, @draw_quadrotor, ax);

