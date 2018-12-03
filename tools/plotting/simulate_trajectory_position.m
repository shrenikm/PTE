% Simulate the results of ode outputs. It is general to any model
function [] = simulate_trajectory_position(q, t, draw, ax, folder)

    % Adding the required paths
    addpath(genpath('../environments/'));
    
%     Folder = fullfile(pwd, folder);
    Folder = fullfile('~/Desktop/results/', folder);
    for i=1:length(t)
        
        % Drawing the corresponding model
        draw(ax, q(:, i));
        FileName = [string(i) + '.png'];
        
        % Uncomment to save folders
%         saveas(ax, fullfile(Folder, FileName));
            
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
    
    
