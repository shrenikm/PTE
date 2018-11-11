% Function to extract ui from z
function [xi] = find_ui(i, z, n, p, N)

    xi = z((n + p)*(i - 1) + n + 1: (n + p)*(i - 1) + n + p);

end