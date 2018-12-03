% Finding the closest node to a query node in a given trajectory

function [min_distance, min_distance_ind, x_start] = query_state_in_trajectory(...
    x_query, x_data, p, trajectory_index)

    % We find the closest point according to the p norm
    M = length(x_data);
    
    
    min_distance = norm((x_query - x_data{trajectory_index}(:, 1)), p);
    min_distance_ind = 0;
    
    % Computing the index of the first node in the trajectory
    for i=1:trajectory_index-1
        min_distance_ind = min_distance_ind + size(x_data{i}, 2);
    end
    min_distance_ind = min_distance_ind + 1;
    
    k = 1;
    
    for i=1:M
        
        N = size(x_data{i}, 2);
        
        for j=1:N
            
            if i==trajectory_index
            
                distance = norm((x_query - x_data{i}(:, j)), p);
                if distance < min_distance

                   min_distance = distance;
                   min_distance_ind = k;

                end
            end
            
            k = k + 1;
            
        end
        
    end
    
    x_start = get_state_from_index(x_data, min_distance_ind);

end