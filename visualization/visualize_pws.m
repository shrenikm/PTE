%% Function to visualize x obtained from pws model
% x_j corresponds to the results from the pws model
% x_traj corresponds to the original trajectory
% Dt corresponds to time interval between each knot point
% N correponds to the number of knot points

function visualize_pws(x_j, x_traj, Dt,N)
%     addpath(genpath('../models/PWS/'));   
    x = linspace(Dt, Dt*N, N);
    for i = 1:4
        subplot(2,2,i);
        y = x_j(i,:);
        plot(x,y, '*');
        hold on;
        plot(x, x_traj(i,:),'r');
    end
    
end
