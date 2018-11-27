% Script to run the pws model on the cartpole
clear;
clc;

% Adding the required paths
addpath(genpath('../data/'));
addpath(genpath('../dynamics/'));
addpath(genpath('../environments/'));
addpath(genpath('../integration/'));
addpath(genpath('../models/'));
addpath(genpath('../params/'));
addpath(genpath('../trajectory_optimization/'));
addpath(genpath('../tools/'));

filepath = '';
filename = 'cartpole_data_1.mat';
load(strcat(filepath, filename));

nx = size(x{1}, 1);
nu = size(u{1}, 1);

% Variables in the lambda matrices which we need to compute through
% optimization
z0 = rand(nx*nx*N + nx*N, 1);

% Options -------------------------------------------------------------
options = optimoptions('fmincon', ...
    'Display', 'iter', ...
    'MaxFunctionEvaluations', 100000, ...
    'StepTolerance', 1e-30, ...
    'OptimalityTolerance', 1e-30);

problem.objective = @(z) compute_pws_objective(z, x, u, nx, N);
problem.x0 = z0;
problem.options = options;
% problem.nonlcon = @(z) compute_nonlcon(z, n, nu, N, Dt, dynamics);
problem.solver = 'fmincon';
% problem.Aeq = Aeq;
% problem.beq = beq;
% problem.lb = lb;
% problem.ub = ub;

disp('Solving');

z_sol = fmincon(problem);
