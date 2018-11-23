% Function to extract hi from z
function [z] = insert_hi(i, hi, z, nx, nu)

    z((nx + nu)*(i - 1) + 1: (nx + nu)*(i - 1) + nx + nu) = hi;

end