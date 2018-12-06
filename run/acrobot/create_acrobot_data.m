% Script to create trajectory data for the acrobot

clear;
clc;

% Adding the required paths
addpath(genpath('../tools/'));
addpath(genpath('../data/'));
addpath(genpath('../environments/'));
addpath(genpath('../dynamics/'));
addpath(genpath('../trajectory_optimization/'));
addpath(genpath('../params/'));

M = 20;
N = 60;
T = 6;
Dt = T/N;
u_lower = -30;
u_upper = 30;
xlim = [0, 20];
filepath = '../data/';
filename = 'acrobot_data_1.mat';
x = {};
u = {};


for i=1:M
    
    fprintf('Iteration %d -----------------------------------------\n', i);

    x0 = [10; lrandom(-pi/2, pi/2); 0; 0];
    xf = [10; pi; 0; 0];
    x_star = xf;
    u_star = 0;

    nx = numel(x0);
    nu = 1; %Size of inputs
    assert(N-size(x0,1)-nu>0);

    z_sol = direct_collocation_main(...
        x0, xf, nu, N, Dt, @dynamics_acrobot, u_lower, u_upper, 1:nx, xf);

    fprintf('Initial state from solution:\n');
    disp(z_sol(1:nx));
    fprintf('Final state from solution:\n');
    disp(z_sol(end-nx-nu+1:end-nu));

    z_sol = reshape(z_sol, nx+nu, []);
    x_sol = z_sol(1:end-1, :);
    u_sol = z_sol(end, :);
    
    x(i) = {x_sol};
    u(i) = {u_sol};

    
end

save(strcat(filepath, filename), 'x', 'u', 'N', 'T', 'Dt');