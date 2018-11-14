% Function to extract hi from z
function [z] = insert_hi(i, hi, z, n, p)

    z((n + p)*(i - 1) + 1: (n + p)*(i - 1) + n + p) = hi;

end