% Script to create trajectory data for the dubin's car model

clear;
clc;

% Adding the required paths
addpath(genpath('../tools/'));
addpath(genpath('../data/'));
addpath(genpath('../environments/'));
addpath(genpath('../dynamics/'));
addpath(genpath('../trajectory_optimization/'));
addpath(genpath('../params/'));

M = 2;
N = 60;
T = 6;
Dt = T/N;
u_lower = -30;
u_upper = 30;
xlim = [0, 20];
filepath = '../data/';
filename = 'dubin_data_1.mat';
x = {};
u = {};

% Initial trajectory that we want
x0 = [5; 5; 0; 0; 0; 0];
xf = [10; 10; pi/2; 0; 0; 0];
nx = numel(x0);
nu = 1; %Size of inputs
assert(N-size(x0,1)-nu>0);

% z_sol = direct_collocation_position(...
%     x0, xf, p, N, Dt, @dynamics_dubin, u_lower, u_upper, 1:);
z_sol = direct_collocation_main(...
    x0, xf, nu, N, Dt, @dynamics_dubin, u_lower, u_upper, 1:nx/2, xf(1:nx/2,:));

fprintf('Initial state from solution:\n');
disp(z_sol(1:nx));
fprintf('Final state from solution:\n');
disp(z_sol(end-nx-nu+1:end-nu));

z_sol = reshape(z_sol, nx+nu, []);
x_sol = z_sol(1:end-1, :);
u_sol = z_sol(end, :);

x(1) = {x_sol};
u(1) = {u_sol};


for i=2:M+1
    
    fprintf('Iteration %d -----------------------------------------\n', i);

    x0 = [lrandom(3, 7); lrandom(3, 7); lrandom(-pi/2, pi/2); 0; 0; 0];
    xf = [lrandom(7, 15); lrandom(7, 15); lrandom(-pi/2, pi/2); 0; 0; 0];
    nx = numel(x0);
    nu = 1; %Size of inputs
    assert(N-size(x0,1)-nu>0);

    z_sol = direct_collocation_main(...
        x0, xf, nu, N, Dt, @dynamics_dubin, u_lower, u_upper, 1:nx/2, xf(1:nx/2,:));

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