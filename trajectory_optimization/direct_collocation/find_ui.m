% Function to extract ui from z
function [ui] = find_ui(i, z, n, p)

    ui = z((n + p)*(i - 1) + n + 1: (n + p)*(i - 1) + n + p);

end