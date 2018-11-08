% Simulate the results of ode outputs. It is general to any model

function [] = simulate_ode(t, y, draw, ax)

    % Adding the required paths
    addpath(genpath('../environments/'));
    
    for i=1:length(t)
        
        % Drawing the corresponding model
        draw(ax, y(i, :).');
        
        t_start = tic;
        
        if i == length(t)
            break;
        end
        
        % Pausing for the appropriate time
        pause(t(i + 1) - t(i) - toc(t_start));
        
        % Clearing axis manually as hold off doesn't seem to work
        cla(ax);
        
    end
    
end
    
    
