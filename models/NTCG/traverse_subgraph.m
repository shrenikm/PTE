% Traversing a sub graph from the start index to the goal (Not always to
% the end of a trajectory)

function [x_traverse, u_traverse] = traverse_subgraph(...
    start_index, goal_index, tg, ug, x_data)

    x_traverse = get_state_from_index(x_data, start_index);
    u_traverse = ug(start_index, :).';
    
    index = start_index;
    
    if start_index == goal_index
        x_traverse = get_state_from_index(x_data, start_index);
        u_traverse = ug(index, :).';
        return;
    end
    
    index1 = 0;
    index2 = 0;
    
    while true
        
        % Finding the node that it points to
        
        if start_index < goal_index
            % Moving forward in the graph
            index1 = find(tg(index, :) == 1);
        elseif start_index > goal_index
            % Moving backward in the graph is the start index is further in
            % the graph than the goal index
            index1 = find(tg(index, :) == -1);
        end
        
        % If the required end state is the last in the graph, the indicator
        % is 2. Catching this condition.
        index2 = find(tg(index, :) == 2);
        
        index = index1;
        if isempty(index1)
            index = index2;
        end
        
        x_traverse = [x_traverse, get_state_from_index(x_data, index)];
        u_traverse = [u_traverse, ug(index, :).'];
        
        % Break if the goal node is reached
        if index == goal_index
            break;
        end
        
    end

    

end