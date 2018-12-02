% Function to generate the Naive Trajectory Connectivity Graph

function [tg, ug] = generate_ntcg(x_data, u_data)

    % Number of trajectories
    M = length(x_data);
    
    % Obtaining the total number of nodes.
    % (This wont be M*N if each trajectory has different number of knot
    % points
    N = zeros(M, 1);
    for i=1:M
        N(i) = size(x_data{i}, 2);     
    end
        
    % Sparse representation of the graph
    tg = sparse(sum(N), sum(N));
    ug = zeros(sum(N), size(u_data{i}, 1));
    k = 2;
    for i=1:M
        
        for j=2:N(i)
            
            % Filling up the tg graph
            tg(k - 1, k) = 1;
            tg(k, k - 1) = -1;
            
            % Filling up the ug graph
            ug(k - 1, :) = u_data{i}(:, j - 1);
            
            if j == N(i)
                tg(k, k) = 2;
            end
            
            k = k + 1;       
             
        end
        
        % Filling up the last u
        ug(k - 1, :) = u_data{i}(:, N(i));
        
        % Handling the face that we don't traverse the first node in any
        % trajectory
        k = k + 1;
        
        
        
    end

end