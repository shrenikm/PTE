%% Function to visualize x obtained from pws model
% x_j corresponds to the results from the pws model
% x_traj corresponds to the original trajectory
% Dt corresponds to time interval between each knot point
% N correponds to the number of knot points

function visualize_pws(z_j, x_traj, Dt,N)

    x = linspace(Dt, Dt*N, N);
    
    plots = size(z_j,1);
    for i = 1:plots
        
        if plots == 4
                subplot(2,2,i);
        end

        y = z_j(i,:);
        plot(x,y, '*');
        hold on;
        plot(x, x_traj(i,:),'r');
    end
    
end
