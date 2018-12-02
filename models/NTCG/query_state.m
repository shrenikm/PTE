% Returning the list of states and inputs for the query state

function [min_distance, min_distance_ind] = query_state(x_query, x_data, p)

    % We find the closest point according to the p norm
    M = length(x_data);
    
    
    min_distance = norm((x_query - x_data{1}(:, 1)), p);
    min_distance_ind = 1;
    k = 1;
    
    for i=1:M
        
        N = size(x_data{i}, 2);
        
        for j=1:N
            
            distance = norm((x_query - x_data{i}(:, j)), p);
            if distance < min_distance

               min_distance = distance;
               min_distance_ind = k;
               

            end
            
            k = k + 1;
            
        end
        
    end

end