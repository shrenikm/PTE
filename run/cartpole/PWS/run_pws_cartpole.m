% Script to run the pws model on the cartpole
% Loads in pws solution for state and input and visualizes the pws model
clear;
clc;
close all;

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

% Specify trajectory to be visualized
traj_n = 1;

% %% Load in z_sol_state and reconstruct lambda and nu to get x_j
filepath = '';
filename_pws = 'pws_z_state_cartpole_50000.mat';
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
x_j = zeros(N*4,1);

count = 1;
x0 = x{1,traj_n}(:,1);
for j = 1:N
    x_j(count:count+3,:) = lambda(count:count+3, :)*x0 + mu(count:count+3,:);
    count = count + 4;
end

% Reshaping x_j
x_j = reshape(x_j,  nx, size(x_j,1)/nx);

%% Load in z_sol_input and reconstruct sigma and eta to get u_j
filepath = '';
filename_pws = 'pws_z_input_cartpole_50000.mat';
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
 u_j = zeros(N,1);
 
 x0 = x{1,traj_n}(:,1);
 
 for j = 1:N
     u_j(j,:) = sigma(j,:)*x0 + eta(j,:);
 end

% Reshaping u_j
u_j = u_j';

% Initial and final states from data
x0 = x{1,traj_n}(:,1);
xf = x{1,traj_n}(:,N);

% Initial and final states assigned randomly
% x0 = [1; 0; -2; 2];
% xf = [5; pi; 0; 0];

% Other parameters for direct_collocation
Dt = T/N;
u_lower = -30;
u_upper = 30;
nu = 1; %Size of inputs

% Visualize x_j and u_j vs x and u from the data
% visualize_pws(x_j, x{1,traj_n}, Dt, N);
% visualize_pws(u_j, u{1,traj_n}, Dt, N);

u_j = zeros(1,N);
%% Comparison of speed of direct collocation with and without initial x and u
z_sol_pws = direct_collocation_main(...
    x0, xf, nu, N, Dt, @dynamics_cartpole, u_lower, u_upper, x_j, u_j);
z_sol_without_pws = direct_collocation_main(...
    x0, xf, nu, N, Dt, @dynamics_cartpole, u_lower, u_upper);