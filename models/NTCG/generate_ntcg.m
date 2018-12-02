% Function to generate the Naive Trajectory Connectivity Graph

function [tg, ug] = generate_ntcg(x_data, u_data)

    % Number of trajectories
    M = length(x_data);
    
    % Sparse representation of the graph
    tg = sparse(0);
    ug = [];
    k = 2;
    for i=1:M
        
        N = size(x_data{i}, 2);
        for j=2:N
            
            tg(j-1, j) = 1;
            tg(j, j-1) = -1;
            
            ug = [ug; [k-1, k, u_data{i}(:, j - 1)]];
            k = k + 1;
             
        end
        
    end

end