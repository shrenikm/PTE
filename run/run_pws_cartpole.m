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
addpath(genpath('../visualization/'));

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
    'MaxFunctionEvaluations', 50000, ...
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

% z_sol = fmincon(problem);
filepath = '';
% filename_pws = 'cartpole_pws_10000.mat';
filename_pws = 'cartpole_pws_50000.mat';
load(strcat(filepath , filename_pws));
% 
%% Reconstruct lambda and nu for visualization
lambda = [];
nu = [];
 for i=1:N
    % Computing nu and lambda
    lambda_temp = compute_pws_lambda(i, z_sol, nx);
    nu_temp = compute_pws_nu(i, z_sol, nx);
    
    lambda = [lambda ; lambda_temp];
    nu = [nu; nu_temp];
 end
    
%% Visualization of x based on lambda
M = size(x,2);
x_j = zeros(N*4,1);

% for j = 1:M
count = 1;
traj_n = 11;
x0 = x{1,traj_n}(:,1);
for j = 1:N
    x_j(count:count+3,:) = lambda(count:count+3, :)*x0 + nu(count:count+3,:);
    count = count + 4;
end
x_j = reshape(x_j,  4, size(x_j,1)/4);

visualize_pws(x_j, x{1,traj_n}, Dt, N);