% Function to extract xi from z
function [xi] = find_xi(i, z, nx, nu)

    xi = z((nx + nu)*(i - 1) + 1: (nx + nu)*(i - 1) + nx);

end