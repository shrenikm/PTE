% Script to run the sps model on the acrobot
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
filename = 'acrobot_data_1.mat';
load(strcat(filepath, filename));

nx = size(x{1}, 1);
nu = size(u{1}, 1);
P = 10;

% Variables in the lambda matrices which we need to compute through
% optimization
z0 = rand(nx*nx*(P+1), 1)*0.000001;
tp = 0:Dt:Dt*(N-1);

% f = compute_sps_objective(z, tp, x, u, nx, P, N);

% Options -------------------------------------------------------------
options = optimoptions('fmincon', ...
    'Display', 'iter', ...
    'MaxFunctionEvaluations', 100000, ...
    'StepTolerance', 1e-30, ...
    'OptimalityTolerance', 1e-30);

problem.objective = @(z) compute_sps_objective(z, tp, x, u, nx, P, N);
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
