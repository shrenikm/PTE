% Script to run the ntcg model on the cartpole

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

% Generating the graph
[tg , ug] = generate_ntcg(x, u);

% Defining the query node
x_query = x{1}(:, 35);
p = 2;

[min_distance, min_distance_ind] = query_state(x_query, x, p);
[x_traverse, u_traverse] = traverse_one_way(min_distance_ind, tg, ug, x);



