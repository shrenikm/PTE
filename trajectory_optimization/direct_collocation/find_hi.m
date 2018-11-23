% Function to extract hi from z
function [hi] = find_hi(i, z, nx, nu)

    hi = z((nx + nu)*(i - 1) + 1: (nx + nu)*(i - 1) + nx + nu);

end