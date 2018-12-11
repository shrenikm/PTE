% Returning the closest node to the query start node.

function [min_distance, min_distance_ind, x_start, trajectory_index] = query_state(...
    x_query, x_data, p)

    % We find the closest point according to the p norm
    M = length(x_data);
    
    x_delta_init = x_query - x_data{1}(:, 1);
    
    min_distance = norm(x_delta_init, p);
    
    min_distance_ind = 1;
    k = 1;
    trajectory_index = 1;
    
    for i=1:M
        
        N = size(x_data{i}, 2);
        
        for j=1:N
            
            x_delta = x_query - x_data{i}(:, j);
                 
            distance = norm(x_delta, p);
            if distance < min_distance

               min_distance = distance;
               min_distance_ind = k;
               trajectory_index = i;
               
            end
            
            k = k + 1;
            
        end
        
    end  
    
    x_start = get_state_from_index(x_data, min_distance_ind);
    
end