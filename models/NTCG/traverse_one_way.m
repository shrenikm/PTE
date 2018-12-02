% Function to traverse the graph from a given index

function [x_traverse, u_traverse] = traverse_one_way(...
    index, tg, ug, x_data)

    x_traverse = get_state_from_index(x_data, index);
    u_traverse = ug(index, :).';
    
    while true
        
        % Break if we reached the final node
        if find(tg(index, :) == 2)
            break;
        end
        
        % Finding the node that it points to
        index = find(tg(index, :) == 1);
        x_traverse = [x_traverse, get_state_from_index(x_data, index)];
        u_traverse = [u_traverse, ug(index, :).'];
        
    end

    

end