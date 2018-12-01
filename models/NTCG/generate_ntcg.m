%Function to generate the Naive Trajectory Connectivity Graph

function [tg] = generate_ntcg(trajectory_data)

    % Number of trajectories
    M = length(trajectory_data);
    
    % Sparse representation of the graph
    tg = sparse(0);
    
    for i=1:M
        
        N = size(trajectory_data{i}, 2);
        
        % We add all the trajectory points at once to make it more
        % efficient
        row_ind = [];
        col_ind = [];
        
        for j=2:N
            
            tg(j-1, j) = 1;
            tg(j, j-1) = -1;
            
        end
        
    end

    


end