%% Function to visualize x obtained from pws model
% x_j corresponds to the results from the pws model
% x_traj corresponds to the original trajectory
% Dt corresponds to time interval between each knot point
% N correponds to the number of knot points
% type corresponds to the string indicating what z_j contains. 'u'
% corresponds to input u_j, whereas 'x' corresponds to state x_j.

function visualize_pws(z_j, x_traj, Dt,N, type)

    figure;
    
    x = linspace(Dt, Dt*N, N);
  
    plots = size(z_j,1);
    
    for i = 1:plots
        
        if plots>2
            subplot(2, plots/2, i);
        end

        y = z_j(i,:);
        plot(x,y, '*');
        hold on;
        plot(x, x_traj(i,:),'r');
        
        
        if type == 'x'        
            if i <= plots/2 
                title('q' + string(i) + ' vs t');
            else
                title('q' + string(i-plots/2) + ' dot vs t');
            end
        else
            title('u' + string(i) + ' vs t');
        end
        legend('PWS', 'Data');
    end
    
end
