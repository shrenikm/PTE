% Script to save the pws z state model on the quadrotor
clear;
clc;

% Adding the required paths
addpath(genpath('../../../data/'));
addpath(genpath('../../../dynamics/'));
addpath(genpath('../../../environments/'));
addpath(genpath('../../../integration/'));
addpath(genpath('../../../models/'));
addpath(genpath('../../../params/'));
addpath(genpath('../../../trajectory_optimization/'));
addpath(genpath('../../../tools/'));
addpath(genpath('../../../visualization/'));

filepath = '';
filename = 'quadrotor_data_1.mat';
load(strcat(filepath, filename));

nx = size(x{1}, 1);
nu = size(u{1}, 1);

% Variables in the lambda matrices which we need to compute through
% optimization
z0 = rand((nu*nx+nu)*N,1);

%% Set variable for maxFunctionEvaluations
iterations = 50000;

% Options -------------------------------------------------------------
options = optimoptions('fmincon', ...
    'Display', 'iter', ...
    'MaxFunctionEvaluations', iterations, ...
    'StepTolerance', 1e-30, ...
    'OptimalityTolerance', 1e-30);

% -------------------------------------------------------------------------
%% Part corresponds to computation of u_j
problem.objective = @(z) compute_pws_objective_input(z, x, u, nx, nu, N);
problem.x0 = z0;
problem.options = options;
problem.solver = 'fmincon';

disp('Solving');

z_sol_input  = fmincon(problem);
filepath = '../../../data/';
filename_pws = 'pws_input_quadrotor_' + string(iterations) + '.mat';
save(strcat(filepath, filename_pws), 'z_sol_input');