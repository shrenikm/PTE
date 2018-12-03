% Traversing a sub graph from the start index to the goal (Not always to
% the end of a trajectory)

function [x_traverse, u_traverse] = traverse_subgraph(...
    start_index, goal_index, tg, ug, x_data)

    x_traverse = get_state_from_index(x_data, start_index);
    u_traverse = ug(start_index, :).';
    index = start_index;
    
    while true
        
        % Finding the node that it points to
        index = find(tg(index, :) == 1);
%         disp(index);
        x_traverse = [x_traverse, get_state_from_index(x_data, index)];
        u_traverse = [u_traverse, ug(index, :).'];
        
        % Break if the goal node is reached
        if index == goal_index
            break;
        end
        
    end

    

end