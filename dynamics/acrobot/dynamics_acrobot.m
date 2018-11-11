function [xdot] = dynamics_acrobot(x, u)

% Adding paths and loading files  -------------------------------------
addpath(genpath('../data/'));
load('config_acrobot.mat', 'config_acrobot');
load('config_common.mat', 'config_common');

% Unrolling constants
q = x(1:2);
qdot = x(3:4);
g = config_common.g;

% Pole one mass, length, length of com, moment of inertia
m1 = config_acrobot.mass(1);
l1 = config_acrobot.length(1);
lc1 = l1/2;
I1 = compute_inertia(m1, l1);
theta_1 = q(1);

% Pole two mass, length, length of com, moment of inertia
m2 = config_acrobot.mass(2);
l2 = config_acrobot.length(2);
lc2 = l2/2;
I2 = compute_inertia(m2, l2);
theta_2 = q(2);

%% Manipulator equations
H = [I1 + I2 + m2*l1*l1 + 2*m2*l1*lc2*cos(theta_2), I2 + m2*l1*lc2*cos(theta_2); ...
    I2 + m2*l1*lc2*cos(theta_2),       I2];

C = [-2*m2*l1*lc2*sin(theta_2)*qdot(2),-m2*l1*lc2*sin(theta_2)*qdot(2);...
    m2*l1*lc2*sin(theta_2)*qdot(1),    0];

G = [(m1*lc1 + m2*l1)*g*sin(theta_1) + m2*g*l2*sin(theta_1 + theta_2);...
    m2*g*l2*sin(theta_1 + theta_2)];

B = [1;
    0];

qddot = H\(B*u - C*qdot - G);
xdot = [qdot;qddot];
end
