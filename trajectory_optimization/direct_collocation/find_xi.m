% Function to extract xi from z
function [xi] = find_xi(i, z, n, p)

    xi = z((n + p)*(i - 1) + 1: (n + p)*(i - 1) + n);

end