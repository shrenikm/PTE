% Script to run the pws model on the quadrotor
% Loads in pws solution for state and input and visualizes the pws model
clear;
clc;
close all;

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

% Flag to vary initial and goal positions for system.
%  If flag is set, random initial and final positions will be assigned,
%  else they will be extraced from trajectory data.
random_flag = 0;

% Specify trajectory to be visualized. Can be varied from 1:50.
traj_n = 11;

% Initialize number of knot points
N = size(x{1}, 2);

% %% Load in z_sol_state and reconstruct lambda and nu to get x_j
filepath = '';
filename_pws = 'pws_state_quadrotor_300000.mat';
load(strcat(filepath , filename_pws));

% Reconstruct lambda and nu 
lambda = [];
mu = [];
 for i=1:N
    % Computing mu and lambda
    lambda_temp = compute_pws_lambda(i, z_sol_state, nx);
    mu_temp = compute_pws_mu(i, z_sol_state, nx);
    
    lambda = [lambda ; lambda_temp];
    mu = [mu; mu_temp];
 end
    
% Reconstructing x based on lambda and mu
x_j = zeros(N*nx,1);

count = 1;
x0 = x{1,traj_n}(:,1);
for j = 1:N
    x_j(count:count+ nx-1,:) = lambda(count:count+nx-1, :)*x0 ...
        + mu(count:count+nx-1,:);
    count = count + nx;
end

% Reshaping x_j
x_j = reshape(x_j,  nx, N);

%% Load in z_sol_input and reconstruct sigma and eta to get u_j
filepath = '';
filename_pws = 'pws_input_quadrotor_300000.mat';
load(strcat(filepath , filename_pws));

% Reconstruct sigma and eta 
sigma = [];
eta = [];
 for i=1:N
    % Computing mu and lambda
    sigma_temp = compute_pws_sigma(i, z_sol_input, nu, nx);
    eta_temp = compute_pws_eta(i, z_sol_input, nu, nx);
    
    sigma = [sigma ; sigma_temp];
    eta = [eta; eta_temp];
 end

 % Reconstructing u based on sigma and eta
 u_j = zeros(N*nu, 1);

 x0 = x{1,traj_n}(:,1);
 
 count = 1;
 for j = 1:N
     u_j(count:count+nu-1,:) = sigma(count:count+nu-1,:)*x0...
         + eta(count:count + nu-1,:);
     count = count + nu;
 end

% Reshaping u_j
u_j = reshape(u_j,  nu, N);

%% Specify initial and final states based on random_flag
if random_flag
% Initial and final states assigned randomly
    x0 = [lrandom(5, 25);...
        lrandom(5, 25);...
        lrandom(5, 25);...
        lrandom(-pi/6, pi/6);...
        lrandom(-pi/6, pi/6);...
        lrandom(-pi/6, pi/6);...
        lrandom(-1,1); ...
        lrandom(-1,1); ...
        lrandom(-1,1);...
        lrandom(-0.05,0.05);...
        lrandom(-0.05,0.05);...
        lrandom(-0.05,0.05)];
    xf = x0;
    xf(4:12) = zeros(9,1);
else
    % Initial and final states from data
    x0 = x{1,traj_n}(:,1);
    xf = x{1,traj_n}(:,N);
end

% Other parameters for direct_collocation
Dt = T/N;
u_lower = -30;
u_upper = 30;

% Visualize x_j and u_j vs x and u from the data
visualize_pws(x_j, x{1,traj_n}, Dt, N, 'x');
visualize_pws(u_j, u{1,traj_n}, Dt, N, 'u');

disp('Start of results using direct collocation without pws');
%% Comparison of speed of direct collocation without initial x and u
z_sol_without_pws = direct_collocation_main(...
    x0, xf, nu, N, Dt, @dynamics_quadrotor, u_lower, u_upper, 1:nx);

disp('-----------------------------------------------------');
disp('Start of results using direct collocation with pws');
%% Comparison of speed of direct collocation without initial x and u
z_sol_pws = direct_collocation_main(...
    x0, xf, nu, N, Dt, @dynamics_quadrotor, u_lower, u_upper, 1:nx, x_j, u_j);