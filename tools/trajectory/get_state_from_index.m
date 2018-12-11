% Function to take in the trajectory data and return the state given the
% index in the complete trajectory space

function [x_res] = get_state_from_index(x_data, index)

    M = length(x_data);
    k = 1;
    
    for i=1:M
        
        N = size(x_data{i}, 2);

        for j=1:N
            
            if k == index
                x_res = x_data{i}(:, j);
                return;
            end
            
            k = k + 1;
        end
        
    end

end